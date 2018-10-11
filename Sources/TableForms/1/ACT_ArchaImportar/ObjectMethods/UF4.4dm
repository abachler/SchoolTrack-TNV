$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vt_FechaUF:=$fecha
	vd_FechaUF:=$Fechafecha
Else 
	vt_FechaUF:=dt_GetNullDateString 
	vd_FechaUF:=!00-00-00!
End if 