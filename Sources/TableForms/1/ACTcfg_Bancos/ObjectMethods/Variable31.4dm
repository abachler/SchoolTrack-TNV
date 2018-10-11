Case of 
	: (alProEvt=1)
		$line:=AL_GetLine (xALP_Bancos)
		If ($line>0)
			If (abACT_BankEstandar{$line})
				IT_SetButtonState ((<>lUSR_CurrentUserID<0);->bClearBank)
				OBJECT SET TITLE:C194(bEstandar;__ ("Marcar como no estándar"))
			Else 
				_O_ENABLE BUTTON:C192(bClearBank)
				OBJECT SET TITLE:C194(bEstandar;__ ("Marcar como estándar"))
			End if 
			_O_ENABLE BUTTON:C192(bEstandar)
		Else 
			_O_DISABLE BUTTON:C193(bClearBank)
			_O_DISABLE BUTTON:C193(bEstandar)
		End if 
End case 