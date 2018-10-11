If (DateIsValid (Self:C308->))
	If (dTo<dFrom)
		CD_Dlog (0;__ ("La fecha de término no puede ser superior a la fecha de inicio."))
		dTo:=!00-00-00!
		GOTO OBJECT:C206(dTo)
	End if 
Else 
	Self:C308->:=!00-00-00!
End if 