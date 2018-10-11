vi_PageNumber:=FORM Get current page:C276
Case of 
	: (FORM Get current page:C276=1)
		vt_errorStatus:="Presione Flecha Derecha para continuar"
		_O_DISABLE BUTTON:C193(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
	: (FORM Get current page:C276=2)
		_O_ENABLE BUTTON:C192(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
		vt_Nivel:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;-><>al_NumeroNivelesOficiales{<>al_NumeroNivelesOficiales};->[xxSTR_Niveles:6]Nivel:1)
		AL_SetScroll (xALP_PlanNivel;1;1)
	: (FORM Get current page:C276=3)
		_O_ENABLE BUTTON:C192(bPrev)
		_O_DISABLE BUTTON:C193(bNext)
End case 