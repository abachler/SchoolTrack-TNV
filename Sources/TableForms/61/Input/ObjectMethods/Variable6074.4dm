If (Form event:C388=On Double Clicked:K2:5)
	$listitem:=Selected list items:C379(Self:C308->)
	GET LIST ITEM:C378(Self:C308->;$listItem;$itemRef;$itemText)
	If ([BBL_Items:61]Publico_bitArray:46 ?? $itemRef)
		[BBL_Items:61]Publico_bitArray:46:=[BBL_Items:61]Publico_bitArray:46 ?- $itemRef
		SET LIST ITEM PROPERTIES:C386(Self:C308->;$itemRef;False:C215;0;0)
	Else 
		[BBL_Items:61]Publico_bitArray:46:=[BBL_Items:61]Publico_bitArray:46 ?+ $itemRef
		SET LIST ITEM PROPERTIES:C386(Self:C308->;$itemRef;False:C215;1;0)
	End if 
End if 
_O_REDRAW LIST:C382(Self:C308->)

[BBL_Items:61]Interes:21:=""
For ($i;1;Count list items:C380(<>hl_interestList))
	GET LIST ITEM:C378(<>hl_interestList;$i;$itemRef;$itemText)
	If ([BBL_Items:61]Publico_bitArray:46 ?? $itemRef)
		[BBL_Items:61]Interes:21:=[BBL_Items:61]Interes:21+"\r"+$itemText
	End if 
End for 
[BBL_Items:61]Interes:21:=ST_ClearExtraCR ([BBL_Items:61]Interes:21)
