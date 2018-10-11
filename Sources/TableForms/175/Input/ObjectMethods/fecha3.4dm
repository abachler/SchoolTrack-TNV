$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10(DT_GetDateFromDayMonthYear (Day of:C23($Fechafecha);Month of:C24($Fechafecha);Year of:C25($Fechafecha)))
If ($fecha#dt_GetNullDateString )
	vt_ObsDesde:=$fecha
	vd_ObsDesde:=$Fechafecha
Else 
	vt_ObsDesde:=""
	vd_ObsDesde:=!00-00-00!
End if 