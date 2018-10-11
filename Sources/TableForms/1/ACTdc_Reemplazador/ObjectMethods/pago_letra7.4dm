$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vtACT_LFechaVencimiento:=$fecha
	vdACT_LFechaVencimiento:=$Fechafecha
Else 
	vtACT_LFechaVencimiento:=""
	vdACT_LFechaVencimiento:=!00-00-00!
End if 
If (vdACT_LFechaVencimiento<vdACT_LFechaEmision)
	vtACT_LFechaVencimiento:=dt_GetNullDateString 
	vdACT_LFechaVencimiento:=!00-00-00!
End if 