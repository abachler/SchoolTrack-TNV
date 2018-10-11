$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vt_Fecha3:=$fecha
	vd_Fecha3:=$Fechafecha
Else 
	vt_Fecha3:=""
	vd_Fecha3:=!00-00-00!
End if 