If (Form event:C388=On After Keystroke:K2:26)
	If (Get edited text:C655#"")
		_O_ENABLE BUTTON:C192(bOK)
	Else 
		_O_DISABLE BUTTON:C193(bOK)
	End if 
End if 