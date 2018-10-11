If (Self:C308->>0)
	[MPA_DefinicionEjes:185]EstiloEvaluación:13:=aEvStyleId{Self:C308->}
	
	  // si es un nuevo registro asigno a variable el estilo de evaluación para mantenerlo mientras no se cambie el area, el eje o la dimensión
	If (Is new record:C668([MPA_DefinicionEjes:185]))
		vlMPA_EstiloEvaluacionEje:=[MPA_DefinicionEjes:185]EstiloEvaluación:13
	End if 
	
	EVS_ReadStyleData ([MPA_DefinicionEjes:185]EstiloEvaluación:13)
	Case of 
		: (iEvaluationMode=Notas)
			[MPA_DefinicionEjes:185]Escala_Minimo:17:=rGradesFrom
			[MPA_DefinicionEjes:185]Escala_Maximo:18:=rGradesTo
			[MPA_DefinicionEjes:185]PctParaAprobacion:16:=rPctMinimum
			viEVLG_RequeridoEje:=rGradesMinimum
		: (iEvaluationMode=Puntos)
			[MPA_DefinicionEjes:185]Escala_Minimo:17:=rPointsFrom
			[MPA_DefinicionEjes:185]Escala_Maximo:18:=rPointsTo
			[MPA_DefinicionEjes:185]PctParaAprobacion:16:=rPctMinimum
			viEVLG_RequeridoEje:=rPointsMinimum
		: (iEvaluationMode=Porcentaje)
			[MPA_DefinicionEjes:185]Escala_Minimo:17:=0
			[MPA_DefinicionEjes:185]Escala_Maximo:18:=100
			[MPA_DefinicionEjes:185]PctParaAprobacion:16:=rPctMinimum
			viEVLG_RequeridoEje:=rPctMinimum
	End case 
End if 