Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		wref:=WDW_GetWindowID 
	: (Form event:C388=On Deactivate:K2:10)
		WDW_SetFrontmost (wref)
End case 
