$fechaTemp:=vdACT_FechaDeposito
$fecha:=DT_PopCalendar 
$fechaStr:=String:C10($fecha;7)
If ($fechaStr#dt_GetNullDateString )
	vdACT_FechaDeposito:=$fecha
Else 
	BEEP:C151
	vdFecha1:=$fechaTemp
End if 