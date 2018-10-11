If (line>1)
	  //AL_UpdateArrays (ALP_CargosXPagarO;0)
	ACTit_MoveElementALP (ALP_CargosXPagarO;1;->at_glosasItems2;->al_mesCargosT;->al_refItemsT;->alACT_idsRST)
	  //
	  //$temp1:=at_glosasItems2{line}
	  //$temp2:=al_mesCargosT{line}
	  //$temp3:=al_refItemsT{line}
	  //
	  //at_glosasItems2{line}:=at_glosasItems2{line-1}
	  //al_mesCargosT{line}:=al_mesCargosT{line-1}
	  //al_refItemsT{line}:=al_refItemsT{line-1}
	  //
	  //at_glosasItems2{line-1}:=$temp1
	  //al_mesCargosT{line-1}:=$temp2
	  //al_refItemsT{line-1}:=$temp3
	
	  //AL_UpdateArrays (ALP_CargosXPagarO;-2)
	
	AL_SetLine (ALP_CargosXPagarO;line-1)
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