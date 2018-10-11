$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10(DT_GetDateFromDayMonthYear (Day of:C23($Fechafecha);Month of:C24($Fechafecha);Year of:C25($Fechafecha)))
If ($fecha#dt_GetNullDateString )
	vtACT_WDTHasta:=$fecha
	vdACT_WDTHasta:=$Fechafecha
Else 
	vtACT_WDTHasta:=dt_GetNullDateString 
	vdACT_WDTHasta:=!00-00-00!
End if 