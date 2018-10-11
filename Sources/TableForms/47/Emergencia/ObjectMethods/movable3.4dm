If (vs_Name="")
	CD_Dlog (0;__ ("Debe ingresar un nombre de usuario."))
Else 
	If (vs_Password="")
		CD_Dlog (0;__ ("Debe ingresar una contraseña."))
	Else 
		$NotSuperUser:=Not:C34(USR_IsSuperUser (vs_Name;vs_password))
		If ($NotSuperUser)
			READ ONLY:C145([xShell_Users:47])
			QUERY:C277([xShell_Users:47];[xShell_Users:47]login:9=vs_Name)
			Case of 
				: (Records in selection:C76([xShell_Users:47])=0)
					CD_Dlog (0;__ ("El usuario ingresado no corresponde a un usuario registrado."))
					vs_password:=""
					GOTO OBJECT:C206(vs_password)
					<>vlXS_SpecialAuthCount:=<>vlXS_SpecialAuthCount+1
				: (Records in selection:C76([xShell_Users:47])=1)
					Case of 
						: ([xShell_Users:47]PasswordVersion:10=3)
							$decrypted:=USR_DecryptPassword ([xShell_Users:47]xPass:13)
							If (ST_ExactlyEqual ($decrypted;vs_password)=1)
								ACCEPT:C269
							Else 
								CD_Dlog (0;__ ("La contraseña es incorrecta. Por favor inténtelo nuevamente."))
								vs_password:=""
								GOTO OBJECT:C206(vs_password)
								<>vlXS_SpecialAuthCount:=<>vlXS_SpecialAuthCount+1
								LOG_RegisterEvt ("Autorización Especial: Contraseña ingresada no es correcta.")
							End if 
					End case 
			End case 
			If (<>vlXS_SpecialAuthCount=3)
				CD_Dlog (0;__ ("Máximo número de intentos de ingresar una clave correcta alcanzado. Autorización denegada."))
				LOG_RegisterEvt ("Autorización Especial: Máximo número de intentos de ingresar una clave correcta a"+"lcanzado.")
				CANCEL:C270
			End if 
		Else 
			ACCEPT:C269
		End if 
	End if 
End if 