$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vtACT_FechaDoc:=$fecha
	vACT_FechaDoc:=$Fechafecha
Else 
	vtACT_FechaDoc:=""
	vACT_FechaDoc:=!00-00-00!
End if 