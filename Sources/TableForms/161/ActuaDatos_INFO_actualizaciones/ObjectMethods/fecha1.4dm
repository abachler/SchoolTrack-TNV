$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vt_Fecha2:=$fecha
	vd_Fecha2:=$Fechafecha
Else 
	vt_Fecha2:=""
	vd_Fecha2:=!00-00-00!
End if 