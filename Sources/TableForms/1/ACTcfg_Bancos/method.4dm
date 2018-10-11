Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		xALSet_ACT_ConfigBancos 
		ACTcfg_LoadConfigData (4)
		  //OBJECT SET VISIBLE(*;"developer@";((<>lUSR_CurrentUserID<0) & (<>lUSR_CurrentUserID>-100))) `ticket 97816
		OBJECT SET VISIBLE:C603(*;"developer@";(<>lUSR_CurrentUserID=-6) | (<>lUSR_CurrentUserID=-3))
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 
