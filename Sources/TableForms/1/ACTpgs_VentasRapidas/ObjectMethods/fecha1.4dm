$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vtACT_FechaE:=$fecha
	vdACT_FechaE:=$Fechafecha
Else 
	vtACT_FechaE:=dt_GetNullDateString 
	vdACT_FechaE:=!00-00-00!
End if 