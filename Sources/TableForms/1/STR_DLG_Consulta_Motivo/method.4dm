Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		WDW_SlideDrawer (->[xxSTR_Constants:1];"STR_DLG_Consulta_Motivo")
		r1:=1
	: (Form event:C388=On Close Box:K2:21)
		POST KEY:C465(27;0)
End case 
