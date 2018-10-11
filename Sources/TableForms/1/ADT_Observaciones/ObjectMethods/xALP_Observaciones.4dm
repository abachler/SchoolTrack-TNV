Case of 
	: ((alProEvt=AL Single click event) | (alProEvt=AL Empty Area Single click))
		$row:=AL_GetLine (Self:C308->)
		IT_SetButtonState (($row>0);->bDelObs)
End case 