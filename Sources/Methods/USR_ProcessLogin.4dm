//%attributes = {}
  // USR_ProcessLogin()
  // Por: Alberto Bachler K.: 29-07-15, 12:07:53
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)

C_LONGINT:C283($l_logeado)
C_TEXT:C284($t_passAlmacenado)


If (False:C215)
	C_LONGINT:C283(USR_ProcessLogin ;$0)
End if 

READ ONLY:C145([xShell_Users:47])
QUERY:C277([xShell_Users:47];[xShell_Users:47]login:9=vs_Name)
Case of 
	: (Records in selection:C76([xShell_Users:47])=0)
		CLEAR SEMAPHORE:C144("STW_ProcessingLogin")
		vs_password:=""
		GOTO OBJECT:C206(vs_password)
		
	: (Records in selection:C76([xShell_Users:47])=1)
		Case of 
			: ([xShell_Users:47]PasswordVersion:10=3)
				$t_passAlmacenado:=USR_DecryptPassword ([xShell_Users:47]xPass:13)
				If (ST_ExactlyEqual ($t_passAlmacenado;vs_password)=1)
					<>tUSR_CurrentUser:=[xShell_Users:47]login:9
					<>lUSR_CurrentUserID:=[xShell_Users:47]No:1
					<>lUSR_RelatedTableUserID:=[xShell_Users:47]NoEmployee:7
					<>tUSR_InicialesCurrentUser:=[xShell_Users:47]Iniciales:14
					<>tUSR_CurrentUserName:=[xShell_Users:47]nombreComun:19
					<>tUSR_CurrentUserEmail:=[xShell_Users:47]email:20
					<>dUSR_ExpiresOn:=[xShell_Users:47]Password_ExpiresOn:11
					$l_logeado:=1
				Else 
					CLEAR SEMAPHORE:C144("STW_ProcessingLogin")
				End if 
		End case 
		
End case 
<>tUSR_CurrentUserName:=<>tUSR_CurrentUser
$0:=$l_logeado