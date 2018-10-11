Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		xALSet_ACT_ConfigItems2 
		xALSet_ACT_ConfigItemsMatriz 
		xALSet_ACT_ConfigMatrices 
		ACTcfg_LoadConfigData (3)
		vl_ItemsEnMatriz:=0
		UNLOAD RECORD:C212([ACT_Matrices:177])
		REDRAW WINDOW:C456
	: (Form event:C388=On Data Change:K2:15)
		ACTcfg_TestMatrixButtons 
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 
