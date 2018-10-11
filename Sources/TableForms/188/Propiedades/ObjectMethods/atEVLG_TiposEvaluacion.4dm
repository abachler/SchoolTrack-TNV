If (Self:C308->>0)
	[MPA_DefinicionDimensiones:188]TipoEvaluacion:15:=Self:C308->
	  // si es un nuevo registro asigno a variable el tipo de evaluación para mantenerlo mientras no se cambie el area, el eje o la dimensión
	If (Is new record:C668([MPA_DefinicionCompetencias:187]))
		vlMPA_TipoEvaluacionDimension:=[MPA_DefinicionDimensiones:188]TipoEvaluacion:15
		
		  // si el tipo de evaluación es "Estilo de Evaluación" y el estilo no está definido
		If ((vlMPA_TipoEvaluacionDimension=1) & (vlMPA_EstiloEvaluacionDimension=0))
			vlMPA_EstiloEvaluacionDimension:=-5
			[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11:=vlMPA_EstiloEvaluacionDimension
		End if 
	End if 
	
	Case of 
		: (([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=1) | ([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=0))  //segun estilo de evaluación
			[MPA_DefinicionDimensiones:188]TipoEvaluacion:15:=1
			If ([MPA_DefinicionDimensiones:188]EstiloEvaluacion:11=0)
				[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11:=-5
			End if 
			$el:=Find in array:C230(aEvStyleId;[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11)
			If ($el>0)
				aEvStyleName:=$el
			End if 
			[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11:=aEvStyleId{$el}
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
			FORM GOTO PAGE:C247(1)
			
			
			
		: ([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=2)  //binario
			vsEVLG_Simbolo_True:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Simbolos:17;1;";")
			vsEVLG_Simbolo_False:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Simbolos:17;2;";")
			vsEVLG_DescSimbolo_True:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16;1;";")
			vsEVLG_DescSimbolo_False:=ST_GetWord ([MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16;2;";")
			FORM GOTO PAGE:C247(2)
			
			
			
		: ([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=3)  //escala independiente
			FORM GOTO PAGE:C247(3)
			
			
	End case 
End if 