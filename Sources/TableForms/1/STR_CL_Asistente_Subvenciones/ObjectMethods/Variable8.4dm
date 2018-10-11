
Case of 
	: (FORM Get current page:C276=1)
		vt_errorStatus:="Presione Flecha Derecha para continuar"
		_O_DISABLE BUTTON:C193(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
	: (FORM Get current page:C276=2)
		_O_ENABLE BUTTON:C192(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
	: (FORM Get current page:C276=3)
		_O_ENABLE BUTTON:C192(bPrev)
		_O_DISABLE BUTTON:C193(bNext)
End case 

Case of 
	: (vi_PageNumber=2)
		If (Size of array:C274(at_Mineduc_Nivel)=0)
			MINEDUC_DatosCursos 
		End if 
		MINEDUC_SetCursosALParea (aMeses)
End case 