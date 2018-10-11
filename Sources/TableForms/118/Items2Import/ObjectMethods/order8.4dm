If (line<Size of array:C274(al_refItemsT))
	ACTit_MoveElementALP (ALP_CargosXPagarO;0;->at_glosasItems2;->al_mesCargosT;->al_refItemsT;->alACT_idsRST)
	AL_SetLine (ALP_CargosXPagarO;line+1)
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
	
End if 