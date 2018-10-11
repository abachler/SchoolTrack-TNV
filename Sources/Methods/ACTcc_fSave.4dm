//%attributes = {}
  //ACTcc_fSave

$0:=0
If (USR_checkRights ("M";->[ACT_CuentasCorrientes:175]))
	  //If (KRL_RegistroFueModificado (->[ACT_CuentasCorrientes]) | (campopropio))  //ABC 20180123 //198018 
	
	  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
	If (KRL_RegistroFueModificado (->[ACT_CuentasCorrientes:175]) | (vb_guardarCambios))
		If ([ACT_CuentasCorrientes:175]ID_Alumno:3#0)
			If ([ACT_CuentasCorrientes:175]Estado:4#Old:C35([ACT_CuentasCorrientes:175]Estado:4))
				LOG_RegisterEvt ("Cambio de estado de cuenta corriente "+[Alumnos:2]apellidos_y_nombres:40)
			End if 
			If ([ACT_CuentasCorrientes:175]Matriculado:29#Old:C35([ACT_CuentasCorrientes:175]Matriculado:29))
				LOG_RegisterEvt ("Cambio manual en condición de "+ST_Qte ("Matriculado")+" para el alumno "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]apellidos_y_nombres:40)+". Cambió de "+ST_Boolean2Str (Old:C35([ACT_CuentasCorrientes:175]Matriculado:29);"Verdadero";"Falso")+" a "+ST_Boolean2Str ([ACT_CuentasCorrientes:175]Matriculado:29;"Verdadero";"Falso"))
			End if 
			  //20120723 RCH Log de cambio de fecha
			If ([ACT_CuentasCorrientes:175]Matriculado_el:54#Old:C35([ACT_CuentasCorrientes:175]Matriculado_el:54))
				LOG_RegisterEvt ("Asignación de fecha de matrícula, desde la ficha de la Cuenta Corriente, para el alumno "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]apellidos_y_nombres:40)+". Cambió de "+String:C10(Old:C35([ACT_CuentasCorrientes:175]Matriculado_el:54))+" a "+String:C10([ACT_CuentasCorrientes:175]Matriculado_el:54)+".")
			End if 
			If ([ACT_CuentasCorrientes:175]AfectoIntereses:28)
				SAVE RECORD:C53([ACT_CuentasCorrientes:175])
				READ WRITE:C146([Personas:7])
				QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
				[Personas:7]ACT_AfectoIntereses:64:=True:C214
				SAVE RECORD:C53([Personas:7])
				READ ONLY:C145([ACT_Apoderados_de_Cuenta:107])
				QUERY:C277([ACT_Apoderados_de_Cuenta:107];[ACT_Apoderados_de_Cuenta:107]ID_CtaCte:2=[ACT_CuentasCorrientes:175]ID:1)
				KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Apoderados_de_Cuenta:107]ID_Apoderado:1;"")
				APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_AfectoIntereses:64:=True:C214)
				KRL_UnloadReadOnly (->[Personas:7])
			Else 
				SAVE RECORD:C53([ACT_CuentasCorrientes:175])
				$cta:=Record number:C243([ACT_CuentasCorrientes:175])
				$idApdo:=[ACT_CuentasCorrientes:175]ID_Apoderado:9
				SET QUERY DESTINATION:C396(Into set:K19:2;"ctasApdo")
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=$idApdo)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				READ ONLY:C145([ACT_Apoderados_de_Cuenta:107])
				QUERY:C277([ACT_Apoderados_de_Cuenta:107];[ACT_Apoderados_de_Cuenta:107]ID_Apoderado:1=$idApdo)
				KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Apoderados_de_Cuenta:107]ID_CtaCte:2;"")
				CREATE SET:C116([ACT_CuentasCorrientes:175];"exApdos")
				UNION:C120("ctasApdo";"exApdos";"ctasApdo")
				USE SET:C118("ctasApdo")
				SET_ClearSets ("exApdos";"ctasApdo")
				SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
				QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]AfectoIntereses:28=True:C214)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				READ WRITE:C146([Personas:7])
				QUERY:C277([Personas:7];[Personas:7]No:1=$idApdo)
				[Personas:7]ACT_AfectoIntereses:64:=($recs>0)
				SAVE RECORD:C53([Personas:7])
				KRL_UnloadReadOnly (->[Personas:7])
				GOTO RECORD:C242([ACT_CuentasCorrientes:175];$cta)
			End if 
			
			C_BOOLEAN:C305(vbACT_CambioModoPago)
			If (Old:C35([ACT_CuentasCorrientes:175]id_modo_de_pago:32)#[ACT_CuentasCorrientes:175]id_modo_de_pago:32)
				LOG_RegisterEvt ("Cambio en modo de pago de cuenta corriente "+[Alumnos:2]apellidos_y_nombres:40+". Modo de pago cambió de: "+ST_Qte (String:C10(Old:C35([ACT_CuentasCorrientes:175]id_modo_de_pago:32)))+" a "+ST_Qte (String:C10([ACT_CuentasCorrientes:175]id_modo_de_pago:32))+"."+ST_Boolean2Str (vbACT_CambioModoPago;" Cambio realizado manualmente desde ficha de la cuenta corriente.";""))
			End if 
			vbACT_CambioModoPago:=False:C215
			[ACT_CuentasCorrientes:175]PAT_num_t_c:38:=ACTpp_CRYPTTC ("xxACT_SetCryptTC";->[ACT_CuentasCorrientes:175]PAT_num_t_c:38;->[ACT_CuentasCorrientes:175]x_Pass:52)
			
			
			  //20160720 RCH
			  //Guarda descuentos individuales
			ACTcc_OpcionesDctos ("OnSavingCtaCte")
			
			  //20170622 RCH
			ACTcc_DividirEmision ("ArmaObjetoCtas";->[ACT_CuentasCorrientes:175]o_pct_emision:56;->aPersID;->arACT_PctEmision)
			
			$0:=1
		Else 
			BEEP:C151
			$0:=-1
		End if 
	End if 
	If (KRL_RegistroFueModificado (->[ADT_Candidatos:49]))
		SAVE RECORD:C53([ADT_Candidatos:49])
	End if 
End if 