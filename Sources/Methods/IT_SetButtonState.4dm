//%attributes = {}
  //IT_SetButtonState

For ($i;2;Count parameters:C259)
	If ($1)
		_O_ENABLE BUTTON:C192(${$i}->)
	Else 
		_O_DISABLE BUTTON:C193(${$i}->)
	End if 
End for 