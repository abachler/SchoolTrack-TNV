//%attributes = {}
  // AL_fSave()
  // Por: Alberto Bachler: 27/02/13, 09:57:09
  //  ---------------------------------------------
  // MONO: Envolví las acciones para guardar primero dentro del if de verificación del permiso
  // y luego dentro de la verificación de cambios en la tabla
  //  ---------------------------------------------
C_BOOLEAN:C305($b_rechazado;$b_esNuevoRegistro)
C_LONGINT:C283($l_ignorar;$p)
C_TEXT:C284($t_camposObligatorios)

$0:=0
If (USR_checkRights ("M";->[Alumnos:2]))
	
	  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
	  //If ((KRL_RegistroFueModificado (->[Alumnos])) | (vb_ConnectionsModified) | (campopropio))
	If ((KRL_RegistroFueModificado (->[Alumnos:2])) | (vb_ConnectionsModified) | (vb_guardarCambios))
		  //20180404 RCH Ticket 203523
		C_TEXT:C284($t_camposObligatorios;$t_datosNoUnicos;$t_datoNoValido)
		$b_error:=STR_ValidaCreacionRegistro ("Alumnos";->$t_camposObligatorios;->$t_datosNoUnicos;->$t_datoNoValido)
		If ($b_error)
			Case of 
				: ($t_camposObligatorios#"")
					CD_Dlog (0;__ ("El campo ^0 debe ser completado obligatoriamente antes de guardar el registro de un alumno";$t_camposObligatorios))
				: ($t_datosNoUnicos#"")
					CD_Dlog (0;__ ("El campo ^0 debe tener valor único para permitir guardar el registro de un alumno.";$t_datosNoUnicos))
				: ($t_datoNoValido#"")
					CD_Dlog (0;__ ("El campo ^0 no tiene un dato válido que permita guardar el registro del alumno.";$t_datoNoValido))
			End case 
			$0:=-1
		Else 
			$b_esNuevoRegistro:=Is new record:C668([Alumnos:2])
			If (Old:C35([Alumnos:2]numero:1)=0)
				SAVE RECORD:C53([Alumnos:2])
			End if 
			AL_SaveConnexions 
			[Alumnos:2]Fecha_de_modificacion:22:=Current date:C33
			[Alumnos:2]Modificado_por:23:=<>tUSR_CurrentUser
			LOG_RegistroDetalle (->[Alumnos:2];"Ficha de alumno: ")  //20180820 ASM Ticket 213944
			SAVE RECORD:C53([Alumnos:2])
			ACTcc_AsignaCodInterno 
			$0:=1
		End if 
		
	Else 
		$0:=1  //MONO: sin cambios pero paso 1 para que BWR_InputFormButtonsHandler haga el cancel y cierre la ficha
	End if 
Else 
	$0:=0  //ABC :PAso 0 para que se cambie de pestaña si solo tiene  para visualizar en alumnos  ver ticket.. //199194 //20180227
End if 
