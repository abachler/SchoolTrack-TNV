$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vdFechaObs:=Date:C102($fecha)
	_O_ENABLE BUTTON:C192(bAccept)
Else 
	vdFechaObs:=!00-00-00!
	_O_DISABLE BUTTON:C193(bAccept)
End if 