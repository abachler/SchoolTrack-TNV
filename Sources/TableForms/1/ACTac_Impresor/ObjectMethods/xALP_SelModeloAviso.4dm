Case of 
	: (alProEvt=1)
		$col:=AL_GetColumn (Self:C308->)
		$row:=AL_GetLine (Self:C308->)
		If ($col=1)
			For ($i;1;Size of array:C274(abACT_ModeloSel))
				apACT_ModeloSel{$i}:=apACT_ModeloSel{$i}*0
				abACT_ModeloSel{$i}:=False:C215
			End for 
			GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ModeloSel{$row})
			abACT_ModeloSel{$row}:=True:C214
			PREF_Set (0;"ACT_AvisoSeleccionado2Print";String:C10(abACT_ModeloID{$row}))
			AL_UpdateArrays (Self:C308->;-1)
			_O_ENABLE BUTTON:C192(bNext)
			atACT_ModelosAviso:=$row
		End if 
End case 