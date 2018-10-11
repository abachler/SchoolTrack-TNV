  // [xShell_Users].Input2.Variable2()
  // Por: Alberto Bachler K.: 29-07-15, 12:11:30
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_TEXT:C284($pass_old)


If (([xShell_Users:47]Name:2#"") & (ST_ExactlyEqual (vsPW_Password1;vsPW_Password2)=1) & ([xShell_Users:47]login:9#""))
	If (vsPW_Password1="")
		$t_mensaje:=__ ("No se estableció la contraseña para el usuario.\r\r^0 no podrá iniciar sesión en SchoolTrack ni SchoolTrack Web Acces mientras no se le asigne una contraseña.")
		$l_OK:=CD_Dlog (0;Replace string:C233($t_mensaje;"^0";[xShell_Users:47]Name:2);"";__ ("Aceptar");__ ("Cancelar"))
		If ($l_OK=1)
			SET BLOB SIZE:C606([xShell_Users:47]xPass:13;0)
			ACCEPT:C269
			LOG_RegisterEvt (__ ("Inhabilitación del usuario: ")+[xShell_Users:47]Name:2+" ("+[xShell_Users:47]login:9+")")
		End if 
	Else 
		If (Old:C35([xShell_Users:47]login:9)=<>tUSR_CurrentUser)
			<>tUSR_CurrentUser:=[xShell_Users:47]login:9
		End if 
		
		$pass_old:=USR_DecryptPassword ([xShell_Users:47]xPass:13)
		[xShell_Users:47]xPass:13:=USR_EncryptPassWord (vsPW_Password1)
		[xShell_Users:47]PasswordVersion:10:=3
		
		If (viUSR_RenewAfter#[xShell_Users:47]Password_DaysToRenew:16)
			If (viUSR_RenewAfter>0)
				[xShell_Users:47]Password_DaysToRenew:16:=viUSR_RenewAfter
				[xShell_Users:47]Password_ExpiresOn:11:=Current date:C33(*)+[xShell_Users:47]Password_DaysToRenew:16
			Else 
				[xShell_Users:47]Password_DaysToRenew:16:=0
				[xShell_Users:47]Password_ExpiresOn:11:=!00-00-00!
			End if 
		End if 
		
		Case of 
			: (Is new record:C668([xShell_Users:47]))
				LOG_RegisterEvt (__ ("Creación de usuario: ")+[xShell_Users:47]Name:2+" ("+[xShell_Users:47]login:9+")"+", id: "+String:C10([xShell_Users:47]No:1)+".")
			: ($pass_old#vsPW_Password1)
				$log:=__ ("Cambio de contraseña para el usuario ")+[xShell_Users:47]Name:2
				LOG_RegisterEvt ($log)
		End case 
		SAVE RECORD:C53([xShell_Users:47])
		$userID:=USR_GetUserID 
		
		If (<>tUSR_CurrentUser=[xShell_Users:47]login:9)
			USR_getUserRigths 
		End if 
		If (<>vbUSR_Use4DSecurity)
			[xShell_Users:47]No:1:=Set user properties:C612([xShell_Users:47]No:1;[xShell_Users:47]login:9;"";[xShell_Users:47]Password:3;0;!00-00-00!)
		End if 
		ACCEPT:C269
	End if 
Else 
	BEEP:C151
End if 