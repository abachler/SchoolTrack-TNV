$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vtACT_FechaProrroga:=$fecha
	vdACT_FechaProrroga:=$Fechafecha
Else 
	vtACT_FechaProrroga:=""
	vdACT_FechaProrroga:=!00-00-00!
End if 
If (vdACT_FechaProrroga>=vdACT_FechaCheque)
	vDias:=vdACT_FechaProrroga-vdACT_FechaCheque
Else 
	BEEP:C151
	vdACT_FechaProrroga:=vdACT_FechaCheque
	vtACT_FechaProrroga:=String:C10(vdACT_FechaProrroga;7)
	vDias:=vdACT_FechaProrroga-vdACT_FechaCheque
	GOTO OBJECT:C206(vdACT_FechaProrroga)
End if 