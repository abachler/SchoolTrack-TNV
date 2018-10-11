$item:=Selected list items:C379(Self:C308->)
If ($item>0)
	
	GET LIST ITEM:C378(Self:C308->;$item;$groupID;$groupName)
	$pos:=HL_FindElement (hl_AuthorizedGroups;$groupName)
	If ($pos=-1)
		APPEND TO LIST:C376(hl_AuthorizedGroups;$groupName;$groupID)
		SORT LIST:C391(hl_AuthorizedGroups)
		_O_REDRAW LIST:C382(hl_AuthorizedGroups)
		$pos:=HL_FindElement (hl_AuthorizedGroups;$groupName)
		SELECT LIST ITEMS BY POSITION:C381(hl_AuthorizedGroups;$pos)
	Else 
		BEEP:C151
	End if 
End if 
