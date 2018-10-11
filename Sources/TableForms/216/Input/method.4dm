Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		If (Is new record:C668([Profesores_Titulos:216]))
			[Profesores_Titulos:216]ID_Profesor:5:=[Profesores:4]Numero:1
		End if 
		If ([Profesores_Titulos:216]Titulo:1="")
			_O_DISABLE BUTTON:C193(bdel)
		End if 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
