$choice:=IT_PopUpMenu (->at_GlosasItems;->vtACTcfg_SelectedItemName)
If ($choice>0)
	at_GlosasItems:=$choice
	vtACTcfg_SelectedItemName:=at_GlosasItems{$choice}
	vlACT_idItemMulta:=al_IdsItems{$choice}
End if 
