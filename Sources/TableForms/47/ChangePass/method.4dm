Case of 
	: (Form event:C388=On Load:K2:1)
		C_BOOLEAN:C305(b_mostrar)
		OBJECT SET VISIBLE:C603(*;"CapsLockIcon";Caps lock down:C547)
		SET TIMER:C645(20)
		$userID:=USR_GetUserID 
		QUERY:C277([xShell_Users:47];[xShell_Users:47]No:1=$userID)
		OBJECT SET ENTERABLE:C238(vsPW_password1;False:C215)
		OBJECT SET ENTERABLE:C238(vsPW_password2;False:C215)
		OBJECT SET ENTERABLE:C238(vsPW_loginName;False:C215)
		vsPW_loginname:=[xShell_Users:47]login:9
		vsPW_ActualPassword:=""
		vsPW_password1:=""
		vsPW_password2:=""
		OBJECT SET FONT:C164(vsPW_ActualPassword;"%Password")
		OBJECT SET FONT:C164(vsPW_password1;"%Password")
		OBJECT SET FONT:C164(vsPW_password2;"%Password")
		_O_DISABLE BUTTON:C193(bEnter)
		
	: (Form event:C388=On After Keystroke:K2:26)
		OBJECT SET ENABLED:C1123(*;"btn_guardar";((vsPW_Password1#"") & (vsPW_Password1=vsPW_Password2) & (vsPW_ActualPassword#vsPW_Password1)))
		  //If ((vsPW_Password1#"") & (vsPW_Password1=vsPW_Password2) & (vsPW_ActualPassword#vsPW_Password1))
		  //_o_ENABLE BUTTON(bOk)
		  //Else 
		  //_o_DISABLE BUTTON(bOk)
		  //End if 
		
	: (Form event:C388=On Data Change:K2:15)
		OBJECT SET ENABLED:C1123(*;"btn_guardar";((ST_ExactlyEqual (vsPW_password1;vsPW_password2)=1) & (vsPW_password1#"") & (vsPW_password2#"") & (vsPW_loginname#"") & (vsPW_ActualPassword#"")))
		  //If ((ST_ExactlyEqual (vsPW_password1;vsPW_password2)=1) & (vsPW_password1#"") & (vsPW_password2#"") & (vsPW_loginname#"") & (vsPW_ActualPassword#""))
		  //_o_ENABLE BUTTON(bEnter)
		  //Else 
		  //_o_DISABLE BUTTON(bEnter)
		  //End if 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Timer:K2:25)
		OBJECT SET VISIBLE:C603(*;"CapsLockIcon";Caps lock down:C547)
		
		
	: (Form event:C388=On Unload:K2:2)
		
End case 
