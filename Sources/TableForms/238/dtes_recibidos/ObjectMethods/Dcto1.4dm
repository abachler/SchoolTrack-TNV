

$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vdACT_fechaRecepcion:=$Fechafecha
Else 
	vdACT_fechaRecepcion:=!00-00-00!
End if 

