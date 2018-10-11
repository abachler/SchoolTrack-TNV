C_LONGINT:C283($winWidth;$winHeight;$nPages)
C_BOOLEAN:C305($fWidth;$fHeight)
C_TEXT:C284($formTitle)
C_LONGINT:C283(cb_EnviarMail)

Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		$selected:=Find in array:C230(lb_Usuarios;True:C214)
		If ($selected#-1)
			SN3_ModUserType:=SN3_TipoUsuario{$selected}
			SN3_ModUserLogin:=SN3_LoginUsuarios{$selected}
			SN3_ModUserNames:=SN3_AyNUsuarios{$selected}
			SN3_ModWeb:=SN3_ModificadoWebUsuarios{$selected}
			$sn3_IdUsuario:=SN3_CodeUsuarios{$selected}
			FORM GET PROPERTIES:C674([SN3_PublicationPrefs:161];"UserModification";$winWidth;$winHeight;$nPages;$fWidth;$fHeight;$formTitle)
			WDW_Open ($winWidth;$winHeight;7;2)
			DIALOG:C40([SN3_PublicationPrefs:161];"UserModification")
			CLOSE WINDOW:C154
			If (ok=1)
				$mail:=String:C10(cb_EnviarMail)
				WEB SERVICE SET PARAMETER:C777("codigopais";<>vtXS_CountryCode)
				WEB SERVICE SET PARAMETER:C777("rolbasedatos";<>gRolBD)
				WEB SERVICE SET PARAMETER:C777("idusuario";$sn3_IdUsuario)
				WEB SERVICE SET PARAMETER:C777("nuevologin";SN3_ModUserLogin)
				WEB SERVICE SET PARAMETER:C777("nuevapassword";SN3_ModUserPass)
				WEB SERVICE SET PARAMETER:C777("enviarpormail";$mail)
				$vl_pID:=IT_UThermometer (1;0;__ ("Enviando datos a SchoolNet...");-1)
				$err:=SN3_CallWebService ("sn3ws_modificacion_proceso.modifica")
				IT_UThermometer (-2;$vl_pID)
				If ($err="")
					WEB SERVICE GET RESULT:C779($resultado;"resultado";*)
					Case of 
						: ($resultado="0")
							CD_Dlog (0;__ ("El cambio en los datos de acceso se realizó con éxito."))
							SN3_LoginUsuarios{$selected}:=SN3_ModUserLogin
							SN3_PasswordUsuarios{$selected}:=SN3_ModUserPass
							SN3_ModificadoWebUsuarios{$selected}:=0
							SN3_StylesUsuarios{$selected}:=Plain:K14:1
						: ($resultado="1")
							CD_Dlog (0;__ ("El cambio en los datos de acceso se realizó con éxito, pero el usuario no tiene una dirección de email donde enviar los datos."))
							SN3_LoginUsuarios{$selected}:=SN3_ModUserLogin
							SN3_PasswordUsuarios{$selected}:=SN3_ModUserPass
							SN3_ModificadoWebUsuarios{$selected}:=0
							SN3_StylesUsuarios{$selected}:=Plain:K14:1
						: ($resultado="-1")
							CD_Dlog (0;__ ("El nombre de usuario elegido ya existe. Por favor elija otro."))
						: ($resultado="-2")
							CD_Dlog (0;__ ("Por favor ingrese un nombre de usuario."))
						: ($resultado="-3")
							CD_Dlog (0;__ ("Por favor ingrese una contraseña."))
						: ($resultado="-4")
							CD_Dlog (0;__ ("Por seguridad las contraseñas no pueden tener menos de cuatro caracteres."))
						Else 
							CD_Dlog (0;__ ("El cambio en los datos de acceso se realizó con éxito."))
							SN3_LoginUsuarios{$selected}:=SN3_ModUserLogin
							SN3_PasswordUsuarios{$selected}:=SN3_ModUserPass
							SN3_ModificadoWebUsuarios{$selected}:=0
							SN3_StylesUsuarios{$selected}:=Plain:K14:1
					End case 
					For ($i;1;Size of array:C274(SN3_CodeUsuarios))
						$index:=Find in array:C230(SN3_CodeUsuariosCpy;SN3_CodeUsuarios{$i})
						SN3_LoginUsuariosCpy{$index}:=SN3_LoginUsuarios{$i}
						SN3_PasswordUsuariosCpy{$index}:=SN3_PasswordUsuarios{$i}
						SN3_ColorsUsuariosCpy{$index}:=SN3_ColorsUsuarios{$i}
						SN3_StylesUsuariosCpy{$index}:=SN3_StylesUsuarios{$i}
						SN3_BacksUsuariosCpy{$index}:=SN3_BacksUsuarios{$i}
						SN3_ModificadoWebUsuariosCpy{$index}:=SN3_ModificadoWebUsuarios{$i}
						SN3_StylesUsuariosCpy{$index}:=SN3_StylesUsuarios{$i}
					End for 
					SN3_FilterUsersList 
				Else 
					CD_Dlog (0;__ ("No se pudo establecer la conexión con SchoolNet."))
				End if 
			End if 
		End if 
	: (Form event:C388=On Clicked:K2:4)
		If (Count in array:C907(lb_Usuarios;True:C214)>0)
			If (Contextual click:C713)
				If (Count in array:C907(lb_Usuarios;True:C214)=1)
					$selected:=Find in array:C230(lb_Usuarios;True:C214)
					If (SN3_InactivoUsuarios{$selected}=1)
						$text:=__ ("Modificar...;(-;Activar;(Inactivar")
					Else 
						$text:=__ ("Modificar...;(-;(Activar;Inactivar")
					End if 
					If (SMTP_VerifyEmailAddress (SN3_eMailsUsuarios{$selected};False:C215)#"")
						$text:=$text+__ (";(-;Enviar datos de acceso")
					Else 
						$text:=$text+__ (";(-;(Enviar datos de acceso")
					End if 
				Else 
					lb_Usuarios{0}:=True:C214
					ARRAY LONGINT:C221($DA_Return;0)
					AT_SearchArray (->lb_Usuarios;"=";->$DA_Return)
					$textInactivo:=__ ("(Inactivar")
					$textActivo:=__ ("(Activar")
					For ($i;1;Size of array:C274($DA_Return))
						If (SN3_InactivoUsuarios{$DA_Return{$i}}=0)
							$textInactivo:=__ ("Inactivar")
							$i:=Size of array:C274($DA_Return)+1
						End if 
					End for 
					For ($i;1;Size of array:C274($DA_Return))
						If (SN3_InactivoUsuarios{$DA_Return{$i}}=1)
							$textActivo:=__ ("Activar")
							$i:=Size of array:C274($DA_Return)+1
						End if 
					End for 
					$text:=__ ("(Modificar...;(-;")+$textActivo+";"+$textInactivo
				End if 
				$choice:=Pop up menu:C542($text)
				Case of 
					: ($choice=1)
						$selected:=Find in array:C230(lb_Usuarios;True:C214)
						If ($selected#-1)
							SN3_ModUserType:=SN3_TipoUsuario{$selected}
							SN3_ModUserLogin:=SN3_LoginUsuarios{$selected}
							SN3_ModUserNames:=SN3_AyNUsuarios{$selected}
							SN3_ModWeb:=SN3_ModificadoWebUsuarios{$selected}
							$sn3_IdUsuario:=SN3_CodeUsuarios{$selected}
							FORM GET PROPERTIES:C674([SN3_PublicationPrefs:161];"UserModification";$winWidth;$winHeight;$nPages;$fWidth;$fHeight;$formTitle)
							WDW_Open ($winWidth;$winHeight;7;2)
							DIALOG:C40([SN3_PublicationPrefs:161];"UserModification")
							CLOSE WINDOW:C154
							If (ok=1)
								$mail:=String:C10(cb_EnviarMail)
								WEB SERVICE SET PARAMETER:C777("codigopais";<>vtXS_CountryCode)
								WEB SERVICE SET PARAMETER:C777("rolbasedatos";<>gRolBD)
								WEB SERVICE SET PARAMETER:C777("idusuario";$sn3_IdUsuario)
								WEB SERVICE SET PARAMETER:C777("nuevologin";SN3_ModUserLogin)
								WEB SERVICE SET PARAMETER:C777("nuevapassword";SN3_ModUserPass)
								WEB SERVICE SET PARAMETER:C777("enviarpormail";$mail)
								$vl_pID:=IT_UThermometer (1;0;__ ("Enviando datos a SchoolNet...");-1)
								$err:=SN3_CallWebService ("sn3ws_modificacion_proceso.modifica")
								IT_UThermometer (-2;$vl_pID)
								If ($err="")
									WEB SERVICE GET RESULT:C779($resultado;"resultado";*)
									Case of 
										: ($resultado="0")
											CD_Dlog (0;__ ("El cambio en los datos de acceso se realizó con éxito."))
											SN3_LoginUsuarios{$selected}:=SN3_ModUserLogin
											SN3_PasswordUsuarios{$selected}:=SN3_ModUserPass
											SN3_ModificadoWebUsuarios{$selected}:=0
											SN3_StylesUsuarios{$selected}:=Plain:K14:1
										: ($resultado="1")
											CD_Dlog (0;__ ("El cambio en los datos de acceso se realizó con éxito, pero el usuario no tiene una dirección de email donde enviar los datos."))
											SN3_LoginUsuarios{$selected}:=SN3_ModUserLogin
											SN3_PasswordUsuarios{$selected}:=SN3_ModUserPass
											SN3_ModificadoWebUsuarios{$selected}:=0
											SN3_StylesUsuarios{$selected}:=Plain:K14:1
										: ($resultado="-1")
											CD_Dlog (0;__ ("El nombre de usuario elegido ya existe. Por favor elija otro."))
										: ($resultado="-2")
											CD_Dlog (0;__ ("Por favor ingrese un nombre de usuario."))
										: ($resultado="-3")
											CD_Dlog (0;__ ("Por favor ingrese una contraseña."))
										: ($resultado="-4")
											CD_Dlog (0;__ ("Por seguridad las contraseñas no pueden tener menos de ocho caracteres."))
									End case 
									For ($i;1;Size of array:C274(SN3_CodeUsuarios))
										$index:=Find in array:C230(SN3_CodeUsuariosCpy;SN3_CodeUsuarios{$i})
										SN3_LoginUsuariosCpy{$index}:=SN3_LoginUsuarios{$i}
										SN3_PasswordUsuariosCpy{$index}:=SN3_PasswordUsuarios{$i}
										SN3_ColorsUsuariosCpy{$index}:=SN3_ColorsUsuarios{$i}
										SN3_StylesUsuariosCpy{$index}:=SN3_StylesUsuarios{$i}
										SN3_BacksUsuariosCpy{$index}:=SN3_BacksUsuarios{$i}
										SN3_ModificadoWebUsuariosCpy{$index}:=SN3_ModificadoWebUsuarios{$i}
										SN3_StylesUsuariosCpy{$index}:=SN3_StylesUsuarios{$i}
									End for 
									SN3_FilterUsersList 
								Else 
									CD_Dlog (0;__ ("No se pudo establecer la conexión con SchoolNet."))
								End if 
							End if 
						End if 
					: ($choice=3)
						ARRAY TEXT:C222(aInactivos;0)
						ARRAY TEXT:C222(aEstado;0)
						lb_Usuarios{0}:=True:C214
						ARRAY LONGINT:C221($DA_Return;0)
						AT_SearchArray (->lb_Usuarios;"=";->$DA_Return)
						For ($i;1;Size of array:C274($DA_Return))
							If (SN3_InactivoUsuarios{$DA_Return{$i}}=1)
								APPEND TO ARRAY:C911(aInactivos;SN3_CodeUsuarios{$DA_Return{$i}})
								APPEND TO ARRAY:C911(aEstado;"0")
							End if 
						End for 
						  //Llamar WS para inactivar y procesar lista para reflejar resultados
						$motivo:=""
						$mail:=String:C10(cb_SendMailInactivar)
						WEB SERVICE SET PARAMETER:C777("codpais";<>vtXS_CountryCode)
						WEB SERVICE SET PARAMETER:C777("rolbd";<>gRolBD)
						WEB SERVICE SET PARAMETER:C777("enviarxmail";$mail)
						WEB SERVICE SET PARAMETER:C777("motivoinactivacion";$motivo)
						WEB SERVICE SET PARAMETER:C777("idusuarios";aInactivos)
						WEB SERVICE SET PARAMETER:C777("estados";aEstado)
						$p:=IT_UThermometer (1;0;__ ("Enviando solicitud a SchoolNet...");-1)
						$err:=SN3_CallWebService ("sn3ws_activacion_proceso.activa")
						IT_UThermometer (-2;$p)
						If ($err="")
							ARRAY TEXT:C222(aResultados;0)
							WEB SERVICE GET RESULT:C779(aResultados;"resultados";*)
							$noCambiados:=""
							For ($i;1;Size of array:C274(aResultados))
								$index:=Find in array:C230(SN3_CodeUsuarios;aInactivos{$i})
								Case of 
									: (aResultados{$i}="0")
										SN3_ColorsUsuarios{$index}:=0x0000
										SN3_InactivoUsuarios{$index}:=0
										If (SN3_ModificadoWebUsuarios{$index}=1)
											SN3_StylesUsuarios{$index}:=Italic:K14:3
										End if 
									: (aResultados{$i}="1")
										SN3_ColorsUsuarios{$index}:=0x0000
										SN3_InactivoUsuarios{$index}:=0
										If (SN3_ModificadoWebUsuarios{$index}=1)
											SN3_StylesUsuarios{$index}:=Italic:K14:3
										End if 
									: (aResultados{$i}="-1")
										$noCambiados:=$noCambiados+SN3_AyNUsuarios{$index}+"\r"
								End case 
							End for 
							If ($noCambiados#"")
								IT_ShowScrollableText ($noCambiados;__ ("Los siguientes usuarios no pudieron ser activados:"))
							End if 
							For ($i;1;Size of array:C274(SN3_CodeUsuarios))
								$index:=Find in array:C230(SN3_CodeUsuariosCpy;SN3_CodeUsuarios{$i})
								SN3_InactivoUsuariosCpy{$index}:=SN3_InactivoUsuarios{$i}
								SN3_ColorsUsuariosCpy{$index}:=SN3_ColorsUsuarios{$i}
								SN3_StylesUsuariosCpy{$index}:=SN3_StylesUsuarios{$i}
								SN3_BacksUsuariosCpy{$index}:=SN3_BacksUsuarios{$i}
							End for 
						Else 
							CD_Dlog (0;__ ("No se pudo establecer la conexión con SchoolNet."))
						End if 
					: ($choice=4)
						ARRAY TEXT:C222(aActivos;0)
						ARRAY TEXT:C222(aEstado;0)
						lb_Usuarios{0}:=True:C214
						ARRAY LONGINT:C221($DA_Return;0)
						AT_SearchArray (->lb_Usuarios;"=";->$DA_Return)
						For ($i;1;Size of array:C274($DA_Return))
							If (SN3_InactivoUsuarios{$DA_Return{$i}}=0)
								APPEND TO ARRAY:C911(aActivos;SN3_CodeUsuarios{$DA_Return{$i}})
								APPEND TO ARRAY:C911(aEstado;"1")
							End if 
						End for 
						If (cb_SendMailInactivar=1)
							$motivo:=CD_Request (__ ("Por favor ingrese un motivo para la inactivación (Puede dejar este texto vacío para enviar sólo una notificación):");__ ("Inactivar");__ ("Cancelar"))
						Else 
							OK:=1
						End if 
						If (OK=1)
							  //Llamar WS para inactivar y procesar lista para reflejar resultados
							$mail:=String:C10(cb_SendMailInactivar)
							WEB SERVICE SET PARAMETER:C777("codpais";<>vtXS_CountryCode)
							WEB SERVICE SET PARAMETER:C777("rolbd";<>gRolBD)
							WEB SERVICE SET PARAMETER:C777("enviarxmail";$mail)
							WEB SERVICE SET PARAMETER:C777("motivoinactivacion";$motivo)
							WEB SERVICE SET PARAMETER:C777("idusuarios";aActivos)
							WEB SERVICE SET PARAMETER:C777("estados";aEstado)
							$p:=IT_UThermometer (1;0;__ ("Enviando solicitud a SchoolNet...");-1)
							$err:=SN3_CallWebService ("sn3ws_activacion_proceso.activa")
							IT_UThermometer (-2;$p)
							If ($err="")
								ARRAY TEXT:C222(aResultados;0)
								WEB SERVICE GET RESULT:C779(aResultados;"resultados";*)
								$noCambiados:=""
								For ($i;1;Size of array:C274(aResultados))
									$index:=Find in array:C230(SN3_CodeUsuarios;aActivos{$i})
									Case of 
										: (aResultados{$i}="0")
											SN3_ColorsUsuarios{$index}:=0x007F7F7F
											SN3_InactivoUsuarios{$index}:=1
											If (SN3_ModificadoWebUsuarios{$index}=1)
												SN3_StylesUsuarios{$index}:=Italic:K14:3
											End if 
										: (aResultados{$i}="1")
											SN3_ColorsUsuarios{$index}:=0x007F7F7F
											SN3_InactivoUsuarios{$index}:=1
											If (SN3_ModificadoWebUsuarios{$index}=1)
												SN3_StylesUsuarios{$index}:=Italic:K14:3
											End if 
										: (aResultados{$i}="-1")
											$noCambiados:=$noCambiados+SN3_AyNUsuarios{$index}+"\r"
									End case 
								End for 
								If ($noCambiados#"")
									IT_ShowScrollableText ($noCambiados;__ ("Los siguientes usuarios no pudieron ser inactivados:"))
								End if 
								For ($i;1;Size of array:C274(SN3_CodeUsuarios))
									$index:=Find in array:C230(SN3_CodeUsuariosCpy;SN3_CodeUsuarios{$i})
									SN3_InactivoUsuariosCpy{$index}:=SN3_InactivoUsuarios{$i}
									SN3_ColorsUsuariosCpy{$index}:=SN3_ColorsUsuarios{$i}
									SN3_StylesUsuariosCpy{$index}:=SN3_StylesUsuarios{$i}
									SN3_BacksUsuariosCpy{$index}:=SN3_BacksUsuarios{$i}
								End for 
							Else 
								CD_Dlog (0;__ ("No se pudo establecer la conexión con SchoolNet."))
							End if 
						End if 
					: ($choice=6)
						$selected:=Find in array:C230(lb_Usuarios;True:C214)
						$mail:=SN3_eMailsUsuarios{$selected}
						SN3_SendUserAccessData ($mail)
				End case 
				LISTBOX SELECT ROW:C912(lb_usuarios;0;lk remove from selection:K53:3)
			End if 
		End if 
	: (Form event:C388=On Selection Change:K2:29)
		IT_SetButtonState ((Count in array:C907(lb_Usuarios;True:C214)=1);->bPreviewUsuario)
End case 