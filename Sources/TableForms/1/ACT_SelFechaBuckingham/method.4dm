Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		vb_Hoy:=0
		vb_Mes:=1
		vb_Año:=0
		vb_Rango:=0
		ARRAY TEXT:C222(aMeses;0)
		COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
		vl_Mes:=Month of:C24(Current date:C33(*))
		vt_Mes:=aMeses{vl_Mes}
		vl_Año:=Year of:C25(Current date:C33(*))
		vd_Fecha1:=Current date:C33(*)
		vd_Fecha2:=Current date:C33(*)
		vt_Fecha1:=String:C10(vd_Fecha1;7)
		vt_Fecha2:=String:C10(vd_Fecha2;7)
		OBJECT SET ENTERABLE:C238(vl_Año;False:C215)
		OBJECT SET ENTERABLE:C238(vt_Fecha1;False:C215)
		OBJECT SET ENTERABLE:C238(vt_Fecha2;False:C215)
		_O_ENABLE BUTTON:C192(bMes)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
