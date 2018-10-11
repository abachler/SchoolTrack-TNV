Case of 
	: (alProEvt=1)
		$col:=AL_GetColumn (Self:C308->)
		$row:=AL_GetLine (Self:C308->)
		If ($col=6)
			If (abACT_PrintBol{$row})
				abACT_PrintBol{$row}:=False:C215
				GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_PrintBol{$row})
			Else 
				abACT_PrintBol{$row}:=True:C214
				GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_PrintBol{$row})
			End if 
			AL_UpdateArrays (Self:C308->;-1)
			IT_SetButtonState ((Find in array:C230(abACT_PrintBol;True:C214)#-1);->bPrintBol)
		End if 
End case 