If ((alProEvt=1) | (alProEvt=2))
	line:=AL_GetLine (ALP_CargosXPagarO)
	Case of 
		: ((alProEvt=1) | (alProEvt=2))
			line:=AL_GetLine (ALP_CargosXPagarO)
			If ((line=0) | (line=1))
				_O_DISABLE BUTTON:C193(bSubir2)
			Else 
				_O_ENABLE BUTTON:C192(bSubir2)
			End if 
			If ((line=0) | (line=Size of array:C274(al_refItemsT)))
				_O_DISABLE BUTTON:C193(bBajar2)
			Else 
				_O_ENABLE BUTTON:C192(bBajar2)
			End if 
	End case 
End if 