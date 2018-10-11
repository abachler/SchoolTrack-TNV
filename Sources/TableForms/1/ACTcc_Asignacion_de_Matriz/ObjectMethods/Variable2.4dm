Case of 
	: (vi_PageNumber=1)
		vi_PageNumber:=2
	: (vi_PageNumber=2)
		If (vsACT_AsignedMatrix="")
			CD_Dlog (0;__ ("Por favor seleccione la matriz de cargo que desea asignar."))
		Else 
			  //If (vsACT_FrecFact="")
			  //cd_Dlog (0;"Por favor seleccione la frecuencia de facturación.")
			  //Else 
			vi_PageNumber:=3
			  //End if 
		End if 
	: (vi_PageNumber=3)
		If (f3=1)
			$resp:=CD_Dlog (0;__ ("Se asignarán Matrices de Cargo a todos los alumnos activos. ¿Desea Continuar?");__ ("");__ ("No");__ ("Si"))
			If ($resp=2)
				vi_PageNumber:=4
			Else 
				vi_PageNumber:=3
			End if 
		Else 
			vi_PageNumber:=4
		End if 
	: (vi_PageNumber=4)
		vi_PageNumber:=5
End case 
_O_ENABLE BUTTON:C192(bPrev)
FORM GOTO PAGE:C247(vi_PageNumber)
POST KEY:C465(Character code:C91("+");256)