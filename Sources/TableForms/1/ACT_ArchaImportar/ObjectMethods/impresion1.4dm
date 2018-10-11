$choice:=Pop up menu:C542(vt_ItemNames)
If ($choice>0)
	vsACT_SelectedItemName:=atACT_ItemNames2Charge{$choice}
	atACT_ItemNames2Charge:=$choice
	vlACT_selectedItemId:=alACT_ItemIds2Charge{$choice}
End if 