$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vdACTp_BusquedaFecha:=$Fechafecha
Else 
	vdACTp_BusquedaFecha:=Current date:C33(*)
End if 