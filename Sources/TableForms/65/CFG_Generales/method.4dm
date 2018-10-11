Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		PERIODOS_Init 
		PERIODOS_LoadData (0;-2)
		vl_Agno:=Year of:C25(Current date:C33(*))
		<>atXS_MonthNames:=Month of:C24(Current date:C33(*))
		CFG_STR_PeriodosEscolares_NEW ("FillCalendar")
		vdBBL_FechaActual:=Current date:C33(*)
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 