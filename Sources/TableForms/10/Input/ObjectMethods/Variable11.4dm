  //If (Self->>=Current date(*))
If (Self:C308-><=Current date:C33(*))
	If (DateIsValid (Self:C308->))
		dTo:=Self:C308->
	Else 
		Self:C308->:=!00-00-00!
		dTo:=Self:C308->
	End if 
Else 
	Self:C308->:=!00-00-00!
	dTo:=Self:C308->
	$l_ignorar:=CD_Dlog (0;__ ("La fecha ingresada es posterior a hoy.\r\rNo es posible registrar una inasistencia anticipadamente."))
End if 