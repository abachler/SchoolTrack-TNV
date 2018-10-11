ARRAY INTEGER:C220(alLines;0)
Case of 
	: ((alProEvt=1) | (alProEvt=2) | (alProEvt=-2))
		$r:=AL_GetSelect (xALP_Trans1;alLines)
		If ($r#1)
			$r:=CD_Dlog (2;__ ("No hay suficiente memoria para conservar la selección."))
			ARRAY INTEGER:C220(alLines;0)
		End if 
		If ((Size of array:C274(alLines)#0) & (atSTR_CursoOrigen>0) & (atSTR_CursoDestino>0))
			_O_ENABLE BUTTON:C192(b_Selección)
		Else 
			_O_DISABLE BUTTON:C193(b_Selección)
		End if 
End case 