$fechaTemp:=vdFecha2
$fecha:=DT_PopCalendar 
$fechaStr:=String:C10($fecha;7)
If ($fechaStr#dt_GetNullDateString )
	vFecha2:=$fechaStr
	vdFecha2:=$fecha
	If (vdFecha2<vdFecha1)
		BEEP:C151
		vdFecha2:=$fechaTemp
		vFecha2:=String:C10(vdFecha2;7)
	End if 
Else 
	vFecha2:=dt_GetNullDateString 
	vdFecha2:=!00-00-00!
End if 