Case of 
	: (alProEvt=2)
		$line:=AL_GetLine (Self:C308->)
		READ WRITE:C146([Alumnos_Castigos:9])
		GOTO RECORD:C242([Alumnos_Castigos:9];alCastigos_RecNums{$line})
		If ([Alumnos_Castigos:9]Castigo_cumplido:4=True:C214)
			[Alumnos_Castigos:9]Castigo_cumplido:4:=False:C215
			abCastigo_Cumplimiento{$line}:=False:C215
		Else 
			[Alumnos_Castigos:9]Castigo_cumplido:4:=True:C214
			abCastigo_Cumplimiento{$line}:=True:C214
		End if 
		SAVE RECORD:C53([Alumnos_Castigos:9])
		UNLOAD RECORD:C212([Alumnos_Castigos:9])
		READ ONLY:C145([Alumnos_Castigos:9])
		AL_UpdateArrays (Self:C308->;-2)
End case 