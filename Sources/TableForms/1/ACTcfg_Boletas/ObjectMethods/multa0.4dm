IT_Clairvoyance (Self:C308;->at_GlosasItems;"";False:C215)
If (Self:C308->#"")
	$item:=Find in array:C230(at_GlosasItems;Self:C308->)
	If ($item#-1)
		at_GlosasItems:=$item
		vtACTcfg_SelectedItemName:=at_GlosasItems{$item}
		vlACTcfg_SelectedItemId:=al_IdsItems{$item}
	End if 
End if 