//%attributes = {}
  // MÉTODO: MPA_Calculos_Eje
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 25/11/11, 19:34:45
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPA_Calculos_Eje()
  // ----------------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_REAL:C285($5)
C_REAL:C285($6)

C_BOOLEAN:C305($b_ejesCalculados;$b_promedioModificado)
C_LONGINT:C283($el;$iCompetencias;$iDimensiones;$l_GradesDec;$l_ID_Alumno;$l_ID_Asignatura;$l_ID_Eje;$l_IdEstiloEvaluacion;$l_periodo;$l_PointsDec)
C_LONGINT:C283($l_recNum;$l_tipoEvaluacion;$l_troncatura)
C_POINTER:C301($y_fieldPonderacion;$y_punteroDescriptor;$y_punteroLiteral;$y_punteroNumerico;$y_punteroReal)
C_REAL:C285($numerico;$r_escalaMaximo;$r_escalaMinimo;$r_resultado)

ARRAY LONGINT:C221($al_IdCompetencias;0)
ARRAY LONGINT:C221($al_IdDimensiones;0)
ARRAY LONGINT:C221($al_IDObjetos;0)
ARRAY REAL:C219($ar_Evaluacion;0)
ARRAY REAL:C219($ar_PonderacionObjeto;0)
If (False:C215)
	C_BOOLEAN:C305(MPA_Calculos_Eje ;$0)
	C_LONGINT:C283(MPA_Calculos_Eje ;$1)
	C_LONGINT:C283(MPA_Calculos_Eje ;$2)
	C_LONGINT:C283(MPA_Calculos_Eje ;$3)
	C_LONGINT:C283(MPA_Calculos_Eje ;$4)
	C_REAL:C285(MPA_Calculos_Eje ;$5)
	C_REAL:C285(MPA_Calculos_Eje ;$6)
End if 

C_LONGINT:C283(vlEVS_CurrentEvStyleID)






  // CODIGO PRINCIPAL
$l_recNum:=$1
$l_periodo:=$2
$l_tipoEvaluacion:=$3
$l_IdEstiloEvaluacion:=$4
$r_escalaMinimo:=$5
$r_escalaMaximo:=$6

  //Obtengo los Ids de asignatura, alumno y eje del alumno actual que se utilizarán para buscar
  //  todas las evaluaciones de aprendizajes en el eje para el alumno en la asignatura
KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];$l_recNum)
$l_ID_Asignatura:=[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1
$l_ID_Alumno:=[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3
$l_ID_Eje:=[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5

Case of 
	: ($l_Periodo=1)
		$y_punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13
		$y_punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11
		$y_punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12
		$y_punteroDescriptor:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
	: ($l_Periodo=2)
		$y_punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25
		$y_punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23
		$y_punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24
		$y_punteroDescriptor:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
	: ($l_Periodo=3)
		$y_punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37
		$y_punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35
		$y_punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36
		$y_punteroDescriptor:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
	: ($l_Periodo=4)
		$y_punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49
		$y_punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47
		$y_punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48
		$y_punteroDescriptor:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
	: ($l_Periodo=5)
		$y_punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66
		$y_punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64
		$y_punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65
		$y_punteroDescriptor:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
	: ($l_Periodo=-1)
		$y_punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61
		$y_punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Final_Real:59
		$y_punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60
		$y_punteroDescriptor:=->[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62
		$l_Periodo:=0
End case 

$b_ejesCalculados:=False:C215

Case of 
	: ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Logro_Aprendizaje)
		$b_ejesCalculados:=True:C214
		
		  //   si el período es evaluación final o las competencias de las dimensiones son las mismas en todos los períodos
		If ((Not:C34([MPA_AsignaturasMatrices:189]CompEnEjes_PonderacionVariable:30)) | ($l_periodo=0) | ($l_periodo=-1))
			$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionG_EnEje:13  // utilizo el campo de ponderación común a todos los períodos
		Else 
			  // si las ponderaciones de las competencias no son las mismas en todos los períodos utilizo las ponderaciones específicas a cada período
			Case of 
				: ($l_periodo=1)
					$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionP1_EnEje:14
				: ($l_periodo=2)
					$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionP2_EnEje:15
				: ($l_periodo=3)
					$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionP3_EnEje:16
				: ($l_periodo=4)
					$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionP4_EnEje:17
				: ($l_periodo=5)
					$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionP5_EnEje:24
			End case 
		End if 
		
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_ID_Asignatura;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;=;$l_ID_Alumno;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;=;$l_ID_Eje;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Logro_Aprendizaje;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
		QUERY SELECTION BY FORMULA:C207([Alumnos_EvaluacionAprendizajes:203];(([Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63 ?? $l_Periodo) & (([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? $l_periodo) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 0) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10=0))))
		
		  //para obtener las ponderaciones de las competencias, establezco la relación entre los registros de evaluación y los registros de objetos de la matriz mediante el uso de arreglos
		KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Competencia:5;->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;"")
		QUERY SELECTION:C341([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;*)
		QUERY SELECTION:C341([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
		SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204]ID_Competencia:5;$al_IDObjetos;$y_fieldPonderacion->;$ar_PonderacionObjeto)
		
		SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7;$al_IdCompetencias;$y_punteroReal->;$ar_Evaluacion;$y_fieldPonderacion->;$ar_Ponderacion)
		ARRAY REAL:C219($ar_Ponderacion;Size of array:C274($al_IdCompetencias))
		
		For ($iCompetencias;Size of array:C274($al_IdCompetencias);1;-1)
			$el:=Find in array:C230($al_IDObjetos;$al_IdCompetencias{$iCompetencias})
			If ($el>0)
				$ar_Ponderacion{$iCompetencias}:=$ar_PonderacionObjeto{$el}
			Else 
				AT_Delete ($iCompetencias;1;->$al_IdCompetencias;->$ar_Evaluacion;->$ar_Ponderacion)
			End if 
		End for 
		
	: ([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Dimension_Aprendizaje)
		$b_ejesCalculados:=True:C214
		
		  //   si el período es evaluación final o las ponderaciónes de las dimensiones son las mismas en todos los períodos
		If ((Not:C34([MPA_AsignaturasMatrices:189]DimEnEjes_PonderacionVariable:29)) | ($l_periodo=0) | ($l_periodo=-1))
			$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionG_EnEje:13  // utilizo el campo de ponderación común a todos los períodos
		Else 
			  // si las ponderaciones de las dimensiones no son las mismas en todos los períodos utilizo las ponderaciones específicas a cada período
			Case of 
				: ($l_periodo=1)
					$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionP1_EnEje:14
				: ($l_periodo=2)
					$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionP2_EnEje:15
				: ($l_periodo=3)
					$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionP3_EnEje:16
				: ($l_periodo=4)
					$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionP4_EnEje:17
				: ($l_periodo=5)
					$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionP5_EnEje:24
			End case 
		End if 
		
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_ID_Asignatura;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;=;$l_ID_Alumno;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;=;$l_ID_Eje;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Dimension_Aprendizaje;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
		QUERY SELECTION BY FORMULA:C207([Alumnos_EvaluacionAprendizajes:203];(([Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63 ?? $l_Periodo) & (([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? $l_periodo) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10 ?? 0) | ([Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10=0))))
		SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;$al_IdDimensiones;$y_punteroReal->;$ar_Evaluacion)
		
		  //para obtener las ponderaciones de las competencias, establezco la relación entre los registros de evaluación y los registros de objetos de la matriz mediante el uso de arreglos
		KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Dimension:4;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;"")
		QUERY SELECTION:C341([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;*)
		QUERY SELECTION:C341([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
		SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204]ID_Dimension:4;$al_IDObjetos;$y_fieldPonderacion->;$ar_PonderacionObjeto)
		
		SELECTION TO ARRAY:C260([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;$al_IdDimensiones;$y_punteroReal->;$ar_Evaluacion;$y_fieldPonderacion->;$ar_Ponderacion)
		ARRAY REAL:C219($ar_Ponderacion;Size of array:C274($al_IdDimensiones))
		
		For ($iDimensiones;Size of array:C274($al_IdDimensiones);1;-1)
			$el:=Find in array:C230($al_IDObjetos;$al_IdDimensiones{$iDimensiones})
			If ($el>0)
				$ar_Ponderacion{$iDimensiones}:=$ar_PonderacionObjeto{$el}
			Else 
				AT_Delete ($iDimensiones;1;->$al_IdDimensiones;->$ar_Evaluacion;->$ar_Ponderacion)
			End if 
		End for 
End case 

If ($b_ejesCalculados)
	If (($l_tipoEvaluacion=1) & (vlEVS_CurrentEvStyleID#$l_IdEstiloEvaluacion))
		EVS_ReadStyleData ($l_IdEstiloEvaluacion)
		vlEVS_CurrentEvStyleID:=$l_IdEstiloEvaluacion
	End if 
	$r_resultado:=MPA_Calculos_PromedioEvals (->$ar_Evaluacion;->$ar_Ponderacion;vrNTA_MinimoEscalaReferencia)
	
	KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];$l_recNum;True:C214)
	$l_tipoEvaluacion:=KRL_GetNumericFieldData (->[MPA_DefinicionEjes:185]ID:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;->[MPA_DefinicionEjes:185]TipoEvaluación:12)
	
	Case of 
		: ($l_tipoEvaluacion=3)  //escala independiente
			$y_punteroReal->:=$r_resultado
			$y_punteroNumerico->:=Round:C94($r_escalaMinimo+(($r_escalaMaximo-$r_escalaMinimo)*$r_resultado/100);0)
			$y_punteroLiteral->:=String:C10($y_punteroNumerico->)
			$y_punteroDescriptor->:=ST_Num2Text ($y_punteroNumerico->;False:C215)+" sobre "+ST_Num2Text ($r_escalaMaximo;False:C215)
			
		: ($l_tipoEvaluacion=2)  //binario
			  //no utilizado actualmente
			
		: ($l_tipoEvaluacion=1)  //estilo de evaluación
			If ($l_periodo<=0)
				$l_GradesDec:=iGradesDecPF
				$l_PointsDec:=iPointsDecPF
				$l_troncatura:=vi_gTrFAvg
			Else 
				$l_GradesDec:=iGradesDecPP
				$l_PointsDec:=iPointsDecPP
				$l_troncatura:=vi_gTrPAvg
			End if 
			
			$y_punteroReal->:=$r_resultado
			Case of 
				: (iEvaluationMode=Notas)
					$y_punteroNumerico->:=EV2_Real_a_Nota ($r_resultado;$l_troncatura;$l_GradesDec)  // convierto el real al valor numérico correspondiente al modo del estilo
					$y_punteroReal->:=EV2_Nota_a_Real ($y_punteroNumerico->)  // reconvierto el valor numérico al valor real
					$y_punteroLiteral->:=EV2_Real_a_Literal ($r_resultado;iEvaluationMode;$l_GradesDec;$l_troncatura)  // obtengo el valor literal
					Case of 
						: ($y_punteroNumerico->=-2)
							$y_punteroDescriptor->:=__ ("Pendiente")
						: ($y_punteroReal->>=vrNTA_MinimoEscalaReferencia)
							$y_punteroDescriptor->:=ST_Num2Text ($y_punteroNumerico->;True:C214)+" sobre "+ST_Num2Text (rGradesTo;False:C215)
						Else 
							$y_punteroDescriptor->:=""
					End case 
					
				: (iEvaluationMode=Puntos)
					$y_punteroNumerico->:=EV2_Real_a_Puntos ($y_punteroReal->;$l_troncatura;$l_PointsDec)  // convierto el real al valor numérico correspondiente al modo del estilo
					$y_punteroReal->:=EV2_Puntos_a_Real ($y_punteroNumerico->)  // reconvierto el valor numérico al valor real
					$y_punteroLiteral->:=EV2_Real_a_Literal ($y_punteroReal->;iEvaluationMode;$l_PointsDec;$l_troncatura)
					Case of 
						: ($y_punteroNumerico->=-2)
							$y_punteroDescriptor->:=__ ("Pendiente")
						: ($y_punteroReal->>=vrNTA_MinimoEscalaReferencia)
							$y_punteroDescriptor->:=ST_Num2Text ($y_punteroNumerico->;True:C214)+" sobre "+ST_Num2Text (rPointsTo;False:C215)
						Else 
							$y_punteroDescriptor->:=""
					End case 
					
				: (iEvaluationMode=Porcentaje)
					$y_punteroNumerico->:=Round:C94($y_punteroReal->;1)
					If ($l_periodo<=0)
						$y_punteroLiteral->:=EV2_Real_a_Literal ($y_punteroReal->;Porcentaje;1;$l_troncatura)
					Else 
						$y_punteroLiteral->:=EV2_Real_a_Literal ($y_punteroReal->;Porcentaje;1;$l_troncatura)
					End if 
					Case of 
						: ($y_punteroNumerico->=-2)
							$y_punteroDescriptor->:=__ ("Pendiente")
						: ($y_punteroReal->>=vrNTA_MinimoEscalaReferencia)
							$y_punteroDescriptor->:=ST_Num2Text ($y_punteroNumerico->;True:C214)+" sobre "+ST_Num2Text (100;False:C215)
						Else 
							$y_punteroDescriptor->:=""
					End case 
					
				: (iEvaluationMode=Simbolos)
					If ($y_punteroReal->=-2)
						$y_punteroDescriptor->:=__ ("Pendiente")
					Else 
						$y_punteroLiteral->:=EV2_Real_a_Simbolo ($y_punteroReal->)  // convierto el real al símbolo correspondiente al modo del estilo
						$y_punteroReal->:=EV2_Simbolo_a_Real ($y_punteroLiteral->)  // reconvierto el símbolo al valor real
						$el:=Find in array:C230(aSymbol;$y_punteroLiteral->)
						If ($el>0)
							$y_punteroDescriptor->:=aSymbDesc{$el}
						Else 
							$y_punteroDescriptor->:=""
						End if 
						$y_punteroNumerico->:=EV2_Simbolo_a_Real ($y_punteroLiteral->)
					End if 
			End case 
	End case 
	
	$b_promedioModificado:=MPA_PromediosModificados ($l_Periodo)
	If ($b_promedioModificado)
		SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
	End if 
	$0:=$b_promedioModificado
	
End if 

