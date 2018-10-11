Case of 
	: (Form event:C388=On Drop:K2:12)
		RESOLVE POINTER:C394(Self:C308;$varName;$tableNum;$FieldNum)
		XS_Settings ("HandleDrag";$varName)
	: (Form event:C388=On Clicked:K2:4)
		XS_Settings ("GetQFRelationsProperties")
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Losing Focus:K2:8))
		$selectedItem:=Selected list items:C379(Self:C308->)
		GET LIST ITEM:C378(Self:C308->;$selectedItem;$itemRef;$itemText)
		atVS_QFSourceFieldAlias{$selectedItem}:=$itemText
		XS_Settings ("SavePanelColumnSettings")
	: (Form event:C388=On Double Clicked:K2:5)
		EDIT ITEM:C870(Self:C308->;Selected list items:C379(Self:C308->))
End case 