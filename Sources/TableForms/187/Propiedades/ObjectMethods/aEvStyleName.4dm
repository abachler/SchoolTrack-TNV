If (Self:C308->>0)
	[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7:=aEvStyleId{Self:C308->}
	
	  // si es un nuevo registro asigno a variable el estilo de evaluacion para mantenerlo mientras no se cambie el area, el eje o la dimensión 
	If (Is new record:C668([MPA_DefinicionCompetencias:187]))
		vlMPA_EstiloEvaluacionComp:=[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7
	End if 
	
	Case of 
		: (iEvaluationMode=Notas)
			[MPA_DefinicionCompetencias:187]Escala_Minimo:20:=rGradesFrom
			[MPA_DefinicionCompetencias:187]Escala_Maximo:21:=rGradesTo
			[MPA_DefinicionCompetencias:187]PctParaAprobacion:22:=rPctMinimum
			viEVLG_RequeridoCompetencia:=rGradesMinimum
		: (iEvaluationMode=Puntos)
			[MPA_DefinicionCompetencias:187]Escala_Minimo:20:=rPointsFrom
			[MPA_DefinicionCompetencias:187]Escala_Maximo:21:=rPointsTo
			[MPA_DefinicionCompetencias:187]PctParaAprobacion:22:=rPctMinimum
			viEVLG_RequeridoCompetencia:=rPointsMinimum
		: (iEvaluationMode=Porcentaje)
			[MPA_DefinicionCompetencias:187]Escala_Minimo:20:=0
			[MPA_DefinicionCompetencias:187]Escala_Maximo:21:=100
			[MPA_DefinicionCompetencias:187]PctParaAprobacion:22:=rPctMinimum
			viEVLG_RequeridoCompetencia:=rPctMinimum
	End case 
End if 