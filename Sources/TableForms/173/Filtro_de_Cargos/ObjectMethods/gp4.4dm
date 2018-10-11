$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vt_Fecha1:=$fecha
	vd_Fecha1:=$Fechafecha
Else 
	vt_Fecha1:=""
	vd_Fecha1:=!00-00-00!
End if 

If (vd_Fecha1>vd_Fecha2)
	CD_Dlog (0;__ ("La fecha Desde no puede ser mayor que la fecha Hasta."))
	vd_Fecha1:=vd_fecha_ini_conf
	vt_Fecha1:=String:C10(vd_Fecha1;7)
End if 