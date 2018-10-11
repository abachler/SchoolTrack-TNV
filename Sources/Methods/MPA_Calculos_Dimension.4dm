//%attributes = {}
  // MÉTODO: MPA_Calculos_Dimension
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 25/11/11, 18:26:28
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPA_Calculos_Dimension()
  // ----------------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_REAL:C285($5)
C_REAL:C285($6)

C_BOOLEAN:C305($b_promedioModificado)
C_LONGINT:C283($l_elemento;$iCompetencias;$l_GradesDec;$l_id_Alumno;$l_id_Asignatura;$l_id_Dimension;$l_IdEstiloEvaluacion;$l_periodo;$l_PointsDec;$l_recNum)
C_LONGINT:C283($l_tipoEvaluacion;$l_troncatura)
C_POINTER:C301($y_fieldPonderacion;$y_punteroDescriptor;$y_punteroLiteral;$y_punteroNumerico;$y_punteroReal)
C_REAL:C285($r_escalaMaximo;$r_escalaMinimo;$r_resultado)

ARRAY LONGINT:C221($al_IdCompetencias;0)
ARRAY LONGINT:C221($al_IDObjetos;0)
ARRAY REAL:C219($ar_Evaluacion;0)
ARRAY REAL:C219($ar_PonderacionObjeto;0)
If (False:C215)
	C_BOOLEAN:C305(MPA_Calculos_Dimension ;$0)
	C_LONGINT:C283(MPA_Calculos_Dimension ;$1)
	C_LONGINT:C283(MPA_Calculos_Dimension ;$2)
	C_LONGINT:C283(MPA_Calculos_Dimension ;$3)
	C_LONGINT:C283(MPA_Calculos_Dimension ;$4)
	C_REAL:C285(MPA_Calculos_Dimension ;$5)
	C_REAL:C285(MPA_Calculos_Dimension ;$6)
End if 

C_LONGINT:C283(vlEVS_CurrentEvStyleID)






  // CODIGO PRINCIPAL
$l_recNum:=$1
$l_periodo:=$2
$l_tipoEvaluacion:=$3
$l_IdEstiloEvaluacion:=$4
$r_escalaMinimo:=$5
$r_escalaMaximo:=$6

KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];$l_recNum)
$l_id_Asignatura:=[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1
$l_id_Alumno:=[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3
$l_id_Dimension:=[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6

Case of 
	: ($l_Periodo=1)
		$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionP1_EnDimension:19
		$y_punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13
		$y_punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11
		$y_punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12
		$y_punteroDescriptor:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
	: ($l_Periodo=2)
		$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionP2_EnDimension:20
		$y_punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25
		$y_punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23
		$y_punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24
		$y_punteroDescriptor:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
	: ($l_Periodo=3)
		$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionP3_EnDimension:21
		$y_punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37
		$y_punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35
		$y_punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36
		$y_punteroDescriptor:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
	: ($l_Periodo=4)
		$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionP4_EnDimension:22
		$y_punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49
		$y_punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47
		$y_punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48
		$y_punteroDescriptor:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
	: ($l_Periodo=5)
		$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionP5_EnDimension:25
		$y_punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66
		$y_punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64
		$y_punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65
		$y_punteroDescriptor->:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
	: ($l_Periodo=-1)
		$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionG_EnResultado:8
		$y_punteroLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61
		$y_punteroReal:=->[Alumnos_EvaluacionAprendizajes:203]Final_Real:59
		$y_punteroNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60
		$y_punteroDescriptor:=->[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62
		$l_Periodo:=0
End case 

  //   si el período es evaluación final o las ponderaciónes de las competenecias son las mismas en todos los períodos
If ((Not:C34([MPA_AsignaturasMatrices:189]CompEnDim_PonderacionVariable:31)) | ($l_periodo=0) | ($l_periodo=-1))
	$y_fieldPonderacion:=->[MPA_ObjetosMatriz:204]PonderacionG_EnDimension:18  // utilizo el campo de ponderación común a todos los períodos
End if 

If (($l_id_Asignatura=1182) & ($l_id_Alumno=84) & ($l_id_Dimension=125))
	
End if 

QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_id_Asignatura;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;=;$l_id_Alumno;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;=;$l_id_Dimension;*)
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
	$l_elemento:=Find in array:C230($al_IDObjetos;$al_IdCompetencias{$iCompetencias})
	If ($l_elemento>0)
		$ar_Ponderacion{$iCompetencias}:=$ar_PonderacionObjeto{$l_elemento}
	Else 
		AT_Delete ($iCompetencias;1;->$al_IdCompetencias;->$ar_Evaluacion;->$ar_Ponderacion)
	End if 
End for 

If (($l_tipoEvaluacion=1) & (vlEVS_CurrentEvStyleID#$l_IdEstiloEvaluacion))
	EVS_ReadStyleData ($l_IdEstiloEvaluacion)
	vlEVS_CurrentEvStyleID:=$l_IdEstiloEvaluacion
End if 
$r_resultado:=MPA_Calculos_PromedioEvals (->$ar_Evaluacion;->$ar_Ponderacion;vrNTA_MinimoEscalaReferencia)

KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];$l_recNum;True:C214)
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
					: ($y_punteroReal->=-2)
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
					: ($y_punteroReal->=-2)
						$y_punteroDescriptor->:=__ ("Pendiente")
					: ($y_punteroNumerico->>=vrNTA_MinimoEscalaReferencia)
						$y_punteroReal->:=ST_Num2Text ($y_punteroNumerico->;True:C214)+" sobre "+ST_Num2Text (rPointsTo;False:C215)
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
					: ($y_punteroReal->=-2)
						$y_punteroDescriptor->:=__ ("Pendiente")
					: ($y_punteroNumerico->>=vrNTA_MinimoEscalaReferencia)
						$y_punteroReal->:=ST_Num2Text ($y_punteroNumerico->;True:C214)+" sobre "+ST_Num2Text (100;False:C215)
					Else 
						$y_punteroDescriptor->:=""
				End case 
				
			: (iEvaluationMode=Simbolos)
				If ($y_punteroReal->=-2)
					$y_punteroDescriptor->:=__ ("Pendiente")
				Else 
					$y_punteroLiteral->:=EV2_Real_a_Simbolo ($y_punteroReal->)  // convierto el real al símbolo correspondiente al modo del estilo
					$y_punteroReal->:=EV2_Simbolo_a_Real ($y_punteroLiteral->)  // reconvierto el símbolo al valor real
					$l_elemento:=Find in array:C230(aSymbol;$y_punteroLiteral->)
					If ($l_elemento>0)
						$y_punteroDescriptor->:=aSymbDesc{$l_elemento}
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
