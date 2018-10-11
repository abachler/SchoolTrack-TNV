
$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vtACT_FechaInt:=$fecha
	vdACT_fechaIntereses:=$Fechafecha
Else 
	vdACT_fechaIntereses:=!00-00-00!
	vtACT_FechaInt:=""
End if 