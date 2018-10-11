If (Self:C308->>0)
	[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11:=aEvStyleId{Self:C308->}
	
	  // si es un nuevo registro asigno a variable el estilo de evaluación para mantenerlo mientras no se cambie el area, el eje o la dimensión
	If (Is new record:C668([MPA_DefinicionDimensiones:188]))
		vlMPA_EstiloEvaluacionDimension:=[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11
	End if 
	
	EVS_ReadStyleData ([MPA_DefinicionDimensiones:188]EstiloEvaluacion:11)
	Case of 
		: (iEvaluationMode=Notas)
			[MPA_DefinicionDimensiones:188]Escala_Minimo:12:=rGradesFrom
			[MPA_DefinicionDimensiones:188]Escala_Maximo:13:=rGradesTo
			[MPA_DefinicionDimensiones:188]PctParaAprobacion:14:=rPctMinimum
			viEVLG_RequeridoDimension:=rGradesMinimum
		: (iEvaluationMode=Puntos)
			[MPA_DefinicionDimensiones:188]Escala_Minimo:12:=rPointsFrom
			[MPA_DefinicionDimensiones:188]Escala_Maximo:13:=rPointsTo
			[MPA_DefinicionDimensiones:188]PctParaAprobacion:14:=rPctMinimum
			viEVLG_RequeridoDimension:=rPointsMinimum
		: (iEvaluationMode=Porcentaje)
			[MPA_DefinicionDimensiones:188]Escala_Minimo:12:=0
			[MPA_DefinicionDimensiones:188]Escala_Maximo:13:=100
			[MPA_DefinicionDimensiones:188]PctParaAprobacion:14:=rPctMinimum
			viEVLG_RequeridoDimension:=rPctMinimum
	End case 
End if 