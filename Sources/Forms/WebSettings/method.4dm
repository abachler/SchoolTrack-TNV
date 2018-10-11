Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		WEB_LoadSettings 
		OBJECT SET ENABLED:C1123(<>web_server_https_puertoHTTPS;(<>web_server_usarSSL=1))
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 