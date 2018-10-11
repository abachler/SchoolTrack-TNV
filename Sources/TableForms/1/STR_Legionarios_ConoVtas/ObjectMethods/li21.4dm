$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)

If ($fecha#dt_GetNullDateString )
	vt_Fecha:=$fecha
	vd_Fecha:=$Fechafecha
Else 
	vt_Fecha:=""
	vd_Fecha:=!00-00-00!
End if 