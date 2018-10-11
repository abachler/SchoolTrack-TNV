Case of 
	: (vb_Hoy=1)
		vd_Fecha1:=Current date:C33(*)
		vd_Fecha2:=Current date:C33(*)
		$vl_retorno:=1
	: (vb_Mes=1)
		$lastday:=DT_GetLastDay (vl_Mes;vl_Año2)
		vd_Fecha1:=DT_GetDateFromDayMonthYear (1;vl_Mes;vl_Año2)
		vd_Fecha2:=DT_GetDateFromDayMonthYear ($lastday;vl_Mes;vl_Año2)
		$vl_retorno:=2
	: (vb_Año=1)
		vd_Fecha1:=DT_GetDateFromDayMonthYear (1;1;vl_Año)
		vd_Fecha2:=DT_GetDateFromDayMonthYear (31;12;vl_Año)
		$vl_retorno:=3
	: (vb_Rango=1)
		vd_Fecha1:=vd_Fecha1
		vd_Fecha2:=vd_Fecha2
		$vl_retorno:=4
	Else 
		vd_Fecha1:=!00-00-00!
		vd_Fecha2:=!00-00-00!
		$vl_retorno:=0
End case 