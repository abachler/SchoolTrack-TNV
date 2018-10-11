If (Self:C308-><=Current date:C33(*))
	If (DateIsValid (Self:C308->))
	Else 
		Self:C308->:=!00-00-00!
	End if 
Else 
	Self:C308->:=!00-00-00!
	$l_ignorar:=CD_Dlog (0;__ ("La fecha ingresada es posterior a hoy.\r\rNo es posible registrar un atraso anticipadamente."))
End if 