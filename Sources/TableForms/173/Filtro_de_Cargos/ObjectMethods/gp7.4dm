$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vt_Fecha2:=$fecha
	vd_Fecha2:=$Fechafecha
Else 
	vt_Fecha2:=""
	vd_Fecha2:=!00-00-00!
End if 

If (vd_Fecha2<vd_Fecha1)
	CD_Dlog (0;__ ("La fecha Hasta no puede ser inferior a la fecha Desde."))
	vd_Fecha2:=vd_fecha_end_conf
	vt_Fecha2:=String:C10(vd_Fecha2;7)
End if 


