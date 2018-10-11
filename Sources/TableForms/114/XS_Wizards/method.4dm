

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		atXS_AssistantsItems:=0
		_O_DISABLE BUTTON:C193(bIniciar)
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		
	: (Form event:C388=On Resize:K2:27)
		
End case 