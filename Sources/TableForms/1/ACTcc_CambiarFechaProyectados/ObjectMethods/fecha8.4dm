$fecha:=DT_PopCalendar 
$fechaStr:=String:C10($fecha;7)
If ($fechaStr#dt_GetNullDateString )
	vFecha3:=$fechaStr
	vdFecha3:=$fecha
Else 
	vFecha3:=dt_GetNullDateString 
	vdFecha3:=!00-00-00!
End if 