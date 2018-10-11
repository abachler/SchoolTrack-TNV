Case of 
	: (Form event:C388=On Load:K2:1)
		C_BOOLEAN:C305(vb_solicitaUsuario)
		XS_SetInterface 
		OBJECT SET VISIBLE:C603(*;"CapsLockIcon";Caps lock down:C547)
		SET TIMER:C645(20)
		vs_Name:=""
		vs_Password:=""
		OBJECT SET FONT:C164(vs_Password;"%Password")
		GOTO OBJECT:C206(vs_name)
		_O_DISABLE BUTTON:C193(bOK)
		If (vb_solicitaUsuario)
			vs_Name:=<>tUSR_CurrentUser
			OBJECT SET ENTERABLE:C238(vs_Name;False:C215)
		End if 
	: (Form event:C388=On Timer:K2:25)
		OBJECT SET VISIBLE:C603(*;"CapsLockIcon";Caps lock down:C547)
		If (SYS_IsWindows )
			If (Caps lock down:C547)
				C_LONGINT:C283($id;$lErr)
				C_TEXT:C284($tTip;$tText)
				$lErr:=gui_ToolTipCreate (TT_BALLOON)  //balloon 
				GET WINDOW RECT:C443($left;$top;$right;$bottom)
				OBJECT GET COORDINATES:C663(*;"CapsLockIcon";$TT_Left;$TT_Top;$TT_Right;$TT_Bottom)
				$xCoord:=$left+$TT_Right+10
				$yCoord:=$top+$TT_Bottom+20
				$lErr:=gui_ToolTipShowOnCoord (1;"La tecla Todo Mayúsculas está activada lo que puede provocar que su contraseña no"+" sea reconocida.";$xCoord;$yCoord;TT_CLOSE_ON_CLICK;"Todo Mayúsculas";"";150)
			Else 
				$err:=gui_ToolTipHide (1)
				$lErr:=gui_ToolTipDestroyControl 
			End if 
		End if 
	: (Form event:C388=On Unload:K2:2)
		If (SYS_IsWindows )
			$err:=gui_ToolTipHide (1)
			$lErr:=gui_ToolTipDestroyControl 
		End if 
		vb_solicitaUsuario:=False:C215
End case 
