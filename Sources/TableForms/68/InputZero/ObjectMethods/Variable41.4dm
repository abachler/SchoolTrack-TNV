$line:=AL_GetLine (Self:C308->)
If ($line>0)
	at_CrossRefWord:=$line
	_O_ENABLE BUTTON:C192(bDelXref)
Else 
	_O_DISABLE BUTTON:C193(bDelXref)
End if 