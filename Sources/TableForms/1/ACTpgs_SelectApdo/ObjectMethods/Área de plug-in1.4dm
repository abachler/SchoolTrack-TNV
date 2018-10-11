Case of 
	: (alProEvt=2)
		$line:=AL_GetLine (Self:C308->)
		If ($line#0)
			RNApdo:=aRNApdo{$line}
			EsApdoCta:=aEsApdoCta{$line}
			ACCEPT:C269
		End if 
	: (alProEvt=1)
		$line:=AL_GetLine (Self:C308->)
		IT_SetButtonState (($line#0);->bOK)
End case 