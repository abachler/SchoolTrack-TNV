  //$choice:=IT_PopUpMenu (->atACTvd_GlosasItems;->vtACTpgs_SelectedItem)
  //If ($choice>0)
  //atACTvd_GlosasItems:=$choice
  //vtACTpgs_SelectedItem:=atACTvd_GlosasItems{$choice}
  //vlACTpgs_SelectedItemId:=alACTvd_IdsItems{$choice}
  //ACTpgs_OpcionesVR ("CargaMontoMoneda";->vlACTpgs_SelectedItemId)
  //End if 
  //20111209 RCH Cuando habian muchos items la lista no se veia bien
If (Size of array:C274(atACTvd_GlosasItems)<=50)
	$choice:=IT_PopUpMenu (->atACTvd_GlosasItems;->vtACTpgs_SelectedItem)
Else 
	ARRAY TEXT:C222(atACTvd_GlosasItems_tbl;0)
	COPY ARRAY:C226(atACTvd_GlosasItems;atACTvd_GlosasItems_tbl)
	
	ARRAY POINTER:C280(<>aChoicePtrs;0)
	ARRAY POINTER:C280(<>aChoicePtrs;1)
	<>aChoicePtrs{1}:=->atACTvd_GlosasItems_tbl
	TBL_ShowChoiceList (1;__ ("Seleccione el ítem de cargo");1)
	If (ok=1)
		vtACTpgs_SelectedItem:=atACTvd_GlosasItems_tbl{choiceIdx}
		$choice:=Find in array:C230(atACTvd_GlosasItems;vtACTpgs_SelectedItem)
	Else 
		$choice:=-1
	End if 
	
	AT_Initialize (->atACTvd_GlosasItems_tbl)
End if 

If ($choice>0)
	atACTvd_GlosasItems:=$choice
	vtACTpgs_SelectedItem:=atACTvd_GlosasItems{$choice}
	vlACTpgs_SelectedItemId:=alACTvd_IdsItems{$choice}
	ACTpgs_OpcionesVR ("CargaMontoMoneda";->vlACTpgs_SelectedItemId)
	  //POST KEY(Character code("+");256)
End if 