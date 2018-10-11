$formevent:=Form event:C388
Case of 
	: ($formevent=On Load:K2:1)
		XS_SetInterface 
		  //WDW_SlideDrawer (->[xShell_Dialogs];"AreaChoices";326;311)
		OBJECT SET VISIBLE:C603(*;"vtXS_multiLine";vb_AllowMultiLine)
		WDW_SlideDrawer (->[xShell_Dialogs:114];"AreaChoices")
End case 
