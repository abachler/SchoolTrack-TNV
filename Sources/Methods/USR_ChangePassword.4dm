//%attributes = {}
  // USR_ChangePassword()
  // Por: Alberto Bachler K.: 30-07-15, 16:13:49
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_LONGINT:C283($l_idUsuario;$l_resultado)


If (False:C215)
	C_TEXT:C284(USR_ChangePassword ;$1)
End if 

C_TEXT:C284(vtUSR_Message)
If (Count parameters:C259=1)
	vtUSR_Message:=$1
End if 
MNU_SetMenuBar ("XS_Browser")
DISABLE MENU ITEM:C150(1;0)
WDW_OpenFormWindow (->[xShell_Users:47];"ChangePass";0;4)
DIALOG:C40([xShell_Users:47];"ChangePass")
CLOSE WINDOW:C154
If (ok=1)
	$l_idUsuario:=USR_GetUserID 
	READ WRITE:C146([xShell_Users:47])
	QUERY:C277([xShell_Users:47];[xShell_Users:47]No:1=$l_idUsuario)
	[xShell_Users:47]xPass:13:=USR_EncryptPassWord (vsPW_password1)
	[xShell_Users:47]PasswordVersion:10:=3
	If ([xShell_Users:47]Password_DaysToRenew:16>0)
		[xShell_Users:47]Password_ExpiresOn:11:=Current date:C33(*)+[xShell_Users:47]Password_DaysToRenew:16
	Else 
		[xShell_Users:47]Password_DaysToRenew:16:=0
		[xShell_Users:47]Password_ExpiresOn:11:=!00-00-00!
	End if 
	[xShell_Users:47]CambiarPassw_proximaSesion:26:=False:C215
	[xShell_Users:47]CambiarPassw_PrimeraSesion:25:=False:C215
	SAVE RECORD:C53([xShell_Users:47])
	USR_GetUserProperties ($l_idUsuario;->vsUSR_UserName;->vsUSR_StartUpMethod;->vsUSR_Password;->vlUSR_NbLogin;->vdUSR_LastLogin)
	$l_resultado:=USR_SetUserProperties ($l_idUsuario;vsPW_loginName;vsUSR_StartUpMethod;vsUSR_Password;vlUSR_NbLogin;vdUSR_LastLogin)
	LOG_RegisterEvt (__ ("El usuario cambio su contraseña."))
	OK:=1
End if 
vtUSR_Message:=""