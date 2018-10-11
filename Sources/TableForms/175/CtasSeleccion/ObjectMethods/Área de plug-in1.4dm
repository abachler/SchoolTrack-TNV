Case of 
	: ((alProEvt=1) | (alProEvt=2))
		$col:=AL_GetColumn (Self:C308->)
		$row:=AL_GetLine (Self:C308->)
		If ($col=1)
			If (abACT_PrintItem{$row})
				abACT_PrintItem{$row}:=False:C215
				GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_PrintItem{$row})
			Else 
				abACT_PrintItem{$row}:=True:C214
				GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_PrintItem{$row})
			End if 
			AL_UpdateArrays (Self:C308->;-1)
			$anyoneSelected:=Find in array:C230(abACT_PrintItem;True:C214)
			IT_SetButtonState (($anyoneSelected#-1);->bGo)
		End if 
End case 