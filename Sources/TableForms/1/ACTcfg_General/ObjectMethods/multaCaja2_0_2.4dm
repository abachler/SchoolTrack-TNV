$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vdACT_FechaRXC:=$Fechafecha
Else 
	vdACT_FechaRXC:=!00-00-00!
End if 