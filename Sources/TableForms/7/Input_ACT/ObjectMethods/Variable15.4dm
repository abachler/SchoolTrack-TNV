Case of 
	: (alProEvt=0)
		AL_ExitCell (Self:C308->)
	: (alProEvt=1)
		$line:=AL_GetLine (Self:C308->)
		IT_SetButtonState (($line>0);->bDelObs)
End case 