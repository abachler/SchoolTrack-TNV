Case of 
	: (alProEvt=1)
		$line:=AL_GetLine (xALP_ExportBankFiles)
		If (($line=0) | ($line=1))
			_O_DISABLE BUTTON:C193(bSubirLineaExp)
		Else 
			_O_ENABLE BUTTON:C192(bSubirLineaExp)
		End if 
		
		If (($line=0) | ($line=Size of array:C274(al_Numero)))
			_O_DISABLE BUTTON:C193(bBajarLineaExp)
		Else 
			_O_ENABLE BUTTON:C192(bBajarLineaExp)
		End if 
		If ($line>0)
			_O_ENABLE BUTTON:C192(bDeleteLine)
		Else 
			_O_DISABLE BUTTON:C193(bDeleteLine)
		End if 
	: (alProEvt=2)
		$line:=AL_GetLine (xALP_ExportBankFiles)
		If (($line=0) | ($line=1))
			_O_DISABLE BUTTON:C193(bSubirLineaExp)
		Else 
			_O_ENABLE BUTTON:C192(bSubirLineaExp)
		End if 
		If (($line=0) | ($line=Size of array:C274(al_Numero)))
			_O_DISABLE BUTTON:C193(bBajarLineaExp)
		Else 
			_O_ENABLE BUTTON:C192(bBajarLineaExp)
		End if 
End case 
_O_ENABLE BUTTON:C192(bInsertLine)