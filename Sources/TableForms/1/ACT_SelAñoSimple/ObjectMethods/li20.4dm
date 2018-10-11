If (Self:C308-><=2000)
	CD_Dlog (0;__ ("El año no puede ser inferior al 2000."))
	_O_DISABLE BUTTON:C193(bAccept)
Else 
	_O_ENABLE BUTTON:C192(bAccept)
End if 