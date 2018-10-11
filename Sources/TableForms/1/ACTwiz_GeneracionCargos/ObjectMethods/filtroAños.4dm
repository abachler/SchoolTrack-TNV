C_LONGINT:C283($page)
C_TEXT:C284($itemText)
C_REAL:C285($itemRef)
GET LIST ITEM:C378(l_periodosItems;*;$itemRef;$itemText)

If ($itemRef>0)
	ACTitems_FiltraItemsXPeriodo (False:C215;$itemText)
End if 

