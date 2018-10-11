

$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vdACT_fechaEmision:=$Fechafecha
Else 
	vdACT_fechaEmision:=!00-00-00!
End if 

