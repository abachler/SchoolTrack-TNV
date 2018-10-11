C_DATE:C307($viniDate;$vendDate)

Case of 
	: (vb_Hoy=1)
		$viniDate:=Current date:C33(*)
		$vendDate:=Current date:C33(*)
	: (vb_Mes=1)
		$viniDate:=DT_GetDateFromDayMonthYear (1;vl_Mes;vl_Año2)
		$vendDate:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vl_Mes;vl_Año2);vl_Mes;vl_Año2)
	: (vb_Año=1)
		$viniDate:=DT_GetDateFromDayMonthYear (1;1;vl_Año)
		$vendDate:=DT_GetDateFromDayMonthYear (31;12;vl_Año)
	: (vb_Rango=1)
		$viniDate:=Date:C102(vt_Fecha1)
		$vendDate:=Date:C102(vt_Fecha2)
End case 

SN3_ActuaDatos_INFO_Actua (1;$viniDate;$vendDate)