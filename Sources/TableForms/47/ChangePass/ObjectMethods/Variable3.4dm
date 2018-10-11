Case of 
	: (Form event:C388=On Data Change:K2:15)
		If ([xShell_Users:47]PasswordVersion:10=3)
			$decryptedPass:=USR_DecryptPassword ([xShell_Users:47]xPass:13)
		End if 
		
		If (vsPW_actualPassword#"")
			If ((vsPW_actualPassword=$decryptedPass) | ($decryptedPass=""))
				OBJECT SET ENTERABLE:C238(vsPW_password1;True:C214)
				OBJECT SET ENTERABLE:C238(vsPW_password2;True:C214)
				OBJECT SET ENTERABLE:C238(vsPW_loginName;True:C214)
				_O_DISABLE BUTTON:C193(bEnter)
			Else 
				CD_Dlog (0;__ ("La contraseña ingresada no es válida. Por favor inténtelo nuevamente."))
				Self:C308->:=""
				OBJECT SET ENTERABLE:C238(vsPW_password1;False:C215)
				OBJECT SET ENTERABLE:C238(vsPW_password2;False:C215)
				OBJECT SET ENTERABLE:C238(vsPW_loginName;False:C215)
				_O_DISABLE BUTTON:C193(bEnter)
			End if 
		End if 
		
	: (Form event:C388=On After Keystroke:K2:26)
		Self:C308->:=Get edited text:C655
End case 