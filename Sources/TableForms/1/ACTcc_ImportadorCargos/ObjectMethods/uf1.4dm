$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vdACT_FechaUFSel:=$Fechafecha
Else 
	vdACT_FechaUFSel:=Current date:C33(*)
End if 