If (alProEvt=1)
	$line:=AL_GetLine (Self:C308->)
	If ($line>0)
		GOTO RECORD:C242([Alumnos:2];aStdRecNo{$line})
	Else 
		REDUCE SELECTION:C351([Alumnos:2];0)
	End if 
	PF_TutoriasTabBrowser 
End if 