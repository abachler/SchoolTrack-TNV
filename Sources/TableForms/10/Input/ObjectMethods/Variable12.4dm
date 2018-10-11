If (Self:C308-><=Current date:C33(*))
	If (DateIsValid (dTo))
		If (dTo<dFrom)
			CD_Dlog (0;__ ("La fecha de término no puede ser inferior a la fecha de inicio."))
			dTo:=dFrom
		End if 
	Else 
		dTo:=dFrom
	End if 
Else 
	Self:C308->:=!00-00-00!
	dTo:=dFrom
	$l_ignorar:=CD_Dlog (0;__ ("La fecha ingresada es posterior a hoy.\r\rNo es posible registrar una inasistencia anticipadamente."))
End if 