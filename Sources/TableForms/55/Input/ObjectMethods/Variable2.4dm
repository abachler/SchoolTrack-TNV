dFrom:=DT_PopCalendar 
If (dFrom<=Current date:C33(*))
	If (dFrom#!00-00-00!)
		If (DateIsValid (dFrom))
		Else 
			dFrom:=!00-00-00!
			HIGHLIGHT TEXT:C210(Self:C308->;1;80)
		End if 
	End if 
Else 
	dFrom:=!00-00-00!
	$l_ignorar:=CD_Dlog (0;__ ("La fecha ingresada es posterior a hoy.\r\rNo es posible registrar un atraso anticipadamente."))
End if 