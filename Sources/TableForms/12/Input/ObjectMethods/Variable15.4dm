dFrom:=DT_PopCalendar 
If (dFrom#!00-00-00!)
	If (DateIsValid (dFrom))
		dTo:=dFrom
	Else 
		dFrom:=!00-00-00!
	End if 
End if 