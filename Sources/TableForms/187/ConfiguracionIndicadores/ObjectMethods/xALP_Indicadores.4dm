$result:=0
Case of 
	: (alProEvt=AL Single Control Click)
		$result:=Pop up menu:C542("Nuevo Indicador;Eliminar indicador")
	: ((alProEvt=AL Empty Area Single click) | (alProEvt=AL Empty Area Control Click))
		$result:=Pop up menu:C542("Nuevo Indicador;(Eliminar indicador")
End case 


Case of 
	: ($result=1)
		AL_UpdateArrays (Self:C308->;0)
		AT_Insert (0;1;->aiEVLG_Indicadores_Valor;->atEVLG_Indicadores_Descripcion;->atEVLG_Indicadores_Concepto)
		AL_UpdateArrays (Self:C308->;-2)
		AL_GotoCell (Self:C308->;1;Size of array:C274(aiEVLG_Indicadores_Valor))
		
	: ($result=2)
		$line:=AL_GetLine (Self:C308->)
		AL_UpdateArrays (Self:C308->;0)
		AT_Delete ($line;1;->aiEVLG_Indicadores_Valor;->atEVLG_Indicadores_Descripcion;->atEVLG_Indicadores_Concepto)
		AL_UpdateArrays (Self:C308->;-2)
		
End case 