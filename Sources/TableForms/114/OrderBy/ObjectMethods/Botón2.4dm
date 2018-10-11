If (Selected list items:C379(hl_OrderDefinition)>0)
	GET LIST ITEM:C378(hl_OrderDefinition;Selected list items:C379(hl_OrderDefinition);$itemRef;$itemText)
	DELETE FROM LIST:C624(hl_OrderDefinition;$itemRef)
	SELECT LIST ITEMS BY POSITION:C381(hl_OrderDefinition;-1)
	_O_REDRAW LIST:C382(hl_OrderDefinition)
	IT_SetButtonState ((Count list items:C380(hl_OrderDefinition)>0);->bClean;->bOrder)
End if 