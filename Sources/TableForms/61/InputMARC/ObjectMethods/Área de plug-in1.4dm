$row:=AL_GetLine (xALP_MARCInput)
If ($row#0)
	If (abBBL_EquivPrincipal{$row})
		_O_DISABLE BUTTON:C193(bDelMARC)
	Else 
		_O_ENABLE BUTTON:C192(bDelMARC)
	End if 
Else 
	_O_DISABLE BUTTON:C193(bDelMARC)
End if 