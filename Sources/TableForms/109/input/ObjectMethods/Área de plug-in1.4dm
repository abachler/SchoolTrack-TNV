Case of 
	: (alProEvt=AL Single click event)
		$line:=AL_GetLine (Self:C308->)
		$col:=AL_GetColumn (Self:C308->)
		If ($line>0)
			If ($col=2)
				If (abBU_Asiste{$line})
					abBU_Asiste{$line}:=False:C215
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";ap_Asistencia{$line})
				Else 
					abBU_Asiste{$line}:=True:C214
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";ap_Asistencia{$line})
				End if 
				AL_UpdateArrays (Self:C308->;-1)
			End if 
		End if 
End case 