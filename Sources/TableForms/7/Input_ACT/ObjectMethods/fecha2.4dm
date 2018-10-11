$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10(DT_GetDateFromDayMonthYear (Day of:C23($Fechafecha);Month of:C24($Fechafecha);Year of:C25($Fechafecha)))
If ($fecha#dt_GetNullDateString )
	vt_TransDesde:=$fecha
	vd_TransDesde:=$Fechafecha
Else 
	vt_TransDesde:=""
	vd_TransDesde:=!00-00-00!
End if 