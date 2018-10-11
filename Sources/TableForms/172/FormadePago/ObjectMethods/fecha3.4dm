$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vtACT_LFechaEmision:=$fecha
	vdACT_LFechaEmision:=$Fechafecha
Else 
	vtACT_LFechaEmision:=dt_GetNullDateString 
	vdACT_LFechaEmision:=!00-00-00!
End if 
If (vdACT_LFechaVencimiento<vdACT_LFechaEmision)
	vtACT_LFechaEmision:=dt_GetNullDateString 
	vdACT_LFechaEmision:=!00-00-00!
End if 