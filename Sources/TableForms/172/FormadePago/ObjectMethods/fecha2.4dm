$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vdACT_LFechaVencimiento:=$Fechafecha
	vtACT_LFechaVencimiento:=$fecha
Else 
	vdACT_LFechaVencimiento:=!00-00-00!
	vtACT_LFechaVencimiento:=dt_GetNullDateString 
End if 
If (vdACT_LFechaVencimiento<vdACT_LFechaEmision)
	vtACT_LFechaVencimiento:=dt_GetNullDateString 
	vdACT_LFechaVencimiento:=!00-00-00!
End if 