vdSN3_LogHasta:=DT_PopCalendar 
If (vdSN3_LogHasta#!00-00-00!)
	If (vdSN3_LogHasta-vdSN3_LogDesde<0)
		vdSN3_LogDesde:=Add to date:C393(Current date:C33(*);0;0;-14)
		vdSN3_LogHasta:=Current date:C33(*)+1
		CD_Dlog (0;"No es posible buscar por una diferencia superior a 90 días.")
	End if 
Else 
	vdSN3_LogDesde:=Add to date:C393(Current date:C33(*);0;0;-14)
	vdSN3_LogHasta:=Current date:C33(*)+1
	CD_Dlog (0;"Fecha no válida.")
End if 

If ((vdSN3_LogHasta-vdSN3_LogDesde)>90)
	vdSN3_LogDesde:=Add to date:C393(Current date:C33(*);0;0;-14)
	vdSN3_LogHasta:=Current date:C33(*)+1
	CD_Dlog (0;"No es posible buscar por una diferencia superior a 90 días.")
End if 

If (vdSN3_LogDesde>vdSN3_LogHasta)
	vdSN3_LogDesde:=Add to date:C393(Current date:C33(*);0;0;-14)
	vdSN3_LogHasta:=Current date:C33(*)+1
	CD_Dlog (0;"La fecha hasta no puede ser menor a la fecha desde.")
End if 