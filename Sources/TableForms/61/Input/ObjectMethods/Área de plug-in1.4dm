$row:=AL_GetLine (Self:C308->)
If ($row#0)
	If (abBBL_EquivPrincipalGeneral{$row})
		_O_DISABLE BUTTON:C193(bDelMARCGeneral)
	Else 
		_O_ENABLE BUTTON:C192(bDelMARCGeneral)
	End if 
Else 
	_O_DISABLE BUTTON:C193(bDelMARCGeneral)
End if 