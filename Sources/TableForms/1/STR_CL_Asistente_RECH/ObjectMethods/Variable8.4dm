vi_PageNumber:=FORM Get current page:C276
Case of 
	: (FORM Get current page:C276=1)
		vt_errorStatus:="Presione Flecha Derecha para continuar"
		_O_DISABLE BUTTON:C193(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
	: (FORM Get current page:C276=2)
		
		
		_O_ENABLE BUTTON:C192(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
	: (FORM Get current page:C276=3)
		If (b22=1)
			FORM GOTO PAGE:C247(4)
		Else 
			FORM GOTO PAGE:C247(5)
			_O_ENABLE BUTTON:C192(bPrev)
			_O_DISABLE BUTTON:C193(bNext)
		End if 
	: (FORM Get current page:C276=4)
		_O_ENABLE BUTTON:C192(bPrev)
		_O_DISABLE BUTTON:C193(bNext)
		
End case 

If (r2_Matricula=1)
	OBJECT SET VISIBLE:C603(*;"actas@";False:C215)
	OBJECT SET VISIBLE:C603(*;"matricula@";True:C214)
	OBJECT SET VISIBLE:C603(*;"printdiagnóstico@";False:C215)
	OBJECT SET VISIBLE:C603(*;"diagnóstico@";False:C215)
	_O_DISABLE BUTTON:C193(bDiagnostico)
	_O_DISABLE BUTTON:C193(bEValuar)
	bDiagnostico:=0
	bEValuar:=0
Else 
	OBJECT SET VISIBLE:C603(*;"actas@";False:C215)
	OBJECT SET VISIBLE:C603(*;"matricula@";True:C214)
End if 
