Case of 
	: (Form event:C388=On Load:K2:1)
		<>dXS_FechaActual:=Current date:C33
		C_LONGINT:C283(nummes)
		C_DATE:C307(<>diaact)
		C_TEXT:C284(varmes)
		<>diaact:=Current date:C33
		<>vardia:=Day of:C23(<>diaact)
		<>varmes:=Month of:C24(<>diaact)
		vl_Agno:=Year of:C25(<>diaact)
		<>atXS_MonthNames:=<>varmes
		varmes:=""
		varmes:=<>atXS_MonthNames{<>atXS_MonthNames}
		Sw:=False:C215
		OBJECT SET COLOR:C271(<>diaact;-108)
		CAL_FillMonth 
		bCalGrid:=0
		XS_SetConfigInterface 
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		ENABLE MENU ITEM:C149(1;4)
	: (Form event:C388=On Menu Selected:K2:14)
	: (Form event:C388=On Close Box:K2:21)
		
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 
