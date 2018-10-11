If (vDias>=0)
	vdACT_FechaProrroga:=vdACT_FechaProrroga+vDias
Else 
	vDias:=0
	vdACT_FechaProrroga:=vdACT_FechaCheque
	BEEP:C151
	GOTO OBJECT:C206(vDias)
End if 
vtACT_FechaProrroga:=String:C10(vdACT_FechaProrroga;7)