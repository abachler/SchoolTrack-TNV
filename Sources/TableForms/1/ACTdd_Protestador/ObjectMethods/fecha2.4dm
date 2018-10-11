$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vtACT_FechaProtesto:=$fecha
	vdACT_FechaProtesto:=$Fechafecha
Else 
	vtACT_FechaProtesto:=""
	vdACT_FechaProtesto:=!00-00-00!
End if 