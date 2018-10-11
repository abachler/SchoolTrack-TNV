If (Self:C308->>0)
	[MPA_DefinicionEjes:185]TipoEvaluación:12:=Self:C308->
	  // si es un nuevo registro asigno a variable el tipo de evaluación para mantenerlo mientras no se cambie el area, el eje o la dimensión
	If (Is new record:C668([MPA_DefinicionEjes:185]))
		vlMPA_TipoEvaluacionEje:=[MPA_DefinicionEjes:185]TipoEvaluación:12
		
		  // si el tipo de evaluación es "Estilo de Evaluación" y el estilo no está definido
		If ((vlMPA_TipoEvaluacionEje=1) & (vlMPA_EstiloEvaluacionDimension=0))
			vlMPA_EstiloEvaluacionEje:=-5
			[MPA_DefinicionEjes:185]EstiloEvaluación:13:=vlMPA_EstiloEvaluacionEje
		End if 
	End if 
	
	
	Case of 
		: (([MPA_DefinicionEjes:185]TipoEvaluación:12=1) | ([MPA_DefinicionEjes:185]TipoEvaluación:12=0))  //segun estilo de evaluación
			[MPA_DefinicionEjes:185]TipoEvaluación:12:=1
			If ([MPA_DefinicionEjes:185]EstiloEvaluación:13=0)
				[MPA_DefinicionEjes:185]EstiloEvaluación:13:=-5
			End if 
			$el:=Find in array:C230(aEvStyleId;[MPA_DefinicionEjes:185]EstiloEvaluación:13)
			If ($el>0)
				aEvStyleName:=$el
			End if 
			[MPA_DefinicionEjes:185]EstiloEvaluación:13:=aEvStyleId{Self:C308->}
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
			FORM GOTO PAGE:C247(1)
			
			
		: ([MPA_DefinicionEjes:185]TipoEvaluación:12=2)  //binario
			vsEVLG_Simbolo_True:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Simbolos:14;1;";")
			vsEVLG_Simbolo_False:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Simbolos:14;2;";")
			vsEVLG_DescSimbolo_True:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Descripcion:15;1;";")
			vsEVLG_DescSimbolo_False:=ST_GetWord ([MPA_DefinicionEjes:185]SimbolosBinarios_Descripcion:15;2;";")
			FORM GOTO PAGE:C247(2)
			
			
		: ([MPA_DefinicionEjes:185]TipoEvaluación:12=3)  //escala independiente
			[MPA_DefinicionEjes:185]EstiloEvaluación:13:=0
			FORM GOTO PAGE:C247(3)
			
	End case 
End if 