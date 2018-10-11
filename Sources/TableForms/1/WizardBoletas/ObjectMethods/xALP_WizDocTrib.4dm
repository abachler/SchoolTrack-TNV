Case of 
	: (alProEvt=1)
		$row:=AL_GetLine (Self:C308->)
		If ((alACT_WDTRecNums{$row}<0) | (abACT_WDTNulas{$row}))
			_O_ENABLE BUTTON:C192(bDelWBol)
		Else 
			_O_DISABLE BUTTON:C193(bDelWBol)
		End if 
		If (Not:C34(abACT_WDTNulas{$row}))
			_O_ENABLE BUTTON:C192(bAnular)
		Else 
			_O_DISABLE BUTTON:C193(bAnular)
		End if 
End case 