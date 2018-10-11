
Case of 
	: (Form event:C388=On Load:K2:1)
		vt_contraseña:=""
		vt_nombreUsuario:=""
		OBJECT SET FONT:C164(vt_contraseña;"%Password")
		_O_DISABLE BUTTON:C193(bnuevoServer)
		USR_InitVariables 
		USR_GetUserLists 
		WDW_SetFrontmost (Frontmost window:C447)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 
