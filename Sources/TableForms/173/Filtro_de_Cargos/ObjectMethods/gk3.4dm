$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vt_Fecha1:=$fecha
	vd_Fecha1:=$Fechafecha
Else 
	vt_Fecha1:=""
	vd_Fecha1:=!00-00-00!
End if 

