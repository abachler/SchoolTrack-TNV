//%attributes = {}
  // Método: TGR_Familias
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:23:51
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)

  // Código principal
If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				[Familia:78]Numero:1:=SQ_SeqNumber (->[Familia:78]Numero:1)
				[Familia:78]Fecha_de_creación:27:=Current date:C33
				[Familia:78]Fecha_de_Modificacion:28:=[Familia:78]Fecha_de_creación:27
				If ([Familia:78]Dirección:7#"")
					[Familia:78]Direccion_Postal:29:=[Familia:78]Dirección:7
					If ([Familia:78]Comuna:8#"")
						If ([Familia:78]Codigo_postal:19#"")
							[Familia:78]Direccion_Postal:29:=[Familia:78]Direccion_Postal:29+"\r"+[Familia:78]Codigo_postal:19+" "+[Familia:78]Comuna:8
						Else 
							[Familia:78]Direccion_Postal:29:=[Familia:78]Direccion_Postal:29+"\r"+[Familia:78]Comuna:8
						End if 
					End if 
				End if 
				If ([Familia:78]Numero_de_Alumnos:2<=0)
					[Familia:78]Inactiva:31:=True:C214
				End if 
				[Familia:78]DTS_ModifiedOn_GMT:30:=DTS_Get_GMT_TimeStamp 
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				If ([Familia:78]Direccion_Postal:29="")
					If ([Familia:78]Dirección:7#"")
						[Familia:78]Direccion_Postal:29:=[Familia:78]Dirección:7
						If ([Familia:78]Comuna:8#"")
							If ([Familia:78]Codigo_postal:19#"")
								[Familia:78]Direccion_Postal:29:=[Familia:78]Direccion_Postal:29+"\r"+[Familia:78]Codigo_postal:19+" "+[Familia:78]Comuna:8
							Else 
								[Familia:78]Direccion_Postal:29:=[Familia:78]Direccion_Postal:29+"\r"+[Familia:78]Comuna:8
							End if 
						End if 
					End if 
				End if 
				
				$nombresMadre:=KRL_GetTextFieldData (->[Personas:7]No:1;->[Familia:78]Madre_Número:6;->[Personas:7]Nombres:2)
				[Familia:78]Madre_Nombre:16:=KRL_GetTextFieldData (->[Personas:7]No:1;->[Familia:78]Madre_Número:6;->[Personas:7]Apellidos_y_nombres:30)
				$nombresPadre:=KRL_GetTextFieldData (->[Personas:7]No:1;->[Familia:78]Padre_Número:5;->[Personas:7]Nombres:2)
				[Familia:78]Padre_Nombre:15:=KRL_GetTextFieldData (->[Personas:7]No:1;->[Familia:78]Padre_Número:5;->[Personas:7]Apellidos_y_nombres:30)
				Case of 
					: (($nombresMadre#"") & ($nombresPadre#""))
						[Familia:78]Nombres_padres:22:=$nombresMadre+" / "+$nombresPadre
					: (($nombresMadre#"") & ($nombresPadre=""))
						[Familia:78]Nombres_padres:22:=$nombresMadre
					: (($nombresMadre="") & ($nombresPadre#""))
						[Familia:78]Nombres_padres:22:=$nombresPadre
					Else 
						[Familia:78]Nombres_padres:22:=""
				End case 
				
				
				[Familia:78]Fecha_de_Modificacion:28:=Current date:C33
				[Familia:78]DTS_ModifiedOn_GMT:30:=DTS_Get_GMT_TimeStamp 
				
				If ([Familia:78]Numero_de_Alumnos:2#(Old:C35([Familia:78]Numero_de_Alumnos:2)))
					If ([Familia:78]Numero_de_Alumnos:2<=0)
						[Familia:78]Inactiva:31:=True:C214
						QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)
						KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
						ARRAY LONGINT:C221($aRecNums;0)
						LONGINT ARRAY FROM SELECTION:C647([Personas:7];$aRecNums;"")
						For ($i;1;Size of array:C274($aRecNums))
							READ WRITE:C146([Personas:7])
							GOTO RECORD:C242([Personas:7];$aRecNums{$i})
							QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9;=;[Personas:7]No:1)
							$sum:=Sum:C1([ACT_CuentasCorrientes:175]Total_Saldos:8)
							If ($sum=0)
								[Personas:7]Inactivo:46:=True:C214
								[Personas:7]Es_Apoderado_Academico:41:=False:C215
								[Personas:7]ES_Apoderado_de_Cuentas:42:=False:C215
								SAVE RECORD:C53([Personas:7])
							Else 
								[Personas:7]Inactivo:46:=False:C215
								SAVE RECORD:C53([Personas:7])
							End if 
							KRL_ReloadAsReadOnly (->[Personas:7])
						End for 
					Else 
						[Familia:78]Inactiva:31:=False:C215
						QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)
						KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
						ARRAY LONGINT:C221($aRecNums;0)
						LONGINT ARRAY FROM SELECTION:C647([Personas:7];$aRecNums;"")
						For ($i;1;Size of array:C274($aRecNums))
							READ WRITE:C146([Personas:7])
							GOTO RECORD:C242([Personas:7];$aRecNums{$i})
							[Personas:7]Inactivo:46:=False:C215
							SAVE RECORD:C53([Personas:7])
							KRL_ReloadAsReadOnly (->[Personas:7])
						End for 
					End if 
				End if 
				If ([Familia:78]Matrimonio_Civil:36=False:C215)
					[Familia:78]Fecha_Matrimonio_Civil:37:=!00-00-00!
				End if 
				If ([Familia:78]Matrimonio_Religioso:38=False:C215)
					[Familia:78]Fecha_Matrimonio_Religioso:39:=!00-00-00!
				End if 
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				
		End case 
		If (Trigger event:C369#On Deleting Record Event:K3:3)
			If (Not:C34(<>vb_NoSincroHaciaCondor_78))
				Sync_RegistraModificacion (->[Familia:78]Auto_UUID:23)
			End if 
			<>vb_NoSincroHaciaCondor_78:=False:C215
		Else 
			Sync_RegistraModificacion (->[Familia:78]Auto_UUID:23)
		End if 
		
		CMT_RegistrosMarcados ("CMT_MarcaRegistros";->[Familia:78])
	End if 
	SN3_MarcarRegistros (SN3_DTi_Familias)
End if 



