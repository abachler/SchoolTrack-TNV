//%attributes = {}
  //SRas_PlanillaDeNotas

C_LONGINT:C283($rubOfst;$3;$iEvaluationMode;$tableNumber)
C_POINTER:C301($crtPerPtr)
C_POINTER:C301($crtCtrlPtr)
C_TEXT:C284($vtCurso;$1)
C_POINTER:C301($ptr_idsAs)
$vtCurso:=""

$event:=$1
$periodo:=$2

Case of 
	: (Count parameters:C259=5)
		$iEvaluationMode:=$3
		$vtCurso:=$4
		$ptr_idsAs:=$5
	: (Count parameters:C259=4)
		$iEvaluationMode:=$3
		$vtCurso:=$4
	: (Count parameters:C259=3)
		$iEvaluationMode:=$3
	Else 
		$iEvaluationMode:=iEvaluationMode
End case 

Case of 
	: ($event="Inicio")
		COPY NAMED SELECTION:C331([Asignaturas:18];"printing")
		SRcust_InitEvaluationVariables 
		QUERY:C277([Asignaturas_SintesisAnual:202];[Asignaturas_SintesisAnual:202]ID_Asignatura:2=[Asignaturas:18]Numero:1)
		Case of 
			: ($periodo=1)
				$max:=[Asignaturas:18]Max_P1:82
				$min:=[Asignaturas:18]Min_P1:75
				$avg:=[Asignaturas:18]Promedio_P1:23
			: ($periodo=2)
				$max:=[Asignaturas:18]Max_P2:83
				$min:=[Asignaturas:18]Min_P2:76
				$avg:=[Asignaturas:18]Promedio_P2:22
			: ($periodo=3)
				$max:=[Asignaturas:18]Max_P3:84
				$min:=[Asignaturas:18]Min_P3:77
				$avg:=[Asignaturas:18]Promedio_P3:21
			: ($periodo=4)
				$max:=[Asignaturas:18]Max_P4:85
				$min:=[Asignaturas:18]Min_P4:78
				$avg:=[Asignaturas:18]Promedio_P4:59
			: ($periodo=5)
				$max:=[Asignaturas_SintesisAnual:202]P05_Maximo_Real:89
				$min:=[Asignaturas_SintesisAnual:202]P05_Minimo_Real:54
				$avg:=[Asignaturas_SintesisAnual:202]P05_Promedio_Real:45
		End case 
		
		If ($vtCurso="")
			QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
		Else 
			C_LONGINT:C283($vl_rnasi)
			$vl_rnasi:=Record number:C243([Asignaturas:18])
			If (Is nil pointer:C315($ptr_idsAs))
				QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
				QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos:2]curso:20=$vtCurso)
			Else 
				QUERY WITH ARRAY:C644([Alumnos_Calificaciones:208]ID_Asignatura:5;$ptr_idsAs->)
				QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos:2]curso:20=$vtCurso)
			End if 
			GOTO RECORD:C242([Asignaturas:18];$vl_rnasi)
		End if 
		ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]apellidos_y_nombres:40;>)
		
		$conversionTable:=iConversionTable
		iConversionTable:=0
		$pctMin:=NTA_StringValue2Percent (String:C10($min);[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		$pctMax:=NTA_StringValue2Percent (String:C10($max);[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		$pctAvg:=NTA_StringValue2Percent (String:C10($avg);[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		If ($pctMin<rPctMinimum)
			vs_TextColorminSubject:="Red"
		Else 
			vs_TextColorMinSubject:="Blue"
		End if 
		If ($pctMax<rPctMinimum)
			vs_TextColorMaxSubject:="Red"
		Else 
			vs_TextColorMaxSubject:="Blue"
		End if 
		If ($pctAvg<rPctMinimum)
			vs_TextColorAvgSubject:="Red"
		Else 
			vs_TextColorAvgSubject:="Blue"
		End if 
		vs_NotaMinSubject:=NTA_PercentValue2StringValue ($pctMin;Notas)
		vs_NotaMaxSubject:=NTA_PercentValue2StringValue ($pctMax;Notas)
		vs_NotaAvgSubject:=NTA_PercentValue2StringValue ($pctAvg;Notas)
		vs_PuntosMaxSubject:=NTA_PercentValue2StringValue ($pctMax;Puntos)
		vs_PuntosMinSubject:=NTA_PercentValue2StringValue ($pctMin;Puntos)
		vs_PuntosAvgSubject:=NTA_PercentValue2StringValue ($pctAvg;Puntos)
		iConversionTable:=$conversionTable
		
	: ($event="Cuerpo")
		vlEVS_CurrentEvStyleID:=0
		EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		AS_PropEval_Lectura ("";$periodo)
		
		$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Asignaturas:18]Numero:1)
		KRL_FindAndLoadRecordByIndex (->[Asignaturas_SintesisAnual:202]LLavePrimaria:5;->$key)
		
		Case of 
			: ($periodo=1)
				vs_EvaluacionMinSubject:=[Asignaturas_SintesisAnual:202]P01_Minimo_Literal:65
				vs_EvaluacionMaxSubject:=[Asignaturas_SintesisAnual:202]P01_Maximo_Literal:105
				vs_EvaluacionAvgSubject:=[Asignaturas_SintesisAnual:202]P01_Promedio_Literal:29
				vs_NotaMinSubject:=String:C10([Asignaturas_SintesisAnual:202]P01_Minimo_Nota:55;vs_GradesFormat)
				vs_NotaMaxSubject:=String:C10([Asignaturas_SintesisAnual:202]P01_Maximo_Nota:90;vs_GradesFormat)
				vs_NotaAvgSubject:=String:C10([Asignaturas_SintesisAnual:202]P01_Promedio_Nota:26;vs_GradesFormat)
				vs_PuntosMaxSubject:=String:C10([Asignaturas_SintesisAnual:202]P01_Minimo_Puntos:60;vs_PointsFormat)
				vs_PuntosMinSubject:=String:C10([Asignaturas_SintesisAnual:202]P01_Minimo_Puntos:60;vs_PointsFormat)
				vs_PuntosAvgSubject:=String:C10([Asignaturas_SintesisAnual:202]P01_Minimo_Puntos:60;vs_PointsFormat)
				vr_PorcentajesMaxSubject:=[Asignaturas_SintesisAnual:202]P01_Minimo_Real:50
				vr_PorcentajesMinSubject:=[Asignaturas_SintesisAnual:202]P01_Maximo_Real:85
				vr_PorcentajesAvgSubject:=[Asignaturas_SintesisAnual:202]P01_Promedio_Real:25
				vs_PorcentajesMaxSubject:=String:C10(Round:C94([Asignaturas_SintesisAnual:202]P01_Minimo_Real:50;1))
				vs_PorcentajesMinSubject:=String:C10(Round:C94([Asignaturas_SintesisAnual:202]P01_Maximo_Real:85;1))
				vs_PorcentajesAvgSubject:=String:C10(Round:C94([Asignaturas_SintesisAnual:202]P01_Promedio_Real:25;1))
				vs_SimbolosMaxSubject:=[Asignaturas_SintesisAnual:202]P01_Minimo_Simbolo:70
				vs_SimbolosMinSubject:=[Asignaturas_SintesisAnual:202]P01_Maximo_Simbolo:100
				vs_SimbolosAvgSubject:=[Asignaturas_SintesisAnual:202]P01_Promedio_Simbolo:28
				vs_ObservacionesPeriodo:=[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
				vt_Esfuerzo_P:=[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16
			: ($periodo=2)
				vs_EvaluacionMinSubject:=[Asignaturas_SintesisAnual:202]P02_Minimo_Literal:66
				vs_EvaluacionMaxSubject:=[Asignaturas_SintesisAnual:202]P02_Maximo_Literal:106
				vs_EvaluacionAvgSubject:=[Asignaturas_SintesisAnual:202]P02_Promedio_Literal:34
				vs_NotaMinSubject:=String:C10([Asignaturas_SintesisAnual:202]P02_Minimo_Nota:56;vs_GradesFormat)
				vs_NotaMaxSubject:=String:C10([Asignaturas_SintesisAnual:202]P02_Maximo_Nota:91;vs_GradesFormat)
				vs_NotaAvgSubject:=String:C10([Asignaturas_SintesisAnual:202]P02_Promedio_Nota:31;vs_GradesFormat)
				vs_PuntosMaxSubject:=String:C10([Asignaturas_SintesisAnual:202]P02_Minimo_Puntos:61;vs_PointsFormat)
				vs_PuntosMinSubject:=String:C10([Asignaturas_SintesisAnual:202]P02_Minimo_Puntos:61;vs_PointsFormat)
				vs_PuntosAvgSubject:=String:C10([Asignaturas_SintesisAnual:202]P02_Minimo_Puntos:61;vs_PointsFormat)
				vr_PorcentajesMaxSubject:=[Asignaturas_SintesisAnual:202]P02_Minimo_Real:51
				vr_PorcentajesMinSubject:=[Asignaturas_SintesisAnual:202]P02_Maximo_Real:86
				vr_PorcentajesAvgSubject:=[Asignaturas_SintesisAnual:202]P02_Promedio_Real:30
				vs_PorcentajesMaxSubject:=String:C10(Round:C94([Asignaturas_SintesisAnual:202]P02_Minimo_Real:51;1))
				vs_PorcentajesMinSubject:=String:C10(Round:C94([Asignaturas_SintesisAnual:202]P02_Maximo_Real:86;1))
				vs_PorcentajesAvgSubject:=String:C10(Round:C94([Asignaturas_SintesisAnual:202]P02_Promedio_Real:30;1))
				vs_SimbolosMaxSubject:=[Asignaturas_SintesisAnual:202]P02_Minimo_Simbolo:71
				vs_SimbolosMinSubject:=[Asignaturas_SintesisAnual:202]P02_Maximo_Simbolo:101
				vs_SimbolosAvgSubject:=[Asignaturas_SintesisAnual:202]P02_Promedio_Simbolo:33
				vs_ObservacionesPeriodo:=[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
				vt_Esfuerzo_P:=[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21
			: ($periodo=3)
				vs_EvaluacionMinSubject:=[Asignaturas_SintesisAnual:202]P03_Minimo_Literal:67
				vs_EvaluacionMaxSubject:=[Asignaturas_SintesisAnual:202]P03_Maximo_Literal:107
				vs_EvaluacionAvgSubject:=[Asignaturas_SintesisAnual:202]P03_Promedio_Literal:39
				vs_NotaMinSubject:=String:C10([Asignaturas_SintesisAnual:202]P03_Minimo_Nota:57;vs_GradesFormat)
				vs_NotaMaxSubject:=String:C10([Asignaturas_SintesisAnual:202]P03_Maximo_Nota:92;vs_GradesFormat)
				vs_NotaAvgSubject:=String:C10([Asignaturas_SintesisAnual:202]P03_Promedio_Nota:36;vs_GradesFormat)
				vs_PuntosMaxSubject:=String:C10([Asignaturas_SintesisAnual:202]P03_Minimo_Puntos:62;vs_PointsFormat)
				vs_PuntosMinSubject:=String:C10([Asignaturas_SintesisAnual:202]P03_Minimo_Puntos:62;vs_PointsFormat)
				vs_PuntosAvgSubject:=String:C10([Asignaturas_SintesisAnual:202]P03_Minimo_Puntos:62;vs_PointsFormat)
				vr_PorcentajesMaxSubject:=[Asignaturas_SintesisAnual:202]P03_Minimo_Real:52
				vr_PorcentajesMinSubject:=[Asignaturas_SintesisAnual:202]P03_Maximo_Real:87
				vr_PorcentajesAvgSubject:=[Asignaturas_SintesisAnual:202]P03_Promedio_Real:35
				vs_PorcentajesMaxSubject:=String:C10(Round:C94([Asignaturas_SintesisAnual:202]P03_Minimo_Real:52;1))
				vs_PorcentajesMinSubject:=String:C10(Round:C94([Asignaturas_SintesisAnual:202]P03_Maximo_Real:87;1))
				vs_PorcentajesAvgSubject:=String:C10(Round:C94([Asignaturas_SintesisAnual:202]P03_Promedio_Real:35;1))
				vs_SimbolosMaxSubject:=[Asignaturas_SintesisAnual:202]P03_Minimo_Simbolo:72
				vs_SimbolosMinSubject:=[Asignaturas_SintesisAnual:202]P03_Maximo_Simbolo:102
				vs_SimbolosAvgSubject:=[Asignaturas_SintesisAnual:202]P03_Promedio_Simbolo:38
				vs_ObservacionesPeriodo:=[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
				vt_Esfuerzo_P:=[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26
			: ($periodo=4)
				vs_EvaluacionMinSubject:=[Asignaturas_SintesisAnual:202]P04_Minimo_Literal:68
				vs_EvaluacionMaxSubject:=[Asignaturas_SintesisAnual:202]P04_Maximo_Literal:108
				vs_EvaluacionAvgSubject:=[Asignaturas_SintesisAnual:202]P04_Promedio_Literal:44
				vs_NotaMinSubject:=String:C10([Asignaturas_SintesisAnual:202]P04_Minimo_Nota:58;vs_GradesFormat)
				vs_NotaMaxSubject:=String:C10([Asignaturas_SintesisAnual:202]P04_Maximo_Nota:93;vs_GradesFormat)
				vs_NotaAvgSubject:=String:C10([Asignaturas_SintesisAnual:202]P04_Promedio_Nota:41;vs_GradesFormat)
				vs_PuntosMaxSubject:=String:C10([Asignaturas_SintesisAnual:202]P04_Minimo_Puntos:63;vs_PointsFormat)
				vs_PuntosMinSubject:=String:C10([Asignaturas_SintesisAnual:202]P04_Minimo_Puntos:63;vs_PointsFormat)
				vs_PuntosAvgSubject:=String:C10([Asignaturas_SintesisAnual:202]P04_Minimo_Puntos:63;vs_PointsFormat)
				vr_PorcentajesMaxSubject:=[Asignaturas_SintesisAnual:202]P04_Minimo_Real:53
				vr_PorcentajesMinSubject:=[Asignaturas_SintesisAnual:202]P04_Maximo_Real:88
				vr_PorcentajesAvgSubject:=[Asignaturas_SintesisAnual:202]P04_Promedio_Real:40
				vs_PorcentajesMaxSubject:=String:C10(Round:C94([Asignaturas_SintesisAnual:202]P04_Minimo_Real:53;1))
				vs_PorcentajesMinSubject:=String:C10(Round:C94([Asignaturas_SintesisAnual:202]P04_Maximo_Real:88;1))
				vs_PorcentajesAvgSubject:=String:C10(Round:C94([Asignaturas_SintesisAnual:202]P04_Promedio_Real:40;1))
				vs_SimbolosMaxSubject:=[Asignaturas_SintesisAnual:202]P04_Minimo_Simbolo:73
				vs_SimbolosMinSubject:=[Asignaturas_SintesisAnual:202]P04_Maximo_Simbolo:103
				vs_SimbolosAvgSubject:=[Asignaturas_SintesisAnual:202]P04_Promedio_Simbolo:43
				vs_ObservacionesPeriodo:=[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34
				vt_Esfuerzo_P:=[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31
			: ($periodo=5)
				vs_EvaluacionMinSubject:=[Asignaturas_SintesisAnual:202]P05_Minimo_Literal:69
				vs_EvaluacionMaxSubject:=[Asignaturas_SintesisAnual:202]P05_Maximo_Literal:109
				vs_EvaluacionAvgSubject:=[Asignaturas_SintesisAnual:202]P05_Promedio_Literal:49
				vs_NotaMinSubject:=String:C10([Asignaturas_SintesisAnual:202]P05_Minimo_Nota:59;vs_GradesFormat)
				vs_NotaMaxSubject:=String:C10([Asignaturas_SintesisAnual:202]P05_Maximo_Nota:94;vs_GradesFormat)
				vs_NotaAvgSubject:=String:C10([Asignaturas_SintesisAnual:202]P05_Promedio_Nota:46;vs_GradesFormat)
				vr_PorcentajesMaxSubject:=[Asignaturas_SintesisAnual:202]P05_Minimo_Real:54
				vr_PorcentajesMinSubject:=[Asignaturas_SintesisAnual:202]P05_Maximo_Real:89
				vr_PorcentajesAvgSubject:=[Asignaturas_SintesisAnual:202]P05_Promedio_Real:45
				vs_PuntosMaxSubject:=String:C10([Asignaturas_SintesisAnual:202]P05_Minimo_Puntos:64;vs_PointsFormat)
				vs_PuntosMinSubject:=String:C10([Asignaturas_SintesisAnual:202]P05_Minimo_Puntos:64;vs_PointsFormat)
				vs_PuntosAvgSubject:=String:C10([Asignaturas_SintesisAnual:202]P05_Minimo_Puntos:64;vs_PointsFormat)
				vs_PorcentajesMaxSubject:=String:C10(Round:C94([Asignaturas_SintesisAnual:202]P05_Minimo_Real:54;1))
				vs_PorcentajesMinSubject:=String:C10(Round:C94([Asignaturas_SintesisAnual:202]P05_Maximo_Real:89;1))
				vs_PorcentajesAvgSubject:=String:C10(Round:C94([Asignaturas_SintesisAnual:202]P05_Promedio_Real:45;1))
				vs_SimbolosMaxSubject:=[Asignaturas_SintesisAnual:202]P05_Minimo_Simbolo:74
				vs_SimbolosMinSubject:=[Asignaturas_SintesisAnual:202]P05_Maximo_Simbolo:104
				vs_SimbolosAvgSubject:=[Asignaturas_SintesisAnual:202]P05_Promedio_Simbolo:48
				vs_ObservacionesPeriodo:=[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39
				vt_Esfuerzo_P:=[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36
				
		End case 
		
		Case of 
			: (Size of array:C274(atSTR_Periodos_Nombre)=5)
				vs_observacionesF:=vs_Observaciones5
			: (Size of array:C274(atSTR_Periodos_Nombre)=4)
				vs_observacionesF:=vs_Observaciones4
			: (Size of array:C274(atSTR_Periodos_Nombre)=3)
				vs_observacionesF:=vs_Observaciones3
			: (Size of array:C274(atSTR_Periodos_Nombre)=2)
				vs_observacionesF:=vs_Observaciones2
			: (Size of array:C274(atSTR_Periodos_Nombre)=1)
				vs_observacionesF:=vs_Observaciones1
		End case 
		vs_Observaciones1:=[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
		vs_Observaciones2:=[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
		vs_Observaciones3:=[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
		vs_Observaciones4:=[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34
		vs_Observaciones5:=[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39
		vs_observacionesF:=[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46
		
		  //11 de agosto 2004 JHB
		QUERY:C277([Asignaturas_Objetivos:104];[Asignaturas_Objetivos:104]ID:1=[Asignaturas:18]ID_Objetivos:43)
		vt_Objetivos_P1:=[Asignaturas_Objetivos:104]Objetivos_P1:6
		vt_Objetivos_P2:=[Asignaturas_Objetivos:104]Objetivos_P2:7
		vt_Objetivos_P3:=[Asignaturas_Objetivos:104]Objetivos_P3:8
		vt_Objetivos_P4:=[Asignaturas_Objetivos:104]Objetivos_P4:9
		vt_Objetivos_P5:=[Asignaturas_Objetivos:104]Objetivos_P5:10
		$temp:=Get pointer:C304("vt_Objetivos_P"+String:C10(vPeriodo))
		vt_Objetivos_P:=$temp->
		
		
		  // =================NOTAS PARCIALES Y FINALES DEL PERIODO =================
		  // notas parciales
		EV2_ObtieneDatosPeriodoActual 
		$nextField:=Field:C253(->[Alumnos_Calificaciones:208]PeriodoActual_Eval01_Real:417)
		$tableNumber:=Table:C252(->[Alumnos_Calificaciones:208])
		For ($i;1;12)
			$pct:=Field:C253($tableNumber;$nextField)->
			Case of 
				: ($pct=-10)
					aSRpTextColorsPointers{$i}->:="Black"
					aSRpDefaultModePointers{$i}->:=""
					aSRpNotasPointers{$i}->:=""
					aSRpPuntosPointers{$i}->:=""
					aSRpSimbolosPointers{$i}->:=""
					aSRpIndicadoresPointers{$i}->:=""
					aSRpPorcentajesPointers{$i}->:=Round:C94($pct;1)
					
				: ($pct=-2)
					aSRpTextColorsPointers{$i}->:="Green"
					aSRpDefaultModePointers{$i}->:="P"
					aSRpNotasPointers{$i}->:="P"
					aSRpPuntosPointers{$i}->:="P"
					aSRpSimbolosPointers{$i}->:="P"
					aSRpIndicadoresPointers{$i}->:="Pendiente"
					aSRpPorcentajesPointers{$i}->:=Round:C94($pct;1)
					
				: ($pct=-3)
					aSRpTextColorsPointers{$i}->:="Black"
					aSRpDefaultModePointers{$i}->:="X"
					aSRpNotasPointers{$i}->:="X"
					aSRpPuntosPointers{$i}->:="X"
					aSRpSimbolosPointers{$i}->:="X"
					aSRpIndicadoresPointers{$i}->:="Eximido"
					aSRpPorcentajesPointers{$i}->:=Round:C94($pct;1)
					
				: ($pct=-4)
					aSRpTextColorsPointers{$i}->:="Black"
					aSRpDefaultModePointers{$i}->:="*"
					aSRpNotasPointers{$i}->:="*"
					aSRpPuntosPointers{$i}->:="*"
					aSRpSimbolosPointers{$i}->:="*"
					aSRpIndicadoresPointers{$i}->:="No evaluado"
					aSRpPorcentajesPointers{$i}->:=Round:C94($pct;1)
					
				Else 
					If ($pct<rPctMinimum)
						aSRpTextColorsPointers{$i}->:="Red"
					Else 
						aSRpTextColorsPointers{$i}->:="Blue"
					End if 
					aSRpDefaultModePointers{$i}->:=Field:C253($tableNumber;$nextField+4)->
					aSRpNotasPointers{$i}->:=String:C10(Field:C253($tableNumber;$nextField+1)->;vs_GradesFormat)
					aSRpPuntosPointers{$i}->:=String:C10(Field:C253($tableNumber;$nextField+2)->;vs_PointsFormat)
					aSRpSimbolosPointers{$i}->:=Field:C253($tableNumber;$nextField+3)->
					aSRpIndicadoresPointers{$i}->:=_Evaluacion_a_Indicador ($pct)
					aSRpPorcentajesPointers{$i}->:=Round:C94($pct;1)
			End case 
			
			$nextField:=$nextField+5
		End for 
		
		  // Nota de presentacion
		Case of 
			: ([Alumnos_Calificaciones:208]PeriodoActual_Present_Real:477=-10)
				vs_TextColorPresentacion:="Black"
				vs_EvaluacionPresentacion:=""
				vs_NotaPresentacion:=""
				vs_puntosPresentacion:=""
				vs_SimbolosPresentacion:=""
				vs_IndicadorPresentacion:=""
				vr_PorcentajePresentacion:=Round:C94([Alumnos_Calificaciones:208]PeriodoActual_Present_Real:477;1)
				
			: ([Alumnos_Calificaciones:208]PeriodoActual_Present_Real:477=-2)
				vs_TextColorPresentacion:="Green"
				vs_EvaluacionPresentacion:="P"
				vs_NotaPresentacion:="P"
				vs_puntosPresentacion:="P"
				vs_SimbolosPresentacion:="P"
				vs_IndicadorPresentacion:="Pendiente"
				vr_PorcentajePresentacion:=Round:C94([Alumnos_Calificaciones:208]PeriodoActual_Present_Real:477;1)
				
			: ([Alumnos_Calificaciones:208]PeriodoActual_Present_Real:477=-3)
				vs_TextColorPresentacion:="Black"
				vs_EvaluacionPresentacion:="X"
				vs_NotaPresentacion:="X"
				vs_puntosPresentacion:="X"
				vs_SimbolosPresentacion:="X"
				vs_IndicadorPresentacion:="Eximido"
				vr_PorcentajePresentacion:=Round:C94([Alumnos_Calificaciones:208]PeriodoActual_Present_Real:477;1)
			: ([Alumnos_Calificaciones:208]PeriodoActual_Present_Real:477=-4)
				vs_TextColorPresentacion:="Black"
				vs_EvaluacionPresentacion:="*"
				vs_NotaPresentacion:="*"
				vs_puntosPresentacion:="*"
				vs_SimbolosPresentacion:="*"
				vs_IndicadorPresentacion:="No Evaluado"
				vr_PorcentajePresentacion:=Round:C94([Alumnos_Calificaciones:208]PeriodoActual_Present_Real:477;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]PeriodoActual_Present_Real:477<rPctMinimum)
					vs_TextColorPresentacion:="Red"
				Else 
					vs_TextColorPresentacion:="Blue"
				End if 
				vs_EvaluacionPresentacion:=[Alumnos_Calificaciones:208]PeriodoActual_Present_Literal:481
				vs_NotaPresentacion:=String:C10([Alumnos_Calificaciones:208]PeriodoActual_Present_Nota:478;vs_GradesFormat)
				vs_puntosPresentacion:=String:C10([Alumnos_Calificaciones:208]PeriodoActual_Present_Puntos:479;vs_PointsFormat)
				vs_SimbolosPresentacion:=[Alumnos_Calificaciones:208]PeriodoActual_Present_Simbolo:480
				vs_IndicadorPresentacion:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]PeriodoActual_Present_Real:477)
				vr_PorcentajePresentacion:=Round:C94([Alumnos_Calificaciones:208]PeriodoActual_Present_Real:477;1)
		End case 
		
		  // control de periodo
		Case of 
			: ([Alumnos_Calificaciones:208]PeriodoActual_Control_Real:482=-10)
				vs_TextColorEXP:="Black"
				vs_EvaluacionEXP:=""
				vs_NotaEXP:=""
				vs_puntosEXP:=""
				vs_SimbolosEXP:=""
				vs_IndicadorEXP:=""
				vr_PorcentajeEXP:=Round:C94([Alumnos_Calificaciones:208]PeriodoActual_Control_Real:482;1)
				
			: ([Alumnos_Calificaciones:208]PeriodoActual_Control_Real:482=-2)
				vs_TextColorEXP:="Green"
				vs_EvaluacionEXP:="P"
				vs_NotaEXP:="P"
				vs_puntosEXP:="P"
				vs_SimbolosEXP:="P"
				vs_IndicadorEXP:="Pendiente"
				vr_PorcentajeEXP:=Round:C94([Alumnos_Calificaciones:208]PeriodoActual_Control_Real:482;1)
				
			: ([Alumnos_Calificaciones:208]PeriodoActual_Control_Real:482=-3)
				vs_TextColorEXP:="Black"
				vs_EvaluacionEXP:="X"
				vs_NotaEXP:="X"
				vs_puntosEXP:="X"
				vs_SimbolosEXP:="X"
				vs_IndicadorEXP:="Eximido"
				vr_PorcentajeEXP:=Round:C94([Alumnos_Calificaciones:208]PeriodoActual_Control_Real:482;1)
			: ([Alumnos_Calificaciones:208]PeriodoActual_Control_Real:482=-4)
				vs_TextColorEXP:="Black"
				vs_EvaluacionEXP:="*"
				vs_NotaEXP:="*"
				vs_puntosEXP:="*"
				vs_SimbolosEXP:="*"
				vs_IndicadorEXP:="No Evaluado"
				vr_PorcentajeEXP:=Round:C94([Alumnos_Calificaciones:208]PeriodoActual_Control_Real:482;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]PeriodoActual_Control_Real:482<rPctMinimum)
					vs_TextColorEXP:="Red"
				Else 
					vs_TextColorEXP:="Blue"
				End if 
				vs_EvaluacionEXP:=[Alumnos_Calificaciones:208]PeriodoActual_Control_Literal:486
				vs_NotaEXP:=String:C10([Alumnos_Calificaciones:208]PeriodoActual_Control_Nota:483;vs_GradesFormat)
				vs_puntosEXP:=String:C10([Alumnos_Calificaciones:208]PeriodoActual_Control_Puntos:484;vs_PointsFormat)
				vs_SimbolosEXP:=[Alumnos_Calificaciones:208]PeriodoActual_Control_Simbolo:485
				vs_IndicadorEXP:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]PeriodoActual_Present_Real:477)
				vr_PorcentajeEXP:=Round:C94([Alumnos_Calificaciones:208]PeriodoActual_Control_Real:482;1)
		End case 
		
		  // Promedio Periodo
		Case of 
			: ([Alumnos_Calificaciones:208]PeriodoActual_Final_Real:487=-10)
				vs_TextColorPromedioPeriodo:="Black"
				vs_EvaluacionPromedioPeriodo:=""
				vs_NotaPromedioPeriodo:=""
				vs_puntosPromedioPeriodo:=""
				vs_SimbolosPromedioPeriodo:=""
				vs_IndicadorPromedioPeriodo:=""
				vr_PorcentajePromedioPeriodo:=Round:C94([Alumnos_Calificaciones:208]PeriodoActual_Final_Real:487;1)
				
			: ([Alumnos_Calificaciones:208]PeriodoActual_Final_Real:487=-2)
				vs_TextColorPromedioPeriodo:="Green"
				vs_EvaluacionPromedioPeriodo:="P"
				vs_NotaPromedioPeriodo:="P"
				vs_puntosPromedioPeriodo:="P"
				vs_SimbolosPromedioPeriodo:="P"
				vs_IndicadorPromedioPeriodo:="Pendiente"
				vr_PorcentajePromedioPeriodo:=Round:C94([Alumnos_Calificaciones:208]PeriodoActual_Final_Real:487;1)
				
			: ([Alumnos_Calificaciones:208]PeriodoActual_Final_Real:487=-3)
				vs_TextColorPromedioPeriodo:="Black"
				vs_EvaluacionPromedioPeriodo:="X"
				vs_NotaPromedioPeriodo:="X"
				vs_puntosPromedioPeriodo:="X"
				vs_SimbolosPromedioPeriodo:="X"
				vs_IndicadorPromedioPeriodo:="Eximido"
				vr_PorcentajePromedioPeriodo:=Round:C94([Alumnos_Calificaciones:208]PeriodoActual_Final_Real:487;1)
			: ([Alumnos_Calificaciones:208]PeriodoActual_Final_Real:487=-4)
				vs_TextColorPromedioPeriodo:="Black"
				vs_EvaluacionPromedioPeriodo:="*"
				vs_NotaPromedioPeriodo:="*"
				vs_puntosPromedioPeriodo:="*"
				vs_SimbolosPromedioPeriodo:="*"
				vs_IndicadorPromedioPeriodo:="No Evaluado"
				vr_PorcentajePromedioPeriodo:=Round:C94([Alumnos_Calificaciones:208]PeriodoActual_Final_Real:487;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]PeriodoActual_Final_Real:487<rPctMinimum)
					vs_TextColorPromedioPeriodo:="Red"
				Else 
					vs_TextColorPromedioPeriodo:="Blue"
				End if 
				vs_EvaluacionPromedioPeriodo:=[Alumnos_Calificaciones:208]PeriodoActual_Final_Literal:491
				vs_NotaPromedioPeriodo:=String:C10([Alumnos_Calificaciones:208]PeriodoActual_Final_Nota:488;vs_GradesFormat)
				vs_puntosPromedioPeriodo:=String:C10([Alumnos_Calificaciones:208]PeriodoActual_Final_Puntos:489;vs_PointsFormat)
				vs_SimbolosPromedioPeriodo:=[Alumnos_Calificaciones:208]PeriodoActual_Final_Simbolo:490
				vs_IndicadorPromedioPeriodo:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]PeriodoActual_Final_Real:487)
				vr_PorcentajePromedioPeriodo:=Round:C94([Alumnos_Calificaciones:208]PeriodoActual_Final_Real:487;1)
		End case 
		  //  ========================================================
		
		
		  // =================FINALES DEL PERIODO 1=================
		  // presentacion
		Case of 
			: ([Alumnos_Calificaciones:208]P01_Presentacion_Real:102=-10)
				vs_TextColorPresentacionP1:="Black"
				vs_EvaluacionPresentacionP1:=""
				vs_NotaPresentacionP1:=""
				vs_puntosPresentacionP1:=""
				vs_SimbolosPresentacionP1:=""
				vs_IndicadorPresentacionP1:=""
				vr_PorcentajePresentacionP1:=Round:C94([Alumnos_Calificaciones:208]P01_Presentacion_Real:102;1)
				
			: ([Alumnos_Calificaciones:208]P01_Presentacion_Real:102=-2)
				vs_TextColorPresentacionP1:="Green"
				vs_EvaluacionPresentacionP1:="P"
				vs_NotaPresentacionP1:="P"
				vs_puntosPresentacionP1:="P"
				vs_SimbolosPresentacionP1:="P"
				vs_IndicadorPresentacionP1:="Pendiente"
				vr_PorcentajePresentacionP1:=Round:C94([Alumnos_Calificaciones:208]P01_Presentacion_Real:102;1)
				
			: ([Alumnos_Calificaciones:208]P01_Presentacion_Real:102=-3)
				vs_TextColorPresentacionP1:="Black"
				vs_EvaluacionPresentacionP1:="X"
				vs_NotaPresentacionP1:="X"
				vs_puntosPresentacionP1:="X"
				vs_SimbolosPresentacionP1:="X"
				vs_IndicadorPresentacionP1:="Eximido"
				vr_PorcentajePresentacionP1:=Round:C94([Alumnos_Calificaciones:208]P01_Presentacion_Real:102;1)
				
			: ([Alumnos_Calificaciones:208]P01_Presentacion_Real:102=-4)
				vs_TextColorPresentacionP1:="Black"
				vs_EvaluacionPresentacionP1:="*"
				vs_NotaPresentacionP1:="*"
				vs_puntosPresentacionP1:="*"
				vs_SimbolosPresentacionP1:="*"
				vs_IndicadorPresentacionP1:="No Evaluado"
				vr_PorcentajePresentacionP1:=Round:C94([Alumnos_Calificaciones:208]P01_Presentacion_Real:102;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]P01_Presentacion_Real:102<rPctMinimum)
					vs_TextColorPresentacionP1:="Red"
				Else 
					vs_TextColorPresentacionP1:="Blue"
				End if 
				
				vs_EvaluacionPresentacionP1:=[Alumnos_Calificaciones:208]P01_Presentacion_Literal:106
				vs_NotaPresentacionP1:=String:C10([Alumnos_Calificaciones:208]P01_Presentacion_Nota:103;vs_GradesFormat)
				vs_puntosPresentacionP1:=String:C10([Alumnos_Calificaciones:208]P01_Presentacion_Puntos:104;vs_PointsFormat)
				vs_SimbolosPresentacionP1:=[Alumnos_Calificaciones:208]P01_Presentacion_Simbolo:105
				vs_IndicadorPresentacionP1:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P01_Presentacion_Real:102)
				vr_PorcentajePresentacionP1:=Round:C94([Alumnos_Calificaciones:208]P01_Presentacion_Real:102;1)
		End case 
		
		  // control fin de periodo
		Case of 
			: ([Alumnos_Calificaciones:208]P01_Control_Real:107=-10)
				vs_TextColorEXP1:="Black"
				vs_EvaluacionEXP1:=""
				vs_NotaEXP1:=""
				vs_puntosEXP1:=""
				vs_SimbolosEXP1:=""
				vs_IndicadorEXP1:=""
				vr_PorcentajeEXP1:=Round:C94([Alumnos_Calificaciones:208]P01_Control_Real:107;1)
				
			: ([Alumnos_Calificaciones:208]P01_Control_Real:107=-2)
				vs_TextColorEXP1:="Green"
				vs_EvaluacionEXP1:="P"
				vs_NotaEXP1:="P"
				vs_puntosEXP1:="P"
				vs_SimbolosEXP1:="P"
				vs_IndicadorEXP1:="Pendiente"
				vr_PorcentajeEXP1:=Round:C94([Alumnos_Calificaciones:208]P01_Control_Real:107;1)
				
			: ([Alumnos_Calificaciones:208]P01_Control_Real:107=-3)
				vs_TextColorEXP1:="Black"
				vs_EvaluacionEXP1:="X"
				vs_NotaEXP1:="X"
				vs_puntosEXP1:="X"
				vs_SimbolosEXP1:="X"
				vs_IndicadorEXP1:="Eximido"
				vr_PorcentajeEXP1:=Round:C94([Alumnos_Calificaciones:208]P01_Control_Real:107;1)
				
			: ([Alumnos_Calificaciones:208]P01_Control_Real:107=-4)
				vs_TextColorEXP1:="Black"
				vs_EvaluacionEXP1:="*"
				vs_NotaEXP1:="*"
				vs_puntosEXP1:="*"
				vs_SimbolosEXP1:="*"
				vs_IndicadorEXP1:="No Evaluado"
				vr_PorcentajeEXP1:=Round:C94([Alumnos_Calificaciones:208]P01_Control_Real:107;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]P01_Control_Real:107<rPctMinimum)
					vs_TextColorEXP1:="Red"
				Else 
					vs_TextColorEXP1:="Blue"
				End if 
				
				vs_EvaluacionEXP1:=[Alumnos_Calificaciones:208]P01_Control_Literal:111
				vs_NotaEXP1:=String:C10([Alumnos_Calificaciones:208]P01_Control_Nota:108;vs_GradesFormat)
				vs_puntosEXP1:=String:C10([Alumnos_Calificaciones:208]P01_Control_Puntos:109;vs_PointsFormat)
				vs_SimbolosEXP1:=[Alumnos_Calificaciones:208]P01_Control_Simbolo:110
				vs_IndicadorEXP1:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P01_Control_Real:107)
				vr_PorcentajeEXP1:=Round:C94([Alumnos_Calificaciones:208]P01_Control_Real:107;1)
		End case 
		
		
		  // promedio periodo
		Case of 
			: ([Alumnos_Calificaciones:208]P01_Final_Real:112=-10)
				vs_TextColorPromedio1:="Black"
				vs_EvaluacionPromedio1:=""
				vs_NotaPromedio1:=""
				vs_puntosPromedio1:=""
				vs_SimbolosPromedio1:=""
				vs_IndicadorPromedio1:=""
				vr_PorcentajePromedio1:=Round:C94([Alumnos_Calificaciones:208]P01_Final_Real:112;1)
				
			: ([Alumnos_Calificaciones:208]P01_Final_Real:112=-2)
				vs_TextColorPromedio1:="Green"
				vs_EvaluacionPromedio1:="P"
				vs_NotaPromedio1:="P"
				vs_puntosPromedio1:="P"
				vs_SimbolosPromedio1:="P"
				vs_IndicadorPromedio1:="Pendiente"
				vr_PorcentajePromedio1:=Round:C94([Alumnos_Calificaciones:208]P01_Final_Real:112;1)
				
			: ([Alumnos_Calificaciones:208]P01_Final_Real:112=-3)
				vs_TextColorPromedio1:="Black"
				vs_EvaluacionPromedio1:="X"
				vs_NotaPromedio1:="X"
				vs_puntosPromedio1:="X"
				vs_SimbolosPromedio1:="X"
				vs_IndicadorPromedio1:="Eximido"
				vr_PorcentajePromedio1:=Round:C94([Alumnos_Calificaciones:208]P01_Final_Real:112;1)
				
			: ([Alumnos_Calificaciones:208]P01_Final_Real:112=-4)
				vs_TextColorPromedio1:="Black"
				vs_EvaluacionPromedio1:="*"
				vs_NotaPromedio1:="*"
				vs_puntosPromedio1:="*"
				vs_SimbolosPromedio1:="*"
				vs_IndicadorPromedio1:="No Evaluado"
				vr_PorcentajePromedio1:=Round:C94([Alumnos_Calificaciones:208]P01_Final_Real:112;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]P01_Final_Real:112<rPctMinimum)
					vs_TextColorPromedio1:="Red"
				Else 
					vs_TextColorPromedio1:="Blue"
				End if 
				
				vs_EvaluacionPromedio1:=[Alumnos_Calificaciones:208]P01_Final_Literal:116
				vs_NotaPromedio1:=String:C10([Alumnos_Calificaciones:208]P01_Final_Nota:113;vs_GradesFormat)
				vs_puntosPromedio1:=String:C10([Alumnos_Calificaciones:208]P01_Final_Puntos:114;vs_PointsFormat)
				vs_SimbolosPromedio1:=[Alumnos_Calificaciones:208]P01_Final_Simbolo:115
				vs_IndicadorPromedio1:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P01_Final_Real:112)
				vr_PorcentajePromedio1:=Round:C94([Alumnos_Calificaciones:208]P01_Final_Real:112;1)
		End case 
		vt_Esfuerzo_P1:=[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16
		
		
		  // =================FINALES DEL PERIODO 2=================
		  // presentacion
		Case of 
			: ([Alumnos_Calificaciones:208]P02_Presentacion_Real:177=-10)
				vs_TextColorPresentacionP2:="Black"
				vs_EvaluacionPresentacionP2:=""
				vs_NotaPresentacionP2:=""
				vs_puntosPresentacionP2:=""
				vs_SimbolosPresentacionP2:=""
				vs_IndicadorPresentacionP2:=""
				vr_PorcentajePresentacionP2:=Round:C94([Alumnos_Calificaciones:208]P02_Presentacion_Real:177;1)
				
			: ([Alumnos_Calificaciones:208]P02_Presentacion_Real:177=-2)
				vs_TextColorPresentacionP2:="Green"
				vs_EvaluacionPresentacionP2:="P"
				vs_NotaPresentacionP2:="P"
				vs_puntosPresentacionP2:="P"
				vs_SimbolosPresentacionP2:="P"
				vs_IndicadorPresentacionP2:="Pendiente"
				vr_PorcentajePresentacionP2:=Round:C94([Alumnos_Calificaciones:208]P02_Presentacion_Real:177;1)
				
			: ([Alumnos_Calificaciones:208]P02_Presentacion_Real:177=-3)
				vs_TextColorPresentacionP2:="Black"
				vs_EvaluacionPresentacionP2:="X"
				vs_NotaPresentacionP2:="X"
				vs_puntosPresentacionP2:="X"
				vs_SimbolosPresentacionP2:="X"
				vs_IndicadorPresentacionP2:="Eximido"
				vr_PorcentajePresentacionP2:=Round:C94([Alumnos_Calificaciones:208]P02_Presentacion_Real:177;1)
				
			: ([Alumnos_Calificaciones:208]P02_Presentacion_Real:177=-4)
				vs_TextColorPresentacionP2:="Black"
				vs_EvaluacionPresentacionP2:="*"
				vs_NotaPresentacionP2:="*"
				vs_puntosPresentacionP2:="*"
				vs_SimbolosPresentacionP2:="*"
				vs_IndicadorPresentacionP2:="No Evaluado"
				vr_PorcentajePresentacionP2:=Round:C94([Alumnos_Calificaciones:208]P02_Presentacion_Real:177;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]P02_Presentacion_Real:177<rPctMinimum)
					vs_TextColorPresentacionP2:="Red"
				Else 
					vs_TextColorPresentacionP2:="Blue"
				End if 
				
				vs_EvaluacionPresentacionP2:=[Alumnos_Calificaciones:208]P02_Presentacion_Literal:181
				vs_NotaPresentacionP2:=String:C10([Alumnos_Calificaciones:208]P02_Presentacion_Nota:178;vs_GradesFormat)
				vs_puntosPresentacionP2:=String:C10([Alumnos_Calificaciones:208]P02_Presentacion_Puntos:179;vs_PointsFormat)
				vs_SimbolosPresentacionP2:=[Alumnos_Calificaciones:208]P02_Presentacion_Simbolo:180
				vs_IndicadorPresentacionP2:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P02_Presentacion_Real:177)
				vr_PorcentajePresentacionP2:=Round:C94([Alumnos_Calificaciones:208]P02_Presentacion_Real:177;1)
		End case 
		
		  // control fin de periodo
		Case of 
			: ([Alumnos_Calificaciones:208]P02_Control_Real:182=-10)
				vs_TextColorEXP2:="Black"
				vs_EvaluacionEXP2:=""
				vs_NotaEXP2:=""
				vs_puntosEXP2:=""
				vs_SimbolosEXP2:=""
				vs_IndicadorEXP2:=""
				vr_PorcentajeEXP2:=Round:C94([Alumnos_Calificaciones:208]P02_Control_Real:182;1)
				
			: ([Alumnos_Calificaciones:208]P02_Control_Real:182=-2)
				vs_TextColorEXP2:="Green"
				vs_EvaluacionEXP2:="P"
				vs_NotaEXP2:="P"
				vs_puntosEXP2:="P"
				vs_SimbolosEXP2:="P"
				vs_IndicadorEXP2:="Pendiente"
				vr_PorcentajeEXP2:=Round:C94([Alumnos_Calificaciones:208]P02_Control_Real:182;1)
				
			: ([Alumnos_Calificaciones:208]P02_Control_Real:182=-3)
				vs_TextColorEXP2:="Black"
				vs_EvaluacionEXP2:="X"
				vs_NotaEXP2:="X"
				vs_puntosEXP2:="X"
				vs_SimbolosEXP2:="X"
				vs_IndicadorEXP2:="Eximido"
				vr_PorcentajeEXP2:=Round:C94([Alumnos_Calificaciones:208]P02_Control_Real:182;1)
				
			: ([Alumnos_Calificaciones:208]P02_Control_Real:182=-4)
				vs_TextColorEXP2:="Black"
				vs_EvaluacionEXP2:="*"
				vs_NotaEXP2:="*"
				vs_puntosEXP2:="*"
				vs_SimbolosEXP2:="*"
				vs_IndicadorEXP2:="No Evaluado"
				vr_PorcentajeEXP2:=Round:C94([Alumnos_Calificaciones:208]P02_Control_Real:182;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]P02_Control_Real:182<rPctMinimum)
					vs_TextColorEXP2:="Red"
				Else 
					vs_TextColorEXP2:="Blue"
				End if 
				
				vs_EvaluacionEXP2:=[Alumnos_Calificaciones:208]P02_Control_Literal:186
				vs_NotaEXP2:=String:C10([Alumnos_Calificaciones:208]P02_Control_Nota:183;vs_GradesFormat)
				vs_puntosEXP2:=String:C10([Alumnos_Calificaciones:208]P02_Control_Puntos:184;vs_PointsFormat)
				vs_SimbolosEXP2:=[Alumnos_Calificaciones:208]P02_Control_Simbolo:185
				vs_IndicadorEXP2:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P02_Control_Real:182)
				vr_PorcentajeEXP2:=Round:C94([Alumnos_Calificaciones:208]P02_Control_Real:182;1)
		End case 
		
		
		  // promedio periodo
		Case of 
			: ([Alumnos_Calificaciones:208]P02_Final_Real:187=-10)
				vs_TextColorPromedio2:="Black"
				vs_EvaluacionPromedio2:=""
				vs_NotaPromedio2:=""
				vs_puntosPromedio2:=""
				vs_SimbolosPromedio2:=""
				vs_IndicadorPromedio2:=""
				vr_PorcentajePromedio2:=Round:C94([Alumnos_Calificaciones:208]P02_Final_Real:187;1)
				
			: ([Alumnos_Calificaciones:208]P02_Final_Real:187=-2)
				vs_TextColorPromedio2:="Green"
				vs_EvaluacionPromedio2:="P"
				vs_NotaPromedio2:="P"
				vs_puntosPromedio2:="P"
				vs_SimbolosPromedio2:="P"
				vs_IndicadorPromedio2:="Pendiente"
				vr_PorcentajePromedio2:=Round:C94([Alumnos_Calificaciones:208]P02_Final_Real:187;1)
				
			: ([Alumnos_Calificaciones:208]P02_Final_Real:187=-3)
				vs_TextColorPromedio2:="Black"
				vs_EvaluacionPromedio2:="X"
				vs_NotaPromedio2:="X"
				vs_puntosPromedio2:="X"
				vs_SimbolosPromedio2:="X"
				vs_IndicadorPromedio2:="Eximido"
				vr_PorcentajePromedio2:=Round:C94([Alumnos_Calificaciones:208]P02_Final_Real:187;1)
				
			: ([Alumnos_Calificaciones:208]P02_Final_Real:187=-4)
				vs_TextColorPromedio2:="Black"
				vs_EvaluacionPromedio2:="*"
				vs_NotaPromedio2:="*"
				vs_puntosPromedio2:="*"
				vs_SimbolosPromedio2:="*"
				vs_IndicadorPromedio2:="No Evaluado"
				vr_PorcentajePromedio2:=Round:C94([Alumnos_Calificaciones:208]P02_Final_Real:187;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]P02_Final_Real:187<rPctMinimum)
					vs_TextColorPromedio2:="Red"
				Else 
					vs_TextColorPromedio2:="Blue"
				End if 
				
				vs_EvaluacionPromedio2:=[Alumnos_Calificaciones:208]P02_Final_Literal:191
				vs_NotaPromedio2:=String:C10([Alumnos_Calificaciones:208]P02_Final_Nota:188;vs_GradesFormat)
				vs_puntosPromedio2:=String:C10([Alumnos_Calificaciones:208]P02_Final_Puntos:189;vs_PointsFormat)
				vs_SimbolosPromedio2:=[Alumnos_Calificaciones:208]P02_Final_Simbolo:190
				vs_IndicadorPromedio2:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P02_Final_Real:187)
				vr_PorcentajePromedio2:=Round:C94([Alumnos_Calificaciones:208]P02_Final_Real:187;1)
		End case 
		vt_Esfuerzo_P2:=[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21
		
		
		  // =================FINALES DEL PERIODO 3=================
		  // presentacion
		Case of 
			: ([Alumnos_Calificaciones:208]P03_Presentacion_Real:252=-10)
				vs_TextColorPresentacionP3:="Black"
				vs_EvaluacionPresentacionP3:=""
				vs_NotaPresentacionP3:=""
				vs_puntosPresentacionP3:=""
				vs_SimbolosPresentacionP3:=""
				vs_IndicadorPresentacionP3:=""
				vr_PorcentajePresentacionP3:=Round:C94([Alumnos_Calificaciones:208]P03_Presentacion_Real:252;1)
				
			: ([Alumnos_Calificaciones:208]P03_Presentacion_Real:252=-2)
				vs_TextColorPresentacionP3:="Green"
				vs_EvaluacionPresentacionP3:="P"
				vs_NotaPresentacionP3:="P"
				vs_puntosPresentacionP3:="P"
				vs_SimbolosPresentacionP3:="P"
				vs_IndicadorPresentacionP3:="Pendiente"
				vr_PorcentajePresentacionP3:=Round:C94([Alumnos_Calificaciones:208]P03_Presentacion_Real:252;1)
				
			: ([Alumnos_Calificaciones:208]P03_Presentacion_Real:252=-3)
				vs_TextColorPresentacionP3:="Black"
				vs_EvaluacionPresentacionP3:="X"
				vs_NotaPresentacionP3:="X"
				vs_puntosPresentacionP3:="X"
				vs_SimbolosPresentacionP3:="X"
				vs_IndicadorPresentacionP3:="Eximido"
				vr_PorcentajePresentacionP3:=Round:C94([Alumnos_Calificaciones:208]P03_Presentacion_Real:252;1)
				
			: ([Alumnos_Calificaciones:208]P03_Presentacion_Real:252=-4)
				vs_TextColorPresentacionP3:="Black"
				vs_EvaluacionPresentacionP3:="*"
				vs_NotaPresentacionP3:="*"
				vs_puntosPresentacionP3:="*"
				vs_SimbolosPresentacionP3:="*"
				vs_IndicadorPresentacionP3:="No Evaluado"
				vr_PorcentajePresentacionP3:=Round:C94([Alumnos_Calificaciones:208]P03_Presentacion_Real:252;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]P03_Presentacion_Real:252<rPctMinimum)
					vs_TextColorPresentacionP3:="Red"
				Else 
					vs_TextColorPresentacionP3:="Blue"
				End if 
				
				vs_EvaluacionPresentacionP3:=[Alumnos_Calificaciones:208]P03_Presentacion_Literal:256
				vs_NotaPresentacionP3:=String:C10([Alumnos_Calificaciones:208]P03_Presentacion_Nota:253;vs_GradesFormat)
				vs_puntosPresentacionP3:=String:C10([Alumnos_Calificaciones:208]P03_Presentacion_Puntos:254;vs_PointsFormat)
				vs_SimbolosPresentacionP3:=[Alumnos_Calificaciones:208]P03_Presentacion_Simbolo:255
				vs_IndicadorPresentacionP3:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P03_Presentacion_Real:252)
				vr_PorcentajePresentacionP3:=Round:C94([Alumnos_Calificaciones:208]P03_Presentacion_Real:252;1)
		End case 
		
		  // control fin de periodo
		Case of 
			: ([Alumnos_Calificaciones:208]P03_Control_Real:257=-10)
				vs_TextColorEXP3:="Black"
				vs_EvaluacionEXP3:=""
				vs_NotaEXP3:=""
				vs_puntosEXP3:=""
				vs_SimbolosEXP3:=""
				vs_IndicadorEXP3:=""
				vr_PorcentajeEXP3:=Round:C94([Alumnos_Calificaciones:208]P03_Control_Real:257;1)
				
			: ([Alumnos_Calificaciones:208]P03_Control_Real:257=-2)
				vs_TextColorEXP3:="Green"
				vs_EvaluacionEXP3:="P"
				vs_NotaEXP3:="P"
				vs_puntosEXP3:="P"
				vs_SimbolosEXP3:="P"
				vs_IndicadorEXP3:="Pendiente"
				vr_PorcentajeEXP3:=Round:C94([Alumnos_Calificaciones:208]P03_Control_Real:257;1)
				
			: ([Alumnos_Calificaciones:208]P03_Control_Real:257=-3)
				vs_TextColorEXP3:="Black"
				vs_EvaluacionEXP3:="X"
				vs_NotaEXP3:="X"
				vs_puntosEXP3:="X"
				vs_SimbolosEXP3:="X"
				vs_IndicadorEXP3:="Eximido"
				vr_PorcentajeEXP3:=Round:C94([Alumnos_Calificaciones:208]P03_Control_Real:257;1)
				
			: ([Alumnos_Calificaciones:208]P03_Control_Real:257=-4)
				vs_TextColorEXP3:="Black"
				vs_EvaluacionEXP3:="*"
				vs_NotaEXP3:="*"
				vs_puntosEXP3:="*"
				vs_SimbolosEXP3:="*"
				vs_IndicadorEXP3:="No Evaluado"
				vr_PorcentajeEXP3:=Round:C94([Alumnos_Calificaciones:208]P03_Control_Real:257;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]P03_Control_Real:257<rPctMinimum)
					vs_TextColorEXP3:="Red"
				Else 
					vs_TextColorEXP3:="Blue"
				End if 
				
				vs_EvaluacionEXP3:=[Alumnos_Calificaciones:208]P03_Control_Literal:261
				vs_NotaEXP3:=String:C10([Alumnos_Calificaciones:208]P03_Control_Nota:258;vs_GradesFormat)
				vs_puntosEXP3:=String:C10([Alumnos_Calificaciones:208]P03_Control_Puntos:259;vs_PointsFormat)
				vs_SimbolosEXP3:=[Alumnos_Calificaciones:208]P03_Control_Simbolo:260
				vs_IndicadorEXP3:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P03_Control_Real:257)
				vr_PorcentajeEXP3:=Round:C94([Alumnos_Calificaciones:208]P03_Control_Real:257;1)
		End case 
		
		
		  // promedio periodo
		Case of 
			: ([Alumnos_Calificaciones:208]P03_Final_Real:262=-10)
				vs_TextColorPromedio3:="Black"
				vs_EvaluacionPromedio3:=""
				vs_NotaPromedio3:=""
				vs_puntosPromedio3:=""
				vs_SimbolosPromedio3:=""
				vs_IndicadorPromedio3:=""
				vr_PorcentajePromedio3:=Round:C94([Alumnos_Calificaciones:208]P03_Final_Real:262;1)
				
			: ([Alumnos_Calificaciones:208]P03_Final_Real:262=-2)
				vs_TextColorPromedio3:="Green"
				vs_EvaluacionPromedio3:="P"
				vs_NotaPromedio3:="P"
				vs_puntosPromedio3:="P"
				vs_SimbolosPromedio3:="P"
				vs_IndicadorPromedio3:="Pendiente"
				vr_PorcentajePromedio3:=Round:C94([Alumnos_Calificaciones:208]P03_Final_Real:262;1)
				
			: ([Alumnos_Calificaciones:208]P03_Final_Real:262=-3)
				vs_TextColorPromedio3:="Black"
				vs_EvaluacionPromedio3:="X"
				vs_NotaPromedio3:="X"
				vs_puntosPromedio3:="X"
				vs_SimbolosPromedio3:="X"
				vs_IndicadorPromedio3:="Eximido"
				vr_PorcentajePromedio3:=Round:C94([Alumnos_Calificaciones:208]P03_Final_Real:262;1)
				
			: ([Alumnos_Calificaciones:208]P03_Final_Real:262=-4)
				vs_TextColorPromedio3:="Black"
				vs_EvaluacionPromedio3:="*"
				vs_NotaPromedio3:="*"
				vs_puntosPromedio3:="*"
				vs_SimbolosPromedio3:="*"
				vs_IndicadorPromedio3:="No Evaluado"
				vr_PorcentajePromedio3:=Round:C94([Alumnos_Calificaciones:208]P03_Final_Real:262;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]P03_Final_Real:262<rPctMinimum)
					vs_TextColorPromedio3:="Red"
				Else 
					vs_TextColorPromedio3:="Blue"
				End if 
				
				vs_EvaluacionPromedio3:=[Alumnos_Calificaciones:208]P03_Final_Literal:266
				vs_NotaPromedio3:=String:C10([Alumnos_Calificaciones:208]P03_Final_Nota:263;vs_GradesFormat)
				vs_puntosPromedio3:=String:C10([Alumnos_Calificaciones:208]P03_Final_Puntos:264;vs_PointsFormat)
				vs_SimbolosPromedio3:=[Alumnos_Calificaciones:208]P03_Final_Simbolo:265
				vs_IndicadorPromedio3:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P03_Final_Real:262)
				vr_PorcentajePromedio3:=Round:C94([Alumnos_Calificaciones:208]P03_Final_Real:262;1)
		End case 
		vt_Esfuerzo_P3:=[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26
		
		
		  // =================FINALES DEL PERIODO 4=================
		  // presentacion
		Case of 
			: ([Alumnos_Calificaciones:208]P04_Presentacion_Real:327=-10)
				vs_TextColorPresentacionP4:="Black"
				vs_EvaluacionPresentacionP4:=""
				vs_NotaPresentacionP4:=""
				vs_puntosPresentacionP4:=""
				vs_SimbolosPresentacionP4:=""
				vs_IndicadorPresentacionP4:=""
				vr_PorcentajePresentacionP4:=Round:C94([Alumnos_Calificaciones:208]P04_Presentacion_Real:327;1)
				
			: ([Alumnos_Calificaciones:208]P04_Presentacion_Real:327=-2)
				vs_TextColorPresentacionP4:="Green"
				vs_EvaluacionPresentacionP4:="P"
				vs_NotaPresentacionP4:="P"
				vs_puntosPresentacionP4:="P"
				vs_SimbolosPresentacionP4:="P"
				vs_IndicadorPresentacionP4:="Pendiente"
				vr_PorcentajePresentacionP4:=Round:C94([Alumnos_Calificaciones:208]P04_Presentacion_Real:327;1)
				
			: ([Alumnos_Calificaciones:208]P04_Presentacion_Real:327=-3)
				vs_TextColorPresentacionP4:="Black"
				vs_EvaluacionPresentacionP4:="X"
				vs_NotaPresentacionP4:="X"
				vs_puntosPresentacionP4:="X"
				vs_SimbolosPresentacionP4:="X"
				vs_IndicadorPresentacionP4:="Eximido"
				vr_PorcentajePresentacionP4:=Round:C94([Alumnos_Calificaciones:208]P04_Presentacion_Real:327;1)
				
			: ([Alumnos_Calificaciones:208]P04_Presentacion_Real:327=-4)
				vs_TextColorPresentacionP4:="Black"
				vs_EvaluacionPresentacionP4:="*"
				vs_NotaPresentacionP4:="*"
				vs_puntosPresentacionP4:="*"
				vs_SimbolosPresentacionP4:="*"
				vs_IndicadorPresentacionP4:="No Evaluado"
				vr_PorcentajePresentacionP4:=Round:C94([Alumnos_Calificaciones:208]P04_Presentacion_Real:327;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]P04_Presentacion_Real:327<rPctMinimum)
					vs_TextColorPresentacionP4:="Red"
				Else 
					vs_TextColorPresentacionP4:="Blue"
				End if 
				
				vs_EvaluacionPresentacionP4:=[Alumnos_Calificaciones:208]P04_Presentacion_Literal:331
				vs_NotaPresentacionP4:=String:C10([Alumnos_Calificaciones:208]P04_Presentacion_Nota:328;vs_GradesFormat)
				vs_puntosPresentacionP4:=String:C10([Alumnos_Calificaciones:208]P04_Presentacion_Puntos:329;vs_PointsFormat)
				vs_SimbolosPresentacionP4:=[Alumnos_Calificaciones:208]P04_Presentacion_Simbolo:330
				vs_IndicadorPresentacionP4:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P04_Presentacion_Real:327)
				vr_PorcentajePresentacionP4:=Round:C94([Alumnos_Calificaciones:208]P04_Presentacion_Real:327;1)
		End case 
		
		  // control fin de periodo
		Case of 
			: ([Alumnos_Calificaciones:208]P04_Control_Real:332=-10)
				vs_TextColorEXP4:="Black"
				vs_EvaluacionEXP4:=""
				vs_NotaEXP4:=""
				vs_puntosEXP4:=""
				vs_SimbolosEXP4:=""
				vs_IndicadorEXP4:=""
				vr_PorcentajeEXP4:=Round:C94([Alumnos_Calificaciones:208]P04_Control_Real:332;1)
				
			: ([Alumnos_Calificaciones:208]P04_Control_Real:332=-2)
				vs_TextColorEXP4:="Green"
				vs_EvaluacionEXP4:="P"
				vs_NotaEXP4:="P"
				vs_puntosEXP4:="P"
				vs_SimbolosEXP4:="P"
				vs_IndicadorEXP4:="Pendiente"
				vr_PorcentajeEXP4:=Round:C94([Alumnos_Calificaciones:208]P04_Control_Real:332;1)
				
			: ([Alumnos_Calificaciones:208]P04_Control_Real:332=-3)
				vs_TextColorEXP4:="Black"
				vs_EvaluacionEXP4:="X"
				vs_NotaEXP4:="X"
				vs_puntosEXP4:="X"
				vs_SimbolosEXP4:="X"
				vs_IndicadorEXP4:="Eximido"
				vr_PorcentajeEXP4:=Round:C94([Alumnos_Calificaciones:208]P04_Control_Real:332;1)
				
			: ([Alumnos_Calificaciones:208]P04_Control_Real:332=-4)
				vs_TextColorEXP4:="Black"
				vs_EvaluacionEXP4:="*"
				vs_NotaEXP4:="*"
				vs_puntosEXP4:="*"
				vs_SimbolosEXP4:="*"
				vs_IndicadorEXP4:="No Evaluado"
				vr_PorcentajeEXP4:=Round:C94([Alumnos_Calificaciones:208]P04_Control_Real:332;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]P04_Control_Real:332<rPctMinimum)
					vs_TextColorEXP4:="Red"
				Else 
					vs_TextColorEXP4:="Blue"
				End if 
				
				vs_EvaluacionEXP4:=[Alumnos_Calificaciones:208]P04_Control_Literal:336
				vs_NotaEXP4:=String:C10([Alumnos_Calificaciones:208]P04_Control_Nota:333;vs_GradesFormat)
				vs_puntosEXP4:=String:C10([Alumnos_Calificaciones:208]P04_Control_Puntos:334;vs_PointsFormat)
				vs_SimbolosEXP4:=[Alumnos_Calificaciones:208]P04_Control_Simbolo:335
				vs_IndicadorEXP4:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P04_Control_Real:332)
				vr_PorcentajeEXP4:=Round:C94([Alumnos_Calificaciones:208]P04_Control_Real:332;1)
		End case 
		
		
		  // promedio periodo
		Case of 
			: ([Alumnos_Calificaciones:208]P04_Final_Real:337=-10)
				vs_TextColorPromedio4:="Black"
				vs_EvaluacionPromedio4:=""
				vs_NotaPromedio4:=""
				vs_puntosPromedio4:=""
				vs_SimbolosPromedio4:=""
				vs_IndicadorPromedio4:=""
				vr_PorcentajePromedio4:=Round:C94([Alumnos_Calificaciones:208]P04_Final_Real:337;1)
				
			: ([Alumnos_Calificaciones:208]P04_Final_Real:337=-2)
				vs_TextColorPromedio4:="Green"
				vs_EvaluacionPromedio4:="P"
				vs_NotaPromedio4:="P"
				vs_puntosPromedio4:="P"
				vs_SimbolosPromedio4:="P"
				vs_IndicadorPromedio4:="Pendiente"
				vr_PorcentajePromedio4:=Round:C94([Alumnos_Calificaciones:208]P04_Final_Real:337;1)
				
			: ([Alumnos_Calificaciones:208]P04_Final_Real:337=-3)
				vs_TextColorPromedio4:="Black"
				vs_EvaluacionPromedio4:="X"
				vs_NotaPromedio4:="X"
				vs_puntosPromedio4:="X"
				vs_SimbolosPromedio4:="X"
				vs_IndicadorPromedio4:="Eximido"
				vr_PorcentajePromedio4:=Round:C94([Alumnos_Calificaciones:208]P04_Final_Real:337;1)
				
			: ([Alumnos_Calificaciones:208]P04_Final_Real:337=-4)
				vs_TextColorPromedio4:="Black"
				vs_EvaluacionPromedio4:="*"
				vs_NotaPromedio4:="*"
				vs_puntosPromedio4:="*"
				vs_SimbolosPromedio4:="*"
				vs_IndicadorPromedio4:="No Evaluado"
				vr_PorcentajePromedio4:=Round:C94([Alumnos_Calificaciones:208]P04_Final_Real:337;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]P04_Final_Real:337<rPctMinimum)
					vs_TextColorPromedio4:="Red"
				Else 
					vs_TextColorPromedio4:="Blue"
				End if 
				
				vs_EvaluacionPromedio4:=[Alumnos_Calificaciones:208]P04_Final_Literal:341
				vs_NotaPromedio4:=String:C10([Alumnos_Calificaciones:208]P04_Final_Nota:338;vs_GradesFormat)
				vs_puntosPromedio4:=String:C10([Alumnos_Calificaciones:208]P04_Final_Puntos:339;vs_PointsFormat)
				vs_SimbolosPromedio4:=[Alumnos_Calificaciones:208]P04_Final_Simbolo:340
				vs_IndicadorPromedio4:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P04_Final_Real:337)
				vr_PorcentajePromedio4:=Round:C94([Alumnos_Calificaciones:208]P04_Final_Real:337;1)
		End case 
		vt_Esfuerzo_P4:=[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31
		
		
		  // =================FINALES DEL PERIODO 5=================
		  // presentacion
		Case of 
			: ([Alumnos_Calificaciones:208]P05_Presentacion_Real:402=-10)
				vs_TextColorPresentacionP5:="Black"
				vs_EvaluacionPresentacionP5:=""
				vs_NotaPresentacionP5:=""
				vs_puntosPresentacionP5:=""
				vs_SimbolosPresentacionP5:=""
				vs_IndicadorPresentacionP5:=""
				vr_PorcentajePresentacionP5:=Round:C94([Alumnos_Calificaciones:208]P05_Presentacion_Real:402;1)
				
			: ([Alumnos_Calificaciones:208]P05_Presentacion_Real:402=-2)
				vs_TextColorPresentacionP5:="Green"
				vs_EvaluacionPresentacionP5:="P"
				vs_NotaPresentacionP5:="P"
				vs_puntosPresentacionP5:="P"
				vs_SimbolosPresentacionP5:="P"
				vs_IndicadorPresentacionP5:="Pendiente"
				vr_PorcentajePresentacionP5:=Round:C94([Alumnos_Calificaciones:208]P05_Presentacion_Real:402;1)
				
			: ([Alumnos_Calificaciones:208]P05_Presentacion_Real:402=-3)
				vs_TextColorPresentacionP5:="Black"
				vs_EvaluacionPresentacionP5:="X"
				vs_NotaPresentacionP5:="X"
				vs_puntosPresentacionP5:="X"
				vs_SimbolosPresentacionP5:="X"
				vs_IndicadorPresentacionP5:="Eximido"
				vr_PorcentajePresentacionP5:=Round:C94([Alumnos_Calificaciones:208]P05_Presentacion_Real:402;1)
				
			: ([Alumnos_Calificaciones:208]P05_Presentacion_Real:402=-4)
				vs_TextColorPresentacionP5:="Black"
				vs_EvaluacionPresentacionP5:="*"
				vs_NotaPresentacionP5:="*"
				vs_puntosPresentacionP5:="*"
				vs_SimbolosPresentacionP5:="*"
				vs_IndicadorPresentacionP5:="No Evaluado"
				vr_PorcentajePresentacionP5:=Round:C94([Alumnos_Calificaciones:208]P05_Presentacion_Real:402;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]P05_Presentacion_Real:402<rPctMinimum)
					vs_TextColorPresentacionP5:="Red"
				Else 
					vs_TextColorPresentacionP5:="Blue"
				End if 
				
				vs_EvaluacionPresentacionP5:=[Alumnos_Calificaciones:208]P05_Presentacion_Literal:406
				vs_NotaPresentacionP5:=String:C10([Alumnos_Calificaciones:208]P05_Presentacion_Nota:403;vs_GradesFormat)
				vs_puntosPresentacionP5:=String:C10([Alumnos_Calificaciones:208]P05_Presentacion_Puntos:404;vs_PointsFormat)
				vs_SimbolosPresentacionP5:=[Alumnos_Calificaciones:208]P05_Presentacion_Simbolo:405
				vs_IndicadorPresentacionP5:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P05_Presentacion_Real:402)
				vr_PorcentajePresentacionP5:=Round:C94([Alumnos_Calificaciones:208]P05_Presentacion_Real:402;1)
		End case 
		
		  // control fin de periodo
		Case of 
			: ([Alumnos_Calificaciones:208]P05_Control_Real:407=-10)
				vs_TextColorEXP5:="Black"
				vs_EvaluacionEXP5:=""
				vs_NotaEXP5:=""
				vs_puntosEXP5:=""
				vs_SimbolosEXP5:=""
				vs_IndicadorEXP5:=""
				vr_PorcentajeEXP5:=Round:C94([Alumnos_Calificaciones:208]P05_Control_Real:407;1)
				
			: ([Alumnos_Calificaciones:208]P05_Control_Real:407=-2)
				vs_TextColorEXP5:="Green"
				vs_EvaluacionEXP5:="P"
				vs_NotaEXP5:="P"
				vs_puntosEXP5:="P"
				vs_SimbolosEXP5:="P"
				vs_IndicadorEXP5:="Pendiente"
				vr_PorcentajeEXP5:=Round:C94([Alumnos_Calificaciones:208]P05_Control_Real:407;1)
				
			: ([Alumnos_Calificaciones:208]P05_Control_Real:407=-3)
				vs_TextColorEXP5:="Black"
				vs_EvaluacionEXP5:="X"
				vs_NotaEXP5:="X"
				vs_puntosEXP5:="X"
				vs_SimbolosEXP5:="X"
				vs_IndicadorEXP5:="Eximido"
				vr_PorcentajeEXP5:=Round:C94([Alumnos_Calificaciones:208]P05_Control_Real:407;1)
				
			: ([Alumnos_Calificaciones:208]P05_Control_Real:407=-4)
				vs_TextColorEXP5:="Black"
				vs_EvaluacionEXP5:="*"
				vs_NotaEXP5:="*"
				vs_puntosEXP5:="*"
				vs_SimbolosEXP5:="*"
				vs_IndicadorEXP5:="No Evaluado"
				vr_PorcentajeEXP5:=Round:C94([Alumnos_Calificaciones:208]P05_Control_Real:407;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]P05_Control_Real:407<rPctMinimum)
					vs_TextColorEXP5:="Red"
				Else 
					vs_TextColorEXP5:="Blue"
				End if 
				
				vs_EvaluacionEXP5:=[Alumnos_Calificaciones:208]P05_Control_Literal:411
				vs_NotaEXP5:=String:C10([Alumnos_Calificaciones:208]P05_Control_Nota:408;vs_GradesFormat)
				vs_puntosEXP5:=String:C10([Alumnos_Calificaciones:208]P05_Control_Puntos:409;vs_PointsFormat)
				vs_SimbolosEXP5:=[Alumnos_Calificaciones:208]P05_Control_Simbolo:410
				vs_IndicadorEXP5:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P05_Control_Real:407)
				vr_PorcentajeEXP5:=Round:C94([Alumnos_Calificaciones:208]P05_Control_Real:407;1)
		End case 
		
		
		  // promedio periodo
		Case of 
			: ([Alumnos_Calificaciones:208]P05_Final_Real:412=-10)
				vs_TextColorPromedio5:="Black"
				vs_EvaluacionPromedio5:=""
				vs_NotaPromedio5:=""
				vs_puntosPromedio5:=""
				vs_SimbolosPromedio5:=""
				vs_IndicadorPromedio5:=""
				vr_PorcentajePromedio5:=Round:C94([Alumnos_Calificaciones:208]P05_Final_Real:412;1)
				
			: ([Alumnos_Calificaciones:208]P05_Final_Real:412=-2)
				vs_TextColorPromedio5:="Green"
				vs_EvaluacionPromedio5:="P"
				vs_NotaPromedio5:="P"
				vs_puntosPromedio5:="P"
				vs_SimbolosPromedio5:="P"
				vs_IndicadorPromedio5:="Pendiente"
				vr_PorcentajePromedio5:=Round:C94([Alumnos_Calificaciones:208]P05_Final_Real:412;1)
				
			: ([Alumnos_Calificaciones:208]P05_Final_Real:412=-3)
				vs_TextColorPromedio5:="Black"
				vs_EvaluacionPromedio5:="X"
				vs_NotaPromedio5:="X"
				vs_puntosPromedio5:="X"
				vs_SimbolosPromedio5:="X"
				vs_IndicadorPromedio5:="Eximido"
				vr_PorcentajePromedio5:=Round:C94([Alumnos_Calificaciones:208]P05_Final_Real:412;1)
				
			: ([Alumnos_Calificaciones:208]P05_Final_Real:412=-4)
				vs_TextColorPromedio5:="Black"
				vs_EvaluacionPromedio5:="*"
				vs_NotaPromedio5:="*"
				vs_puntosPromedio5:="*"
				vs_SimbolosPromedio5:="*"
				vs_IndicadorPromedio5:="No Evaluado"
				vr_PorcentajePromedio5:=Round:C94([Alumnos_Calificaciones:208]P05_Final_Real:412;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]P05_Final_Real:412<rPctMinimum)
					vs_TextColorPromedio5:="Red"
				Else 
					vs_TextColorPromedio5:="Blue"
				End if 
				
				vs_EvaluacionPromedio5:=[Alumnos_Calificaciones:208]P05_Final_Literal:416
				vs_NotaPromedio5:=String:C10([Alumnos_Calificaciones:208]P05_Final_Nota:413;vs_GradesFormat)
				vs_puntosPromedio5:=String:C10([Alumnos_Calificaciones:208]P05_Final_Puntos:414;vs_PointsFormat)
				vs_SimbolosPromedio5:=[Alumnos_Calificaciones:208]P05_Final_Simbolo:415
				vs_IndicadorPromedio5:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P05_Final_Real:412)
				vr_PorcentajePromedio5:=Round:C94([Alumnos_Calificaciones:208]P05_Final_Real:412;1)
		End case 
		vt_Esfuerzo_P5:=[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36
		
		
		Case of 
			: ([Alumnos_Calificaciones:208]Anual_Real:11=-10)
				vs_TextColorPromedioFinal:="Black"
				vs_EvaluacionPromedioFinal:=""
				vs_NotaPromedioFinal:=""
				vs_puntosPromedioFinal:=""
				vs_SimbolosPromedioFinal:=""
				vs_IndicadorPromedioFinal:=""
				vr_PorcentajePromedioFinal:=Round:C94([Alumnos_Calificaciones:208]Anual_Real:11;1)
				
			: ([Alumnos_Calificaciones:208]Anual_Real:11=-2)
				vs_TextColorPromedioFinal:="Green"
				vs_EvaluacionPromedioFinal:="P"
				vs_NotaPromedioFinal:="P"
				vs_puntosPromedioFinal:="P"
				vs_SimbolosPromedioFinal:="P"
				vs_IndicadorPromedioFinal:="Pendiente"
				vr_PorcentajePromedioFinal:=Round:C94([Alumnos_Calificaciones:208]Anual_Real:11;1)
				
			: ([Alumnos_Calificaciones:208]Anual_Real:11=-3)
				vs_TextColorPromedioFinal:="Black"
				vs_EvaluacionPromedioFinal:="X"
				vs_NotaPromedioFinal:="X"
				vs_puntosPromedioFinal:="X"
				vs_SimbolosPromedioFinal:="X"
				vs_IndicadorPromedioFinal:="Eximido"
				vr_PorcentajePromedioFinal:=Round:C94([Alumnos_Calificaciones:208]Anual_Real:11;1)
			: ([Alumnos_Calificaciones:208]PeriodoActual_Present_Real:477=-4)
				vs_TextColorPromedioFinal:="Black"
				vs_EvaluacionPromedioFinal:="*"
				vs_NotaPromedioFinal:="*"
				vs_puntosPromedioFinal:="*"
				vs_SimbolosPromedioFinal:="*"
				vs_IndicadorPromedioFinal:="No Evaluado"
				vr_PorcentajePromedioFinal:=Round:C94([Alumnos_Calificaciones:208]Anual_Real:11;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]Anual_Real:11<rPctMinimum)
					vs_TextColorPromedioFinal:="Red"
				Else 
					vs_TextColorPromedioFinal:="Blue"
				End if 
				vs_EvaluacionPromedioFinal:=[Alumnos_Calificaciones:208]Anual_Literal:15
				vs_NotaPromedioFinal:=String:C10([Alumnos_Calificaciones:208]Anual_Nota:12;vs_GradesFormat)
				vs_puntosPromedioFinal:=String:C10([Alumnos_Calificaciones:208]Anual_Puntos:13;vs_PointsFormat)
				vs_SimbolosPromedioFinal:=[Alumnos_Calificaciones:208]Anual_Simbolo:14
				vs_IndicadorPromedioFinal:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]Anual_Real:11)
				vr_PorcentajePromedioFinal:=Round:C94([Alumnos_Calificaciones:208]Anual_Real:11;1)
		End case 
		
		
		
		Case of 
			: ([Alumnos_Calificaciones:208]ExamenAnual_Real:16=-10)
				vs_TextColorExamen:="Black"
				vs_EvaluacionExamen:=""
				vs_NotaExamen:=""
				vs_puntosExamen:=""
				vs_SimbolosExamen:=""
				vs_IndicadorExamen:=""
				vr_PorcentajeExamen:=Round:C94([Alumnos_Calificaciones:208]ExamenAnual_Real:16;1)
				
			: ([Alumnos_Calificaciones:208]ExamenAnual_Real:16=-2)
				vs_TextColorExamen:="Green"
				vs_EvaluacionExamen:="P"
				vs_NotaExamen:="P"
				vs_puntosExamen:="P"
				vs_SimbolosExamen:="P"
				vs_IndicadorExamen:="Pendiente"
				vr_PorcentajeExamen:=Round:C94([Alumnos_Calificaciones:208]ExamenAnual_Real:16;1)
				
			: ([Alumnos_Calificaciones:208]ExamenAnual_Real:16=-3)
				vs_TextColorExamen:="Black"
				vs_EvaluacionExamen:="X"
				vs_NotaExamen:="X"
				vs_puntosExamen:="X"
				vs_SimbolosExamen:="X"
				vs_IndicadorExamen:="Eximido"
				vr_PorcentajeExamen:=Round:C94([Alumnos_Calificaciones:208]ExamenAnual_Real:16;1)
			: ([Alumnos_Calificaciones:208]PeriodoActual_Present_Real:477=-4)
				vs_TextColorExamen:="Black"
				vs_EvaluacionExamen:="*"
				vs_NotaExamen:="*"
				vs_puntosExamen:="*"
				vs_SimbolosExamen:="*"
				vs_IndicadorExamen:="No Evaluado"
				vr_PorcentajeExamen:=Round:C94([Alumnos_Calificaciones:208]ExamenAnual_Real:16;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]ExamenAnual_Real:16<rPctMinimum)
					vs_TextColorExamen:="Red"
				Else 
					vs_TextColorExamen:="Blue"
				End if 
				vs_EvaluacionExamen:=[Alumnos_Calificaciones:208]ExamenAnual_Literal:20
				vs_NotaExamen:=String:C10([Alumnos_Calificaciones:208]ExamenAnual_Nota:17;vs_GradesFormat)
				vs_puntosExamen:=String:C10([Alumnos_Calificaciones:208]ExamenAnual_Puntos:18;vs_PointsFormat)
				vs_SimbolosExamen:=[Alumnos_Calificaciones:208]ExamenAnual_Simbolo:19
				vs_IndicadorExamen:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]ExamenAnual_Real:16)
				vr_PorcentajeExamen:=Round:C94([Alumnos_Calificaciones:208]ExamenAnual_Real:16;1)
		End case 
		
		Case of 
			: ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26=-10)
				vs_TextColorFinal:="Black"
				vs_EvaluacionFinal:=""
				vs_NotaFinal:=""
				vs_puntosFinal:=""
				vs_SimbolosFinal:=""
				vs_IndicadorFinal:=""
				vr_PorcentajeFinal:=Round:C94([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;1)
				
			: ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26=-2)
				vs_TextColorFinal:="Green"
				vs_EvaluacionFinal:="P"
				vs_NotaFinal:="P"
				vs_puntosFinal:="P"
				vs_SimbolosFinal:="P"
				vs_IndicadorFinal:="Pendiente"
				vr_PorcentajeFinal:=Round:C94([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;1)
				
			: ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26=-3)
				vs_TextColorFinal:="Black"
				vs_EvaluacionFinal:="X"
				vs_NotaFinal:="X"
				vs_puntosFinal:="X"
				vs_SimbolosFinal:="X"
				vs_IndicadorFinal:="Eximido"
				vr_PorcentajeFinal:=Round:C94([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;1)
			: ([Alumnos_Calificaciones:208]PeriodoActual_Present_Real:477=-4)
				vs_TextColorFinal:="Black"
				vs_EvaluacionFinal:="*"
				vs_NotaFinal:="*"
				vs_puntosFinal:="*"
				vs_SimbolosFinal:="*"
				vs_IndicadorFinal:="No Evaluado"
				vr_PorcentajeFinal:=Round:C94([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26<rPctMinimum)
					vs_TextColorFinal:="Red"
				Else 
					vs_TextColorFinal:="Blue"
				End if 
				vs_EvaluacionFinal:=[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
				vs_NotaFinal:=String:C10([Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;vs_GradesFormat)
				vs_puntosFinal:=String:C10([Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28;vs_PointsFormat)
				vs_SimbolosFinal:=[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29
				vs_IndicadorFinal:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
				vr_PorcentajeFinal:=Round:C94([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;1)
		End case 
		
		READ ONLY:C145([xxSTR_Niveles:6])
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Asignaturas:18]Numero_del_Nivel:6)
		EVS_ReadStyleData ([xxSTR_Niveles:6]EvStyle_oficial:23)
		Case of 
			: ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32=-10)
				vs_TextColorOficial:="Black"
				vs_EvaluacionOficial:=""
				vs_NotaOficial:=""
				vs_puntosOficial:=""
				vs_SimbolosOficial:=""
				vs_IndicadorOficial:=""
				vr_PorcentajeOficial:=Round:C94([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;1)
				
			: ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32=-2)
				vs_TextColorOficial:="Green"
				vs_EvaluacionOficial:="P"
				vs_NotaOficial:="P"
				vs_puntosOficial:="P"
				vs_SimbolosOficial:="P"
				vs_IndicadorOficial:="Pendiente"
				vr_PorcentajeOficial:=Round:C94([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;1)
				
			: ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32=-3)
				vs_TextColorOficial:="Black"
				vs_EvaluacionOficial:="X"
				vs_NotaOficial:="X"
				vs_puntosOficial:="X"
				vs_SimbolosOficial:="X"
				vs_IndicadorOficial:="Eximido"
				vr_PorcentajeOficial:=Round:C94([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;1)
			: ([Alumnos_Calificaciones:208]PeriodoActual_Present_Real:477=-4)
				vs_TextColorOficial:="Black"
				vs_EvaluacionOficial:="*"
				vs_NotaOficial:="*"
				vs_puntosOficial:="*"
				vs_SimbolosOficial:="*"
				vs_IndicadorOficial:="No Evaluado"
				vr_PorcentajeOficial:=Round:C94([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;1)
				
			Else 
				If ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32<rPctMinimum)
					vs_TextColorFinalOficialG:="Red"
				Else 
					vs_TextColorFinalOficialG:="Blue"
				End if 
				vs_EvaluacionOficial:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36
				vs_NotaOficial:=String:C10([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;vs_GradesFormat)
				vs_puntosOficial:=String:C10([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34;vs_PointsFormat)
				vs_SimbolosOficial:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35
				vs_IndicadorOficial:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32)
				vr_PorcentajeOficial:=Round:C94([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;1)
		End case 
		
		
		EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		
		$conversionTable:=iConversionTable
		iConversionTable:=0
		
		
		vr_PorcentajesMaxSubject:=[Asignaturas_SintesisAnual:202]P01_Minimo_Real:50
		vr_PorcentajesMinSubject:=[Asignaturas_SintesisAnual:202]P01_Maximo_Real:85
		vr_PorcentajesAvgSubject:=[Asignaturas_SintesisAnual:202]P01_Promedio_Real:25
		
		If (vr_PorcentajesMinSubject<rPctMinimum)
			vs_TextColorminSubject:="Red"
		Else 
			vs_TextColorMinSubject:="Blue"
		End if 
		If (vr_PorcentajesMaxSubject<rPctMinimum)
			vs_TextColorMaxSubject:="Red"
		Else 
			vs_TextColorMaxSubject:="Blue"
		End if 
		If (vr_PorcentajesAvgSubject<rPctMinimum)
			vs_TextColorAvgSubject:="Red"
		Else 
			vs_TextColorAvgSubject:="Blue"
		End if 
		If ([Asignaturas_SintesisAnual:202]Final_Minimo_Real:80<rPctMinimum)
			vs_TextColorMinSubjectF:="Red"
		Else 
			vs_TextColorMinSubjectF:="Blue"
		End if 
		If ([Asignaturas_SintesisAnual:202]Final_Maximo_Real:115<rPctMinimum)
			vs_TextColorMaxSubjectF:="Red"
		Else 
			vs_TextColorMaxSubjectF:="Blue"
		End if 
		
		If ([Asignaturas_SintesisAnual:202]PromedioFinal_Real:15<rPctMinimum)
			vs_TextColorAvgSubjectF:="Red"
		Else 
			vs_TextColorAvgSubjectF:="Blue"
		End if 
		
		
		  //------------------------- 
		vs_EvaluacionMinSubjectF:=[Asignaturas_SintesisAnual:202]Final_Minimo_Literal:83
		vs_EvaluacionMaxSubjectF:=[Asignaturas_SintesisAnual:202]Final_Maximo_Literal:119
		vs_EvaluacionAvgSubjectF:=[Asignaturas_SintesisAnual:202]PromedioFinal_Literal:19
		vs_NotaMinSubjectF:=String:C10([Asignaturas_SintesisAnual:202]Final_Minimo_Nota:81;vs_GradesFormat)
		vs_NotaMaxSubjectF:=String:C10([Asignaturas_SintesisAnual:202]Final_Maximo_Nota:116;vs_GradesFormat)
		vs_NotaAvgSubjectF:=String:C10([Asignaturas_SintesisAnual:202]PromedioAnual_Nota:11;vs_GradesFormat)
		vs_PuntosMaxSubjectF:=String:C10([Asignaturas_SintesisAnual:202]Final_Minimo_Puntos:82;vs_PointsFormat)
		vs_PuntosMinSubjectF:=String:C10([Asignaturas_SintesisAnual:202]Final_Maximo_Puntos:117;vs_PointsFormat)
		vs_PuntosAvgSubjectF:=String:C10([Asignaturas_SintesisAnual:202]PromedioFinal_Puntos:17;vs_PointsFormat)
		vs_PorcentajesMaxSubjectF:=String:C10(Round:C94([Asignaturas_SintesisAnual:202]Final_Maximo_Real:115;1))
		vs_PorcentajesMinSubjectF:=String:C10(Round:C94([Asignaturas_SintesisAnual:202]Final_Minimo_Real:80;1))
		vs_PorcentajesAvgSubjectF:=String:C10(Round:C94([Asignaturas_SintesisAnual:202]PromedioFinal_Real:15;1))
		vs_SimbolosMaxSubjectF:=NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]Final_Maximo_Real:115;Simbolos)
		vs_SimbolosMinSubjectF:=NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]Final_Minimo_Real:80;Simbolos)
		vs_SimbolosAvgSubjectF:=NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]PromedioFinal_Real:15;Simbolos)
		
		
		vs_Observaciones1G:=[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
		vs_Observaciones2G:=[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
		vs_Observaciones3G:=[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
		vs_Observaciones4G:=[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34
		vs_Observaciones5G:=[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39
		vtSRal_ComentariosFinal:=[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46
		
	: ($event="SubTotal")
		iEvaluationMode:=$iEvaluationMode
		SRas_Estadisticas ($periodo)
		USE NAMED SELECTION:C332("Printing")
End case 
