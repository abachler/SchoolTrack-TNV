dTo:=DT_PopCalendar 
If ((dTo<=Current date:C33(*)) & (dTo>=dFrom))
	If (DateIsValid (dTo))
		If (dTo<dTo)
			CD_Dlog (0;__ ("La fecha de término no puede ser superior a la fecha de inicio."))
			dTo:=dFrom
		End if 
	Else 
		dTo:=dFrom
	End if 
Else 
	If (dTo<dFrom)
		$l_ignorar:=CD_Dlog (0;__ ("La fecha de término no puede ser inferior a la fecha de inicio."))
	Else 
		$l_ignorar:=CD_Dlog (0;__ ("La fecha ingresada es posterior a hoy.\r\rNo es posible registrar una inasistencia anticipadamente."))
	End if 
	dTo:=dFrom
End if 