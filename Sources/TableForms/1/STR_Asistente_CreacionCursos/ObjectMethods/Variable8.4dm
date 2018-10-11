
vi_PageNumber:=FORM Get current page:C276
Case of 
	: (FORM Get current page:C276=1)
		vt_errorStatus:="Presione Flecha Derecha para continuar"
		_O_DISABLE BUTTON:C193(bPrev)
		
	: (FORM Get current page:C276=2)
		
		_O_ENABLE BUTTON:C192(bPrev)
		vt_Text:=""
		For ($i;1;Size of array:C274(atWiz_NombresNivel))
			If (alWiz_QtCursos{$i}=1)
				vt_Text:=vt_Text+atWiz_NombresNivel{$i}+": "+String:C10(alWiz_QtCursos{$i})+" curso"+"\r"
			Else 
				vt_Text:=vt_Text+atWiz_NombresNivel{$i}+": "+String:C10(alWiz_QtCursos{$i})+" cursos"+"\r"
			End if 
		End for 
		_O_DISABLE BUTTON:C193(bNext)
End case 