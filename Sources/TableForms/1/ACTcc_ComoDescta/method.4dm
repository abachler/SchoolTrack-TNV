Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
		vl_Mes:=Month of:C24(Current date:C33(*))
		vl_Año:=Year of:C25(Current date:C33(*))
		vt_Mes:=aMeses{vl_Mes}
		vl_PrevMes:=vl_Mes
		vl_PrevAño:=vl_Año
		b1:=1
		b2:=0
End case 
