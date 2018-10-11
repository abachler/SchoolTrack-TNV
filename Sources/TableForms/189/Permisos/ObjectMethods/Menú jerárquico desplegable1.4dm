$item:=Selected list items:C379(Self:C308->)
If ($item>0)
	GET LIST ITEM:C378(Self:C308->;$item;$groupID;$groupName)
	$pos:=HL_FindElement (hlQR_AuthorizedGroups;$groupName)
	If ($pos=-1)
		APPEND TO LIST:C376(hlQR_AuthorizedGroups;$groupName;$groupID)
		SORT LIST:C391(hlQR_AuthorizedGroups)
		_O_REDRAW LIST:C382(hlQR_AuthorizedGroups)
		$pos:=HL_FindElement (hlQR_AuthorizedGroups;$groupName)
		SELECT LIST ITEMS BY POSITION:C381(hlQR_AuthorizedGroups;$pos)
		LIST TO BLOB:C556(hlQR_AuthorizedGroups;[MPA_AsignaturasMatrices:189]xPermisos:5)
		LIST TO BLOB:C556(hlQR_authorizedUsers;[MPA_AsignaturasMatrices:189]xPermisos:5;*)
		SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
	Else 
		BEEP:C151
	End if 
End if 
