Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		OBJECT SET TITLE:C194(r1;vtBtn1)
		OBJECT SET TITLE:C194(r2;vtBtn2)
		WDW_SlideDrawer (->[xxACT_GlosasExtraordinarias:5];"ACT_DLG_ModGExtras")
		r1:=1
	: (Form event:C388=On Close Box:K2:21)
		POST KEY:C465(27;0)
End case 
