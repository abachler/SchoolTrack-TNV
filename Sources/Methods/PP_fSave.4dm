//%attributes = {}
  //PP_fSave 

C_LONGINT:C283($0)
$0:=0

If (USR_checkRights ("M";->[Personas:7]))
	
	  //If (KRL_RegistroFueModificado (->[Personas]) | (campopropio))  //ABC 198018 //20180123
	
	  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
	If (KRL_RegistroFueModificado (->[Personas:7]) | (vb_guardarCambios))
		  //20180404 RCH Ticket 203523
		C_TEXT:C284($t_camposObligatorios;$t_datosNoUnicos;$t_datoNoValido)
		$b_error:=STR_ValidaCreacionRegistro ("Personas";->$t_camposObligatorios;->$t_datosNoUnicos;->$t_datoNoValido)
		If ($b_error)
			Case of 
				: ($t_camposObligatorios#"")
					CD_Dlog (0;__ ("El campo ^0 debe ser completado obligatoriamente antes de guardar el registro de una persona";$t_camposObligatorios))
				: ($t_datosNoUnicos#"")
					CD_Dlog (0;__ ("El campo ^0 debe tener valor único para permitir guardar el registro de una persona.";$t_datosNoUnicos))
				: ($t_datoNoValido#"")
					CD_Dlog (0;__ ("El campo ^0 no tiene un dato válido que permita guardar el registro de una persona.";$t_datoNoValido))
			End case 
			$0:=-1
		Else 
			
			[Personas:7]Apellido_paterno:3:=ST_Format (->[Personas:7]Apellido_paterno:3)
			[Personas:7]Apellido_materno:4:=ST_Format (->[Personas:7]Apellido_materno:4)
			[Personas:7]Nombres:2:=ST_Format (->[Personas:7]Nombres:2)
			[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
			[Personas:7]Apellidos_y_nombres:30:=ST_Format (->[Personas:7]Apellidos_y_nombres:30)
			
			If (Old:C35([Personas:7]No:1)=0)
				BBL_CreateUserRecord (7)
			End if 
			
			
			
			Case of 
				: (vsBWR_CurrentModule="AccountTrack")
					[Personas:7]ACT_Numero_TC:54:=ACTpp_CRYPTTC ("xxACT_SetCryptTC";->[Personas:7]ACT_Numero_TC:54;->[Personas:7]ACT_xPass:91)
					
					  //20180102 RCH
					  //ACTpp_DireccionDeFacturacion ("GuardaDesdeInput") //20180310 RCH Se cambia a botones
					
			End case 
			
			C_BOOLEAN:C305(vbACT_CambioModoPago)
			  //20121005 RCH
			  //If (Old([Personas]ACT_Modo_de_pago)#[Personas]ACT_Modo_de_pago)
			  //LOG_RegisterEvt ("Cambio en modo de pago de apoderado "+[Personas]Apellidos_y_nombres+". Modo de pago cambió de: "+ST_Qte (Old([Personas]ACT_Modo_de_pago))+" a "+ST_Qte ([Personas]ACT_Modo_de_pago)+"."+ST_Boolean2Str (vbACT_CambioModoPago;" Cambio realizado manualmente desde ficha del apoderado.";""))
			If (Old:C35([Personas:7]ACT_id_modo_de_pago:94)#[Personas:7]ACT_id_modo_de_pago:94)
				LOG_RegisterEvt ("Cambio en modo de pago de apoderado "+[Personas:7]Apellidos_y_nombres:30+". Modo de pago cambió de: "+ST_Qte (Old:C35([Personas:7]ACT_modo_de_pago_new:95))+" a "+ST_Qte ([Personas:7]ACT_modo_de_pago_new:95)+"."+ST_Boolean2Str (vbACT_CambioModoPago;" Cambio realizado manualmente desde ficha del apoderado.";""))
			End if 
			vbACT_CambioModoPago:=False:C215
			
			SAVE RECORD:C53([Personas:7])
			$0:=1
		End if 
	Else 
		$0:=0
	End if 
End if 