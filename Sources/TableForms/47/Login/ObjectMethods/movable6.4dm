C_LONGINT:C283($logged)
If (vlBWR_CurrentModuleRef=0)
	vlBWR_CurrentModuleRef:=vlXS_LastModule
	If (vlBWR_CurrentModuleRef=0)
		vlBWR_CurrentModuleRef:=1
	End if 
End if 

$aceptar:=False:C215
$moduloautorizado:=False:C215
LIST TO ARRAY:C288("XS_Modules";$atXS_ModuleNames;$alXS_ModuleRef)
$moduleName:=$atXS_ModuleNames{Find in array:C230($alXS_ModuleRef;vlBWR_CurrentModuleRef)}

If ((Test semaphore:C652("BackupInProcess")) | (Test semaphore:C652("DisconnectingClients")))
	<>vb_MsgON:=True:C214
	CD_Dlog (0;__ ("No es posible iniciar una sesión en este momento.\rPor favor inténtelo nuevamente más tarde."))
	QUIT 4D:C291
Else 
	Case of 
		: (vlBWR_CurrentModuleRef=0)
			$ig:=CD_Dlog (0;__ ("Seleccione el módulo en que desea iniciar la sesión."))
		: (vs_name="")
			$ig:=CD_Dlog (0;__ ("Ingrese su nombre de usuario por favor."))
		: (vs_Password="")
			$ig:=CD_Dlog (0;__ ("Ingrese su contraseña por favor."))
		Else 
			$logged:=dhUG_ProcessLogin 
			$semaphores:=USR_TestSemaphores 
			Connected:=USR_TestConnection 
			If ($logged=1)
				LICENCIA_Inicio 
				If (Not:C34($Semaphores))
					PREF_Set (<>lUSR_CurrentUserID;"language";<>vtXS_langage)
					SYS_OpenLangageResource 
					$aceptar:=True:C214
				Else 
					CD_Dlog (0;__ ("Se está ejecutando un proceso que impide el acceso a este módulo. Intente otra vez."))
				End if 
			Else 
				If (LICENCIA_esModuloAutorizado (1;SchoolTrack Web Access))
					While (Semaphore:C143("STW_ProcessingLogin"))
						IDLE:C311
						IDLE:C311
						DELAY PROCESS:C323(Current process:C322;5)
					End while 
				End if 
				$logged:=USR_ProcessLogin 
				If ($logged=1)
					$moduloAutorizado:=True:C214
					LICENCIA_Inicio 
					$moduleLicense:=LICENCIA_esModuloAutorizado (2;vlBWR_CurrentModuleRef)
					If ($moduleLicense)
						If (LICENCIA_esModuloAutorizado (1;SchoolTrack Web Access))
							STWA2_Session_DeleteOtherSessio (<>lUSR_CurrentUserID)
						End if 
						$IsAvailableConnection:=LICENCIA_HayConexionDisponible 
						If ($IsAvailableConnection)
							$semaphores:=USR_TestSemaphores 
							Connected:=USR_TestConnection 
							If (Connected=0)
								If (Not:C34($Semaphores))
									CLEAR SEMAPHORE:C144("STW_ProcessingLogin")
									PREF_Set (<>lUSR_CurrentUserID;"language";<>vtXS_langage)
									SYS_OpenLangageResource 
									USR_getUserRigths 
									$moduloAutorizado:=(Find in array:C230(<>atUSR_AuthModules;$moduleName)>0)
									If ($moduloAutorizado)
										$aceptar:=True:C214
									End if 
								Else 
									CLEAR SEMAPHORE:C144("STW_ProcessingLogin")
									CD_Dlog (0;__ ("Se está ejecutando un proceso que impide el acceso a este módulo. Intente otra vez."))
								End if 
							Else 
								CLEAR SEMAPHORE:C144("STW_ProcessingLogin")
								CD_Dlog (0;__ ("Este usuario ya está conectado a la base de datos."))
								$logged:=0
							End if 
						Else 
							CLEAR SEMAPHORE:C144("STW_ProcessingLogin")
							CD_Dlog (0;__ ("Ya se alcanzó el máximo de conexiones que su licencia permite. Intente más tarde."))
							$logged:=0
						End if 
					Else 
						CLEAR SEMAPHORE:C144("STW_ProcessingLogin")
						CD_Dlog (0;__ ("Lo siento, su licencia no le permite ejecutar este módulo."))
						$logged:=0
					End if 
				Else 
					wdw_shakewindow   //20130703 RCH Se saca de USR_ProcessLogin
				End if 
			End if 
	End case 
End if 

ok:=0

If ((<>lUSR_CurrentUserID<0) & ($aceptar))
	vb_ReloadLogin:=False:C215
	ACCEPT:C269
Else 
	If ($logged=1)
		If (Not:C34($moduloautorizado))
			$ig:=CD_Dlog (0;__ ("Lo siento, usted no tiene derechos de utilización para el módulo ")+$moduleName+__ ("."))
			vb_ReloadLogin:=True:C214
		Else 
			vb_ReloadLogin:=False:C215
			ACCEPT:C269
		End if 
	End if 
End if 

If (ok=0)
	GOTO OBJECT:C206(vs_Password)
End if 