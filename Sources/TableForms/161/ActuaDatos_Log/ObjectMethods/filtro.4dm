C_DATE:C307($viniDate;$vendDate)
C_TEXT:C284($modo)

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
	: (vb_todo=1)
		$viniDate:=!00-00-00!
		$vendDate:=!00-00-00!
End case 

If (vl_selected_page=1)
	Case of 
		: (opc_1=1)
			$modo:="todo"
		: (opc_2=1)
			$modo:="Manual"
		: (opc_3=1)
			$modo:="Auto"
	End case 
	
	SN3_ActuaDatos_LogArrays (vt_apoderado;$viniDate;$vendDate;$modo)
Else 
	SN3_ActuaDatos_LogConfArrays ($viniDate;$vendDate)
End if 