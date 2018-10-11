$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vt_FechaENF:=$fecha
	vd_FechaENF:=$Fechafecha
Else 
	vt_FechaENF:=""
	vd_FechaENF:=!00-00-00!
End if 