Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		If (SYS_IsMacintosh )
			r1:=1
			r2:=0
		Else 
			r1:=0
			r2:=1
		End if 
		_O_DISABLE BUTTON:C193(bImport)
End case 