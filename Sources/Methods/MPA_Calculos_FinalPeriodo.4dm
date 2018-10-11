//%attributes = {}
  // MÉTODO: MPA_Calculos_FinalPeriodo
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 25/11/11, 12:22:45
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPA_Calculos_FinalPeriodo()
  // ----------------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_Calcular)
C_LONGINT:C283($el;$iObjetos;$l_GradesDec;$l_ID_Alumno;$l_ID_Asignatura;$l_periodo;$l_PointsDec;$l_troncatura)
C_POINTER:C301($fieldEvaluacion;$y_fieldPonderacion;$y_literal;$y_Nota;$y_Puntos;$y_Real;$y_Simbolo)
C_REAL:C285($r_numerico;$r_resultado)
C_TEXT:C284($t_literal)

ARRAY LONGINT:C221($al_ID_Enunciados;0)
ARRAY LONGINT:C221($al_IDObjetos;0)
ARRAY REAL:C219($ar_Evaluacion;0)
ARRAY REAL:C219($ar_PonderacionObjeto;0)
If (False:C215)
	C_LONGINT:C283(MPA_Calculos_FinalPeriodo ;$1)
	C_LONGINT:C283(MPA_Calculos_FinalPeriodo ;$2)
	C_LONGINT:C283(MPA_Calculos_FinalPeriodo ;$3)
End if 

C_LONGINT:C283(vlMPA_MatrizActual)





  // CODIGO PRINCIPAL
$l_ID_Asignatura:=$1
$l_ID_Alumno:=$2
$l_periodo:=$3

EV2_CargaRegistro ($l_ID_Asignatura;$l_ID_Alumno;True:C214)
  //   asigno los punteros sobre los campos de evaluación (real y literal) según el período recibido en argumento ($3)
Case of 
	: ($l_periodo=-1)
		$y_Real:=->[Alumnos_ComplementoEvaluacion:209]Aprendizajes_Final_Real:82
		$y_literal:=->[Alumnos_ComplementoEvaluacion:209]Aprendizajes_Final_Literal:86
		$y_Nota:=->[Alumnos_ComplementoEvaluacion:209]Aprendizajes_Final_Nota:83
		$y_Puntos:=->[Alumnos_ComplementoEvaluacion:209]Aprendizajes_Final_Puntos:84
		$y_Simbolo:=->[Alumnos_ComplementoEvaluacion:209]Aprendizajes_Final_Simbolo:85
		
	: ($l_periodo=1)
		$fieldEvaluacion:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11
		$y_Real:=->[Alumnos_ComplementoEvaluacion:209]P01_Aprendizajes_Real:57
		$y_literal:=->[Alumnos_ComplementoEvaluacion:209]P01_Aprendizajes_Literal:62
		$y_Nota:=->[Alumnos_ComplementoEvaluacion:209]P01_Aprendizajes_Nota:67
		$y_Puntos:=->[Alumnos_ComplementoEvaluacion:209]P01_Aprendizajes_Puntos:72
		$y_Simbolo:=->[Alumnos_ComplementoEvaluacion:209]P01_Aprendizajes_Simbolo:77
		$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionP1_EnResultado:9
		
	: ($l_periodo=2)
		$fieldEvaluacion:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23
		$y_Real:=->[Alumnos_ComplementoEvaluacion:209]P02_Aprendizajes_Real:58
		$y_literal:=->[Alumnos_ComplementoEvaluacion:209]P02_Aprendizajes_Literal:63
		$y_Nota:=->[Alumnos_ComplementoEvaluacion:209]P02_Aprendizajes_Nota:68
		$y_Puntos:=->[Alumnos_ComplementoEvaluacion:209]P02_Aprendizajes_Puntos:73
		$y_Simbolo:=->[Alumnos_ComplementoEvaluacion:209]P02_Aprendizajes_Simbolo:78
		$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionP2_EnResultado:10
		
	: ($l_periodo=3)
		$fieldEvaluacion:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35
		$y_Real:=->[Alumnos_ComplementoEvaluacion:209]P03_Aprendizajes_Real:59
		$y_literal:=->[Alumnos_ComplementoEvaluacion:209]P03_Aprendizajes_Literal:64
		$y_Nota:=->[Alumnos_ComplementoEvaluacion:209]P03_Aprendizajes_Nota:69
		$y_Puntos:=->[Alumnos_ComplementoEvaluacion:209]P03_Aprendizajes_Puntos:74
		$y_Simbolo:=->[Alumnos_ComplementoEvaluacion:209]P03_Aprendizajes_Simbolo:79
		$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionP3_EnResultado:11
		
	: ($l_periodo=4)
		$fieldEvaluacion:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47
		$y_Real:=->[Alumnos_ComplementoEvaluacion:209]P04_Aprendizajes_Real:60
		$y_literal:=->[Alumnos_ComplementoEvaluacion:209]P04_Aprendizajes_Literal:65
		$y_Nota:=->[Alumnos_ComplementoEvaluacion:209]P04_Aprendizajes_Nota:70
		$y_Puntos:=->[Alumnos_ComplementoEvaluacion:209]P04_Aprendizajes_Puntos:75
		$y_Simbolo:=->[Alumnos_ComplementoEvaluacion:209]P04_Aprendizajes_Simbolo:80
		$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionP4_EnResultado:12
		
	: ($l_periodo=5)
		$fieldEvaluacion:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64
		$y_Real:=->[Alumnos_ComplementoEvaluacion:209]P05_Aprendizajes_Real:61
		$y_literal:=->[Alumnos_ComplementoEvaluacion:209]P05_Aprendizajes_Literal:66
		$y_Nota:=->[Alumnos_ComplementoEvaluacion:209]P05_Aprendizajes_Nota:71
		$y_Puntos:=->[Alumnos_ComplementoEvaluacion:209]P05_Aprendizajes_Puntos:76
		$y_Simbolo:=->[Alumnos_ComplementoEvaluacion:209]P05_Aprendizajes_Simbolo:81
		$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionP5_EnResultado:23
End case 

QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_ID_Asignatura;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;=;$l_ID_Alumno;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
QUERY SELECTION BY FORMULA:C207([Alumnos_EvaluacionAprendizajes:203];(([Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63 ?? $l_Periodo) & (([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? $l_periodo) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 0) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10=0))))
CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"$aprendizajes")

If (Records in set:C195("$aprendizajes")>0)
	If (vlMPA_MatrizActual#[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2)
		KRL_FindAndLoadRecordByIndex (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2)
		vlMPA_MatrizActual:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
	End if 
	
	Case of 
			
			  // SI EL RESULTADO FINAL DE LA EVALUACION POR COMPETENCIAS ES OBTENIDO DESDE LAS EVALUACIONES EN LOS EJES
		: ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Eje_Aprendizaje)
			$b_Calcular:=True:C214
			
			If (Not:C34([MPA_AsignaturasMatrices:189]EjesEnFinal_PonderacionVariable:26))  // si la ponderaciones de  los ejes son las mismas en todos los períodos
				$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionG_EnResultado:8  // utilizo el campo de ponderación común a todos los períodos
			End if 
			
			  // busco las evaluaciones de ejes de aprendizaje correspondientes al alumno, asignatura y período
			USE SET:C118("$aprendizajes")
			QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Eje_Aprendizaje)
			
			  // cargo las evaluaciones en los arreglos
			SET FIELD RELATION:C919([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;Automatic:K51:4;Structure configuration:K51:2)
			SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;$al_ID_Enunciados;$fieldEvaluacion->;$ar_Evaluacion;$y_fieldPonderacion->;$ar_Ponderacion)
			SET FIELD RELATION:C919([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;Structure configuration:K51:2;Structure configuration:K51:2)
			ARRAY REAL:C219($ar_Ponderacion;Size of array:C274($al_ID_Enunciados))
			
			  // para obtener las ponderaciones de los ejes, establezco la relación entre los registros devaluación y los objetos definidos en la matriz y las cargo en arreglos
			KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Eje:3;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;"")
			QUERY SELECTION:C341([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;*)
			QUERY SELECTION:C341([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
			SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204]ID_Eje:3;$al_IDObjetos;$y_fieldPonderacion->;$ar_PonderacionObjeto)
			
		: ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Dimension_Aprendizaje)
			$b_Calcular:=True:C214
			  // SI EL RESULTADO FINAL DE LA EVALUACION POR COMPETENCIAS ES OBTENIDO DESDE LAS EVALUACIONES EN LAS DIMENSIONES
			
			  // determino el puntero sobre el campo de ponderación
			If (Not:C34([MPA_AsignaturasMatrices:189]DimEnFinal_PonderacionVariable:27))  // si la ponderaciones de las dimensiones son las mismas en todos los períodos
				$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionG_EnResultado:8  // utilizo el campo de ponderación común a todos los períodos
			End if 
			
			  // busco las evaluaciones de las dimensiones correspondientes al alumno, asignatura y período
			USE SET:C118("$aprendizajes")
			QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Dimension_Aprendizaje)
			
			  // cargo las evaluaciones en los arreglos
			SET FIELD RELATION:C919([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;Automatic:K51:4;Structure configuration:K51:2)
			SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;$al_ID_Enunciados;$fieldEvaluacion->;$ar_Evaluacion;$y_fieldPonderacion->;$ar_Ponderacion)
			SET FIELD RELATION:C919([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;Structure configuration:K51:2;Structure configuration:K51:2)
			ARRAY REAL:C219($ar_Ponderacion;Size of array:C274($al_ID_Enunciados))
			
			  //   para obtener las ponderaciones de las dimensiones, establezco la relación entre los registros devaluación y los objetos definidos en la matriz y las cargo en arreglos
			KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Dimension:4;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;"")
			QUERY SELECTION:C341([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;*)
			QUERY SELECTION:C341([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
			SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204]ID_Dimension:4;$al_IDObjetos;$y_fieldPonderacion->;$ar_PonderacionObjeto)
			
		: ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23=Logro_Aprendizaje)
			$b_Calcular:=True:C214
			  // SI EL RESULTADO FINAL DE LA EVALUACION POR COMPETENCIAS ES OBTENIDO DESDE LAS EVALUACIONES EN LAS DIMENSIONES
			
			If (Not:C34([MPA_AsignaturasMatrices:189]CompEnFinal_PonderacionVariable:28))  // si la ponderaciones de las dimensiones son las mismas en todos los períodos
				$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionG_EnResultado:8  // utilizo el campo de ponderación común a todos los períodos
			End if 
			
			  // busco las evaluaciones de las competencias correspondientes al alumno, asignatura y período
			USE SET:C118("$aprendizajes")
			QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Logro_Aprendizaje)
			
			SET FIELD RELATION:C919([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;Automatic:K51:4;Structure configuration:K51:2)
			SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;$al_ID_Enunciados;$fieldEvaluacion->;$ar_Evaluacion;$y_fieldPonderacion->;$ar_Ponderacion)
			SET FIELD RELATION:C919([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;Structure configuration:K51:2;Structure configuration:K51:2)
			ARRAY REAL:C219($ar_Ponderacion;Size of array:C274($al_ID_Enunciados))
			
			  //   para obtener las ponderaciones de las dimensiones, establezco la relación entre los registros devaluación y los objetos definidos en la matriz y las cargo en arreglos
			KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Competencia:5;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;"")
			QUERY SELECTION:C341([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2)
			SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204]ID_Competencia:5;$al_IDObjetos;$y_fieldPonderacion->;$ar_PonderacionObjeto)
			
	End case 
	
	For ($iObjetos;Size of array:C274($al_ID_Enunciados);1;-1)
		$el:=Find in array:C230($al_IDObjetos;$al_ID_Enunciados{$iObjetos})
		If ($el>0)
			$ar_Ponderacion{$iObjetos}:=$ar_PonderacionObjeto{$el}
		Else 
			AT_Delete ($iObjetos;1;->$al_ID_Enunciados;->$ar_Evaluacion;->$ar_Ponderacion)
		End if 
	End for 
	
	$r_resultado:=MPA_Calculos_PromedioEvals (->$ar_Evaluacion;->$ar_Ponderacion;vrNTA_MinimoEscalaReferencia)
	
	If ([Asignaturas:18]Numero_de_EstiloEvaluacion:39#0)
		
		EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		$l_GradesDec:=iGradesDecPP
		$l_PointsDec:=iPointsDecPP
		$l_troncatura:=vi_gTrPAvg
		
		Case of 
			: (iEvaluationMode=Notas)
				$y_Nota->:=EV2_Real_a_Nota ($r_Resultado;$l_troncatura;$l_GradesDec)
				$y_Real->:=EV2_Nota_a_Real ($y_Nota->)
				$y_Puntos->:=EV2_Real_a_Puntos ($y_Real->;$l_troncatura;$l_PointsDec)
				$y_Simbolo->:=EV2_Real_a_Simbolo ($y_Real->)
				$y_literal->:=EV2_Real_a_Literal ($y_Real->;iEvaluationMode;$l_GradesDec;$l_troncatura)
				
			: (iEvaluationMode=Puntos)
				$y_Puntos->:=EV2_Real_a_Puntos ($r_Resultado;$l_troncatura;$l_GradesDec)
				$y_Real->:=EV2_Puntos_a_Real ($y_Puntos->)
				$y_Nota->:=EV2_Real_a_Nota ($y_Real->;$l_troncatura;$l_PointsDec)
				$y_Simbolo->:=EV2_Real_a_Simbolo ($y_Real->)
				$y_literal->:=EV2_Real_a_Literal ($y_Real->;iEvaluationMode;$l_GradesDec;$l_troncatura)
				
			: (iEvaluationMode=Simbolos)
				$y_Real->:=$r_resultado
				$y_Nota->:=EV2_Real_a_Nota ($y_Real->;$l_troncatura;$l_PointsDec)
				$y_Puntos->:=EV2_Real_a_Puntos ($y_Real->;$l_troncatura;$l_PointsDec)
				$y_Simbolo->:=EV2_Real_a_Simbolo ($y_Real->)
				$y_literal->:=EV2_Real_a_Literal ($y_Real->;iEvaluationMode;$l_GradesDec;$l_troncatura)
				
			: (iEvaluationMode=Porcentaje)
				$y_Simbolo->:=EV2_Real_a_Simbolo ($r_Resultado)
				$y_Real->:=EV2_Simbolo_a_Real ($y_Simbolo->)
				$y_Nota->:=EV2_Real_a_Nota ($y_Real->;$l_troncatura;$l_PointsDec)
				$y_Puntos->:=EV2_Real_a_Puntos ($y_Real->;$l_troncatura;$l_PointsDec)
				$y_literal->:=EV2_Real_a_Literal ($y_Real->;iEvaluationMode;$l_GradesDec;$l_troncatura)
				
		End case 
		
		If (KRL_FieldChanges ($y_Real;$y_Nota;$y_Puntos;$y_literal;$y_Simbolo))
			SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
		End if 
		
	End if 
	
Else 
	$y_Nota->:=-10
	$y_Real->:=-10
	$y_Puntos->:=-10
	$y_Simbolo->:=""
	$y_literal->:=""
	SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
End if 

CLEAR SET:C117("$aprendizajes")
