$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10(DT_GetDateFromDayMonthYear (Day of:C23($Fechafecha);Month of:C24($Fechafecha);Year of:C25($Fechafecha)))
If ($fecha#dt_GetNullDateString )
	vt_TransHasta:=$fecha
	vd_TransHasta:=$Fechafecha
	cb_todas:=0
Else 
	vt_TransHasta:=""
	vd_TransHasta:=!00-00-00!
End if 