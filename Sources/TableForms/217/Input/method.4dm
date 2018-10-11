Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		If ([Profesores]Carrera'Cargo="")
			_O_DISABLE BUTTON:C193(bDel)
		End if 
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
