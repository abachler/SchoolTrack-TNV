If ((b1=1) | ((b2=1) & (vsGlosab2#"")) | ((b3=1) & (vsGlosab3#"")) | ((b2=1) & (cbTodosb2=1)) | ((b3=1) & (cbTodosb3=1)))
	_O_ENABLE BUTTON:C192(bNext)
Else 
	_O_DISABLE BUTTON:C193(bNext)
End if 