Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		GET LIST ITEM:C378(hl_ChoiceList;Selected list items:C379(hl_ChoiceList);vl_SelectedListItemRef;vt_SelectedListItemText)
		ACCEPT:C269
	: (Form event:C388=On Selection Change:K2:29)
		$selected:=Selected list items:C379(hl_ChoiceList)
		SELECT LIST ITEMS BY POSITION:C381(hl_ChoiceList;vl_SelectedListItem)
		SET LIST ITEM PROPERTIES:C386(hl_choiceList;*;False:C215;0;0)
		vl_SelectedListItem:=$selected
		SELECT LIST ITEMS BY POSITION:C381(hl_ChoiceList;vl_SelectedListItem)
		SET LIST ITEM PROPERTIES:C386(hl_choiceList;*;False:C215;1;0)
End case 
