Case of 
	: ((alProEvt=1) | (alProEvt=2))
		$col:=AL_GetColumn (Self:C308->)
		$row:=AL_GetLine (Self:C308->)
		If ($col=1)
			If (abACT_PrintItem2{$row})
				abACT_PrintItem2{$row}:=False:C215
				GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_PrintItem2{$row})
			Else 
				abACT_PrintItem2{$row}:=True:C214
				GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_PrintItem2{$row})
			End if 
			AL_UpdateArrays (Self:C308->;-1)
			$anyoneSelected:=Find in array:C230(abACT_PrintItem2;True:C214)
			IT_SetButtonState (($anyoneSelected#-1);->bGo)
		End if 
End case 