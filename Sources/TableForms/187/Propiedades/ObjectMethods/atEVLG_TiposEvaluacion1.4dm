If (Self:C308->>0)
	[MPA_DefinicionCompetencias:187]TipoEvaluacion:12:=Self:C308->
	
	  // si es un nuevo registro asigno a variable el tipo de evaluación para mantenerlo mientras no se cambie el area, el eje o la dimensión
	If (Is new record:C668([MPA_DefinicionCompetencias:187]))
		vlMPA_TipoEvaluacionComp:=[MPA_DefinicionCompetencias:187]TipoEvaluacion:12
		
		  // si el tipo de evaluación es "Estilo de Evaluación" y el estilo no está definido
		If ((vlMPA_TipoEvaluacionComp=3) & (vlMPA_EstiloEvaluacionComp=0))
			vlMPA_EstiloEvaluacionComp:=-5
			[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7:=vlMPA_EstiloEvaluacionComp
		End if 
	End if 
	
	
	
	
	Case of 
		: (([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=1) | ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=0))
			[MPA_DefinicionCompetencias:187]TipoEvaluacion:12:=1
			FORM GOTO PAGE:C247(1)
			
			
		: ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=2)
			If (([MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17="") | ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17=";"))
				[MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17:=__ ("L;NL")
			End if 
			If (([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18="") | ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18=";"))
				[MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18:=__ ("Logrado;No Logrado")
			End if 
			vsEVLG_Simbolo_True:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17;1;";")
			vsEVLG_Simbolo_False:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17;2;";")
			vsEVLG_DescSimbolo_True:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18;1;";")
			vsEVLG_DescSimbolo_False:=ST_GetWord ([MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18;2;";")
			FORM GOTO PAGE:C247(2)
			
			
		: ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=3)
			If ([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7=0)
				If (vlMPA_EstiloEvaluacionComp=0)
					[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7:=-5
				Else 
					[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7:=vlMPA_EstiloEvaluacionComp
				End if 
			End if 
			$el:=Find in array:C230(aEvStyleId;[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7)
			If ($el>0)
				aEvStyleName:=$el
			End if 
			EVS_ReadStyleData ([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7)
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
			FORM GOTO PAGE:C247(3)
			_O_ENABLE BUTTON:C192(aEvStyleName)
			
			
			
	End case 
	MPAcfg_MinimoAdquisicion 
	
End if 