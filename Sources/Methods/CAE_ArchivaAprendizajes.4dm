//%attributes = {}
  //CAE_ArchivaAprendizajes

C_LONGINT:C283($1;$2)  //MONO 184433
If (Count parameters:C259=2)  //MONO 184433
	vl_UltimoAño:=$1  //MONO 184433
	$l_nivel:=$2  //MONO 184433
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Año:77=vl_UltimoAño;*)  //MONO 184433
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91=$l_nivel)  //MONO 184433
Else 
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Año:77=vl_UltimoAño)  //MONO 184433
End if 

ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos_EvaluacionAprendizajes:203];$aRecNums;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Archivando registros de evaluación de aprendizajes..."))
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
	GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$aRecNums{$i})
	Case of 
		: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje)
			$idCompetencia:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
			KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionCompetencias:187]ID:1;->$idCompetencia)
			[Alumnos_EvaluacionAprendizajes:203]Enunciado:9:=[MPA_DefinicionCompetencias:187]Competencia:6
			[Alumnos_EvaluacionAprendizajes:203]OrdenCompetencia:87:=[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25
			$idDimension:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
			KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionDimensiones:188]ID:1;->$idDimension)
			[Alumnos_EvaluacionAprendizajes:203]OrdenDimension:86:=[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20
			$idEje:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
			KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionEjes:185]ID:1;->$idEje)
			[Alumnos_EvaluacionAprendizajes:203]OrdenEje:85:=[MPA_DefinicionEjes:185]OrdenamientoNumerico:9
			Case of 
				: ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=3)  //estilo de evaluación en el caso de ejes y dimensiones
					$estilo:=[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7
					EVS_ReadStyleData ($estilo)
					Case of 
						: (iEvaluationMode=Notas)
							[Alumnos_EvaluacionAprendizajes:203]MuestraEscala:88:=String:C10(rGradesFrom)+" - "+String:C10(rGradesTo)
						: (iEvaluationMode=Puntos)
							[Alumnos_EvaluacionAprendizajes:203]MuestraEscala:88:=String:C10(rPointsFrom)+" - "+String:C10(rPointsTo)
						: (iEvaluationMode=Porcentaje)
							[Alumnos_EvaluacionAprendizajes:203]MuestraEscala:88:=String:C10(0)+" - "+String:C10(100)
						: (iEvaluationMode=Simbolos)
							[Alumnos_EvaluacionAprendizajes:203]MuestraEscala:88:=AT_array2text (->aSymbDesc;", ")
					End case 
				: ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=2)  //binario
					[Alumnos_EvaluacionAprendizajes:203]MuestraEscala:88:=[MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18
					
				: ([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=3)  //indicadores de aprendizaje
					[Alumnos_EvaluacionAprendizajes:203]MuestraEscala:88:=String:C10([MPA_DefinicionCompetencias:187]Escala_Minimo:20)+" - "+String:C10([MPA_DefinicionCompetencias:187]Escala_Maximo:21)
					BLOB_Blob2Vars (->[MPA_DefinicionCompetencias:187]xIndicadores:14;0;->atEVLG_Indicadores_Descripcion;->aiEVLG_Indicadores_Valor;->atEVLG_Indicadores_Concepto)
					[Alumnos_EvaluacionAprendizajes:203]MuestraEscala:88:=AT_array2text (->atEVLG_Indicadores_Descripcion;", ")
			End case 
			
			
			
		: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje)
			$idDimension:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
			KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionDimensiones:188]ID:1;->$idDimension)
			[Alumnos_EvaluacionAprendizajes:203]OrdenDimension:86:=[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20
			[Alumnos_EvaluacionAprendizajes:203]Enunciado:9:=[MPA_DefinicionDimensiones:188]Dimensión:4
			$idEje:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
			KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionEjes:185]ID:1;->$idEje)
			[Alumnos_EvaluacionAprendizajes:203]OrdenEje:85:=[MPA_DefinicionEjes:185]OrdenamientoNumerico:9
			[Alumnos_EvaluacionAprendizajes:203]OrdenCompetencia:87:=0
			Case of 
				: ([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=1)  //estilo de evaluación en el caso de ejes y dimensiones
					$estilo:=[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11
					EVS_ReadStyleData ($estilo)
					Case of 
						: (iEvaluationMode=Notas)
							[Alumnos_EvaluacionAprendizajes:203]MuestraEscala:88:=String:C10(rGradesFrom)+" - "+String:C10(rGradesTo)
						: (iEvaluationMode=Puntos)
							[Alumnos_EvaluacionAprendizajes:203]MuestraEscala:88:=String:C10(rPointsFrom)+" - "+String:C10(rPointsTo)
						: (iEvaluationMode=Porcentaje)
							[Alumnos_EvaluacionAprendizajes:203]MuestraEscala:88:=String:C10(0)+" - "+String:C10(100)
						: (iEvaluationMode=Simbolos)
							[Alumnos_EvaluacionAprendizajes:203]MuestraEscala:88:=AT_array2text (->aSymbDesc;", ")
					End case 
					
				: ([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=2)  //binario
					[Alumnos_EvaluacionAprendizajes:203]MuestraEscala:88:=[MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16
					
				: ([MPA_DefinicionDimensiones:188]TipoEvaluacion:15=3)  //indicadores de aprendizaje
					[Alumnos_EvaluacionAprendizajes:203]MuestraEscala:88:=String:C10([MPA_DefinicionDimensiones:188]Escala_Minimo:12)+" - "+String:C10([MPA_DefinicionDimensiones:188]Escala_Maximo:13)
			End case 
			
			
		: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje)
			$idEje:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
			KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionEjes:185]ID:1;->$idEje)
			[Alumnos_EvaluacionAprendizajes:203]Enunciado:9:=[MPA_DefinicionEjes:185]Nombre:3
			[Alumnos_EvaluacionAprendizajes:203]OrdenEje:85:=[MPA_DefinicionEjes:185]OrdenamientoNumerico:9
			[Alumnos_EvaluacionAprendizajes:203]OrdenDimension:86:=0
			[Alumnos_EvaluacionAprendizajes:203]OrdenCompetencia:87:=0
			
			Case of 
				: ([MPA_DefinicionEjes:185]TipoEvaluación:12=1)  //estilo de evaluación en el caso de ejes y dimensiones
					$estilo:=[MPA_DefinicionEjes:185]EstiloEvaluación:13
					EVS_ReadStyleData ($estilo)
					Case of 
						: (iEvaluationMode=Notas)
							[Alumnos_EvaluacionAprendizajes:203]MuestraEscala:88:=String:C10(rGradesFrom)+" - "+String:C10(rGradesTo)
						: (iEvaluationMode=Puntos)
							[Alumnos_EvaluacionAprendizajes:203]MuestraEscala:88:=String:C10(rPointsFrom)+" - "+String:C10(rPointsTo)
						: (iEvaluationMode=Porcentaje)
							[Alumnos_EvaluacionAprendizajes:203]MuestraEscala:88:=String:C10(0)+" - "+String:C10(100)
						: (iEvaluationMode=Simbolos)
							[Alumnos_EvaluacionAprendizajes:203]MuestraEscala:88:=AT_array2text (->aSymbDesc;", ")
					End case 
					
				: ([MPA_DefinicionEjes:185]TipoEvaluación:12=2)  //binario para ejes y dimensiones
					[Alumnos_EvaluacionAprendizajes:203]MuestraEscala:88:=[MPA_DefinicionEjes:185]SimbolosBinarios_Descripcion:15
					
					
				: ([MPA_DefinicionEjes:185]TipoEvaluación:12=3)  //indicadores de aprendizaje
					[Alumnos_EvaluacionAprendizajes:203]MuestraEscala:88:=String:C10([MPA_DefinicionEjes:185]Escala_Minimo:17)+" - "+String:C10([MPA_DefinicionEjes:185]Escala_Maximo:18)
					
			End case 
	End case 
	
	
	
	
	SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)