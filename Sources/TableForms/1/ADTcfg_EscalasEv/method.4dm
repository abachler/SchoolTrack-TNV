Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		PST_ReadParameters 
		xALP_SetIndicadores 
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 


  //PST_SaveParameters