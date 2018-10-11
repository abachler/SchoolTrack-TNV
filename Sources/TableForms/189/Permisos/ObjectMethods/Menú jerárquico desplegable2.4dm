
$item:=Selected list items:C379(Self:C308->)
If ($item>0)
	GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$userID;$userName)
	If ($userID>0)
		$pos:=HL_FindElement (hlQR_authorizedUsers;$userName)
		If ($pos=-1)
			APPEND TO LIST:C376(hlQR_authorizedUsers;$userName;$userID)
			SORT LIST:C391(hlQR_authorizedUsers)
			_O_REDRAW LIST:C382(hlQR_authorizedUsers)
			$pos:=HL_FindElement (hlQR_authorizedUsers;$userName)
			SELECT LIST ITEMS BY POSITION:C381(hlQR_authorizedUsers;$pos)
			LIST TO BLOB:C556(hlQR_AuthorizedGroups;[MPA_AsignaturasMatrices:189]xPermisos:5)
			LIST TO BLOB:C556(hlQR_authorizedUsers;[MPA_AsignaturasMatrices:189]xPermisos:5;*)
			SAVE RECORD:C53([MPA_AsignaturasMatrices:189])
		Else 
			BEEP:C151
		End if 
	Else 
		BEEP:C151
	End if 
End if 