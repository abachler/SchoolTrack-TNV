

$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vdACT_fechaEmisionH:=$Fechafecha
Else 
	vdACT_fechaEmisionH:=!00-00-00!
End if 

