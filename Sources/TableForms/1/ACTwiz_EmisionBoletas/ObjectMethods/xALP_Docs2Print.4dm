Case of 
	: (alProEvt=1)
		$col:=AL_GetColumn (Self:C308->)
		$row:=AL_GetLine (Self:C308->)
		If ($col=6)
			If (abDoPrint{$row})
				abDoPrint{$row}:=False:C215
				GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apDoPrint{$row})
			Else 
				abDoPrint{$row}:=True:C214
				GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apDoPrint{$row})
			End if 
		End if 
		AL_UpdateArrays (Self:C308->;-1)
End case 