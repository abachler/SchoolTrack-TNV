dTo:=DT_PopCalendar 
If (dTo#!00-00-00!)
	If (DateIsValid (dTo))
		If (dTo<dFrom)
			CD_Dlog (0;__ ("La fecha de término no puede ser superior a la fecha de inicio."))
			dTo:=!00-00-00!
		End if 
	Else 
		dTo:=!00-00-00!
	End if 
End if 