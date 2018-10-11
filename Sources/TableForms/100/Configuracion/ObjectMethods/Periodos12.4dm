C_TEXT:C284($itemText;$text)
C_LONGINT:C283($itemRef)
Case of 
	: (Form event:C388=On After Keystroke:K2:26)
		$text:=Get edited text:C655
		GET LIST ITEM:C378(hl_periodosEscolares;*;$itemRef;$itemText)
		SET LIST ITEM:C385(hl_periodosEscolares;*;$text;$itemRef)
		_O_REDRAW LIST:C382(hl_periodosEscolares)
	: (Form event:C388=On Data Change:K2:15)
		CFG_STR_PeriodosEscolares_NEW ("GuardaDatosPeriodo")
End case 