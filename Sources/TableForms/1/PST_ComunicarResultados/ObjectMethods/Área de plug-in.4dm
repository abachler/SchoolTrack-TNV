Case of 
	: (alProEvt=AL Empty Area Single click)
		AL_SetLine (xALP_ComunicacionResultados;0)
	: (alProEvt=AL Empty Area Double click)
		AL_SetLine (xALP_ComunicacionResultados;0)
	: (alProEvt=2)
		  //AL_SetLine (xALP_ComunicacionResultados;0)
		  //asigno lo que se selecciono como resultados comunicados
		$row:=AL_GetLine (xALP_ComunicacionResultados)
		$col:=AL_GetColumn (xALP_ComunicacionResultados)
		AL_GetCellValue (xALP_ComunicacionResultados;$row;$col;$value)
		
		[ADT_Candidatos:49]FormaComunicarResultados:58:=$value
		CANCEL:C270
End case 