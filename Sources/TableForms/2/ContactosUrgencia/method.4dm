Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		_O_DISABLE BUTTON:C193(bDelContacto)
		LISTBOX SELECT ROW:C912(*;"contactos";0;lk remove from selection:K53:3)
	: (Form event:C388=On Close Box:K2:21)
		ACCEPT:C269
End case 
