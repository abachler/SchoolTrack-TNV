Case of 
	: (alProEvt=1)
		$line:=AL_GetLine (xALP_Exams)
		IT_SetButtonState (($line>0);->bDeleteSesion)
	: (alProEvt=2)
		$line:=AL_GetLine (xALP_Exams)
		IT_SetButtonState (($line>0);->bDeleteSesion)
End case 