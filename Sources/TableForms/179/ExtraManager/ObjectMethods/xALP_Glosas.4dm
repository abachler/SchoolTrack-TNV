Case of 
	: ((alProEvt=1) | (alProEvt=2))
		$line:=AL_GetLine (xALP_Glosas)
		$col:=AL_GetColumn (xALP_Glosas)
		IT_SetButtonState (($line>0);->bDelete)
		If ($col=6)
			If (abACT_ImputacionUnica{$line})
				abACT_ImputacionUnica{$line}:=False:C215
				GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ImputacUnicaPict{$line})
			Else 
				abACT_ImputacionUnica{$line}:=True:C214
				GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ImputacUnicaPict{$line})
			End if 
			AL_UpdateArrays (Self:C308->;-1)
			vbACT_ModGlosasExtra:=True:C214
		End if 
End case 