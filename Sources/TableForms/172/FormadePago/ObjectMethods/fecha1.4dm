$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vtACT_FechaDocumento:=$fecha
	vdACT_FechaDocumento:=$Fechafecha
Else 
	vtACT_FechaDocumento:=dt_GetNullDateString 
	vdACT_FechaDocumento:=!00-00-00!
End if 