$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10(DT_GetDateFromDayMonthYear (Day of:C23($Fechafecha);Month of:C24($Fechafecha);Year of:C25($Fechafecha)))
If ($fecha#dt_GetNullDateString )
	vtACT_WDTDesde:=$fecha
	vdACT_WDTDesde:=$Fechafecha
Else 
	vtACT_WDTDesde:=dt_GetNullDateString 
	vdACT_WDTDesde:=!00-00-00!
End if 