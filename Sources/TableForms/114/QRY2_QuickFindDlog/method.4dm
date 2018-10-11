$event:=Form event:C388
Case of 
	: ($event=On Load:K2:1)
		aDelims:=1
		vtQRY_ValorLiteral:=""
		atVS_QFSourceFieldAlias:=1
		aDelims:=1
		o1:=1
		binSel:=0
		vText1:=__ ("La búsqueda se efectuará sobre la totalidad de la base de datos.")
		ARRAY TEXT:C222(popChoice;0)
		WDW_SlideDrawer (->[xShell_Dialogs:114];"QRY2_QuickFindDlog")
		QF2_Choices 
End case 