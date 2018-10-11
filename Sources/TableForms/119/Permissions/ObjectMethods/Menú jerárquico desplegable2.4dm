
$item:=Selected list items:C379(Self:C308->)
If ($item>0)
	GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$userID;$userName)
	If ($userID>0)
		$pos:=HL_FindElement (hl_authorizedUsers;$userName)
		If ($pos=-1)
			APPEND TO LIST:C376(hl_authorizedUsers;$userName;$userID)
			SORT LIST:C391(hl_authorizedUsers)
			_O_REDRAW LIST:C382(hl_authorizedUsers)
			$pos:=HL_FindElement (hl_authorizedUsers;$userName)
			SELECT LIST ITEMS BY POSITION:C381(hl_authorizedUsers;$pos)
		Else 
			BEEP:C151
		End if 
	Else 
		BEEP:C151
	End if 
End if 