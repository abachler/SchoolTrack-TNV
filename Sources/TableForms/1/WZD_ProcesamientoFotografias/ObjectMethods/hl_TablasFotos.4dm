C_LONGINT:C283(hl_Fields;vlTableNumber;$table)
C_TEXT:C284($itemText)
If (Selected list items:C379(hl_TablasFotos)>0)
	GET LIST ITEM:C378(hl_TablasFotos;Selected list items:C379(hl_TablasFotos);$table;$itemText)
	HL_ClearList (hl_Fields)
	vlTableNumber:=$table
	
	OBJECT SET VISIBLE:C603(*;"escala@";True:C214)
	_O_ENABLE BUTTON:C192(bNext)
	
End if 