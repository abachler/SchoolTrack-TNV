Case of 
	: (alProEvt=1)
		$line:=AL_GetLine (xALP_Impuesto)
		IT_SetButtonState (($line>0);->bDeleteImpuesto)
End case 

  //alACT_AñoTasaImpuesto
  //arACT_TasaMesImpuesto
  //arACT_TasaMaximaImpuesto