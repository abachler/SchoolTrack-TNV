  // [xxSTR_Constants].STR_InasistenciasSesiones.Variable1()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 04/01/13, 13:03:33
  // ---------------------------------------------
C_BOOLEAN:C305($b_Continuar;$b_BloqueadoEnEscritura)
C_LONGINT:C283($l_seleccionUsuario;$l_filaSeleccionada;$l_asistenciasRegistradas)
C_TEXT:C284($t_textoPopup;$t_menu)

$l_filaSeleccionada:=AL_GetLine (Self:C308->)
$l_IdSesion:=alSTK_SesionID{$l_filaSeleccionada}

Case of 
	: (alProEvt=AL Double click event)
		KRL_FindAndLoadRecordByIndex (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;->$l_IdSesion;True:C214)
		WDW_OpenFormWindow (->[Asignaturas_RegistroSesiones:168];"Edicion";-1;Plain form window:K39:10)
		DIALOG:C40([Asignaturas_RegistroSesiones:168];"Edicion")
		CLOSE WINDOW:C154
		
	: (alProEvt=AL Single Control Click)
		KRL_FindAndLoadRecordByIndex (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;->$l_IdSesion;False:C215)
		$b_usuarioAutorizado:=USR_GetMethodAcces ("ASrs_estadoSesion";0)
		$b_usuarioAutorizado:=$b_usuarioAutorizado | (USR_checkRights ("M";->[Asignaturas_RegistroSesiones:168]))
		$b_usuarioAutorizado:=$b_usuarioAutorizado | ([Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10=<>lUSR_RelatedTableUserID)
		
		$t_menu:=Create menu:C408
		APPEND MENU ITEM:C411($t_menu;__ ("Impartida"))
		SET MENU ITEM PARAMETER:C1004($t_menu;-1;"impartida")
		APPEND MENU ITEM:C411($t_menu;__ ("No Impartida"))
		SET MENU ITEM PARAMETER:C1004($t_menu;-1;"noImpartida")
		APPEND MENU ITEM:C411($t_menu;"-")
		APPEND MENU ITEM:C411($t_menu;__ ("Asistencia Registrada"))
		SET MENU ITEM PARAMETER:C1004($t_menu;-1;"asistenciaRegistrada")
		APPEND MENU ITEM:C411($t_menu;"-")
		APPEND MENU ITEM:C411($t_menu;__ ("Editar Sesión"))
		SET MENU ITEM PARAMETER:C1004($t_menu;-1;"editarSesion")
		
		If ([Asignaturas_RegistroSesiones:168]Impartida:5)
			SET MENU ITEM MARK:C208($t_menu;1;Char:C90(18))
			SET MENU ITEM MARK:C208($t_menu;2;"")
		Else 
			SET MENU ITEM MARK:C208($t_menu;1;"")
			SET MENU ITEM MARK:C208($t_menu;2;Char:C90(18))
			DISABLE MENU ITEM:C150($t_menu;4)
			DISABLE MENU ITEM:C150($t_menu;6)
		End if 
		
		If ([Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18)
			SET MENU ITEM MARK:C208($t_menu;4;Char:C90(18))
		End if 
		
		If (Not:C34($b_usuarioAutorizado))
			DISABLE MENU ITEM:C150($t_menu;0)
		End if 
		
		
		$t_seleccionUsuario:=Dynamic pop up menu:C1006($t_menu)
		RELEASE MENU:C978($t_menu)
		
		Case of 
			: ($t_seleccionUsuario="impartida")
				$l_resultado:=ASrs_EstadoSesion ($l_IdSesion;True:C214)
				If ($l_resultado=0)
					CD_Dlog (0;__ ("No fue posible modificar el estado de esta sesión de clases.\r\rPor favor intente nuevamente más tarde."))
				End if 
				If (aImpartida{$l_filaSeleccionada}#[Asignaturas_RegistroSesiones:168]Impartida:5)
					aImpartida{$l_filaSeleccionada}:=[Asignaturas_RegistroSesiones:168]Impartida:5
					ALabs_UpdateForm 
				End if 
				
			: ($t_seleccionUsuario="noImpartida")
				$l_resultado:=ASrs_EstadoSesion ($l_IdSesion;False:C215)
				If ($l_resultado=0)
					CD_Dlog (0;__ ("No fue posible modificar el estado de esta sesión de clases.\r\rPor favor intente nuevamente más tarde."))
				End if 
				If (aImpartida{$l_filaSeleccionada}#[Asignaturas_RegistroSesiones:168]Impartida:5)
					aImpartida{$l_filaSeleccionada}:=[Asignaturas_RegistroSesiones:168]Impartida:5
				End if 
				
			: ($t_seleccionUsuario="asistenciaRegistrada")
				KRL_FindAndLoadRecordByIndex (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;->$l_IdSesion;True:C214)
				If (OK=1)
					Case of 
						: (Not:C34([Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18))
							[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18:=True:C214
							[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_DTS:19:=String:C10(Current date:C33(*);ISO date GMT:K1:10;Current time:C178(*))
							[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_Por:20:=USR_GetUserName (USR_GetUserID )
							SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
							ab_InasistenciaTomada{$l_filaSeleccionada}:=True:C214
							AL_SetRowStyle (Self:C308->;$l_filaSeleccionada;Bold:K14:2)
							AL_UpdateArrays (Self:C308->;-2)
							
						: ([Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18)
							SET QUERY DESTINATION:C396(Into variable:K19:4;$l_asistenciasRegistradas)
							QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=$l_IdSesion)
							SET QUERY DESTINATION:C396(Into current selection:K19:1)
							If ($l_asistenciasRegistradas>0)
								ModernUI_Notificacion (__ ("Toma de asistencia");__ ("Hay inasistencias registradas en esta sesión.\rNo es posible cambiar el estado de la toma de asistencia."))
							Else 
								[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18:=False:C215
								[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_DTS:19:=""
								[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_Por:20:=""
								SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
								ab_InasistenciaTomada{$l_filaSeleccionada}:=False:C215
								AL_SetRowStyle (Self:C308->;$l_filaSeleccionada;Plain:K14:1)
								AL_UpdateArrays (Self:C308->;-2)
							End if 
					End case 
					
					KRL_UnloadReadOnly (->[Asignaturas_RegistroSesiones:168])
				End if 
				
				
				
			: ($t_seleccionUsuario="editarSesion")
				KRL_FindAndLoadRecordByIndex (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;->$l_IdSesion;True:C214)
				WDW_OpenFormWindow (->[Asignaturas_RegistroSesiones:168];"Edicion";-1;Plain form window:K39:10)
				DIALOG:C40([Asignaturas_RegistroSesiones:168];"Edicion")
				CLOSE WINDOW:C154
				
		End case 
End case 