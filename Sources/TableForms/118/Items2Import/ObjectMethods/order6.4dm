If (line<Size of array:C274(al_idItems))
	Case of 
		: (vb_selectionItems2Pay)
			ACTit_MoveElementALP (ALP_CargosXPagar;0;->ap_item2Import;->at_glosasItems;->al_idItems;->ab_Item2Import;->alACT_idsRSOrg)
			  //$temp1:=ap_item2Import{line}
			  //$temp2:=at_glosasItems{line}
			  //$temp3:=al_idItems{line}
			  //$temp4:=ab_Item2Import{line}
			  //
			  //ap_item2Import{line}:=ap_item2Import{line+1}
			  //at_glosasItems{line}:=at_glosasItems{line+1}
			  //al_idItems{line}:=al_idItems{line+1}
			  //ab_Item2Import{line}:=ab_Item2Import{line+1}
			  //
			  //ap_item2Import{line+1}:=$temp1
			  //at_glosasItems{line+1}:=$temp2
			  //al_idItems{line+1}:=$temp3
			  //ab_Item2Import{line+1}:=$temp4
			
		: (vb_selectionOrder2PayItems)
			ACTit_MoveElementALP (ALP_CargosXPagar;0;->at_glosasItems;->al_idItems;->ab_Item2Import;->alACT_idsRSOrg)
			  //$temp2:=at_glosasItems{line}
			  //$temp3:=al_idItems{line}
			  //$temp4:=ab_Item2Import{line}
			  //
			  //at_glosasItems{line}:=at_glosasItems{line+1}
			  //al_idItems{line}:=al_idItems{line+1}
			  //ab_Item2Import{line}:=ab_Item2Import{line+1}
			  //
			  //at_glosasItems{line+1}:=$temp2
			  //al_idItems{line+1}:=$temp3
			  //ab_Item2Import{line+1}:=$temp4
	End case 
	AL_UpdateArrays (ALP_CargosXPagar;0)
	AL_UpdateArrays (ALP_CargosXPagarO;0)
	ACTcfg_OpcionesImportCargos ("OrdenaCargos")
	AL_UpdateArrays (ALP_CargosXPagarO;-2)
	AL_UpdateArrays (ALP_CargosXPagar;-2)
	
	AL_SetLine (ALP_CargosXPagar;line+1)
	line:=AL_GetLine (ALP_CargosXPagar)
	
	If ((line=0) | (line=1))
		_O_DISABLE BUTTON:C193(bSubir)
	Else 
		_O_ENABLE BUTTON:C192(bSubir)
	End if 
	
	If ((line=0) | (line=Size of array:C274(al_idItems)))
		_O_DISABLE BUTTON:C193(bBajar)
	Else 
		_O_ENABLE BUTTON:C192(bBajar)
	End if 
	
End if 