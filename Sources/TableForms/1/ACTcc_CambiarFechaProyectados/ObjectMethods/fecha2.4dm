$fechaTemp:=vdFecha1
$fecha:=DT_PopCalendar 
$fechaStr:=String:C10($fecha;7)
If ($fechaStr#dt_GetNullDateString )
	vFecha1:=$fechaStr
	vdFecha1:=$fecha
	If (vdFecha1>vdFecha2)
		BEEP:C151
		vdFecha1:=$fechaTemp
		vFecha1:=String:C10(vdFecha1;7)
	End if 
Else 
	vFecha1:=dt_GetNullDateString 
	vdFecha1:=!00-00-00!
End if 