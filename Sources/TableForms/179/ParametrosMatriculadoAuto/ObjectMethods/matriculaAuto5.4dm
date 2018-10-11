$vd_fechaActual:=vdACTcfg_Fecha
$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vtACTcfg_Fecha:=$fecha
	vdACTcfg_Fecha:=$Fechafecha
Else 
	vtACTcfg_Fecha:=dt_GetNullDateString 
	vdACTcfg_Fecha:=!00-00-00!
End if 

If ((vdACTcfg_Fecha#!00-00-00!) & (vdACTcfg_Fecha#$vd_fechaActual))
	ACTcfg_ItemsMatricula ("CambioFecha")
End if 