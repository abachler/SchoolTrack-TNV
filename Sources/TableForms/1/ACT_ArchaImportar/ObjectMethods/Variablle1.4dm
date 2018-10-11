IT_Clairvoyance (Self:C308;->atACT_ItemNames2Charge;"";False:C215)
If (Self:C308->#"")
	$item:=Find in array:C230(atACT_ItemNames2Charge;Self:C308->)
	If ($item#-1)
		atACT_ItemNames2Charge:=$item
		vlACT_selectedItemId:=alACT_ItemIds2Charge{$item}
	End if 
Else 
End if 
