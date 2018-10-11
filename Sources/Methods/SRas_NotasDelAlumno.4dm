//%attributes = {}
  //SRas_NotasDelAlumno

C_LONGINT:C283($rubOfst;$2;$tableNumber)
C_POINTER:C301($crtPerPtr)
C_POINTER:C301($crtCtrlPtr)


If (Count parameters:C259=3)
	$detail:=$3
Else 
	$detail:=0
End if 

$periodo:=vPeriodo
$event:=$1

Case of 
	: ($event="Inicio")
		EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
		SRcust_InitEvaluationVariables 
		SRal_FotoDelAlumno 
		SRal_InformacionConductual 
		vs_Nuevo:="X"*Num:C11(Year of:C25([Alumnos:2]Fecha_de_Ingreso:41)=<>gYear)
		
		
	: ($event="Cuerpo")
		RELATE ONE:C42([Alumnos_Calificaciones:208]Llave_principal:1)
		EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		AS_PropEval_Lectura ("";$periodo)
		
		vs_SubjectName:=[Asignaturas:18]Asignatura:3
		vs_SubjectAlias:=[Asignaturas:18]denominacion_interna:16
		vs_Sector:=[Asignaturas:18]Sector:9
		
		If (vrNTA_MinimoEscalaReferencia>0)
			$vs_GradesFormat:=vs_GradesFormat+";;"
			$vs_PointsFormat:=vs_PointsFormat+";;"
		Else 
			$formatoNotaCero:="0"+<>tXS_RS_DecimalSeparator+("0"*iGradesDec)
			$formatoPuntosCero:="0"+<>tXS_RS_DecimalSeparator+("0"*iPointsDec)
			$vs_GradesFormat:=vs_GradesFormat+";;"+$formatoNotaCero
			$vs_PointsFormat:=vs_PointsFormat+";;"+$formatoPuntosCero
		End if 
		
		
		
		$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Asignaturas:18]Numero:1)
		KRL_FindAndLoadRecordByIndex (->[Asignaturas_SintesisAnual:202]LLavePrimaria:5;->$key)
		
		Case of 
			: ($periodo=1)
				vs_EvaluacionMinSubject:=[Asignaturas_SintesisAnual:202]P01_Minimo_Literal:65
				vs_EvaluacionMaxSubject:=[Asignaturas_SintesisAnual:202]P01_Maximo_Literal:105
				vs_EvaluacionAvgSubject:=[Asignaturas_SintesisAnual:202]P01_Promedio_Literal:29
				vs_NotaMinSubject:=String:C10([Asignaturas_SintesisAnual:202]P01_Minimo_Nota:55;$vs_GradesFormat)
				vs_NotaMaxSubject:=String:C10([Asignaturas_SintesisAnual:202]P01_Maximo_Nota:90;$vs_GradesFormat)
				vs_NotaAvgSubject:=String:C10([Asignaturas_SintesisAnual:202]P01_Promedio_Nota:26;$vs_GradesFormat)
				vs_PuntosMaxSubject:=String:C10([Asignaturas_SintesisAnual:202]P01_Minimo_Puntos:60;$vs_PointsFormat)
				vs_PuntosMinSubject:=String:C10([Asignaturas_SintesisAnual:202]P01_Minimo_Puntos:60;$vs_PointsFormat)
				vs_PuntosAvgSubject:=String:C10([Asignaturas_SintesisAnual:202]P01_Minimo_Puntos:60;$vs_PointsFormat)
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
				vs_NotaMinSubject:=String:C10([Asignaturas_SintesisAnual:202]P02_Minimo_Nota:56;$vs_GradesFormat)
				vs_NotaMaxSubject:=String:C10([Asignaturas_SintesisAnual:202]P02_Maximo_Nota:91;$vs_GradesFormat)
				vs_NotaAvgSubject:=String:C10([Asignaturas_SintesisAnual:202]P02_Promedio_Nota:31;$vs_GradesFormat)
				vs_PuntosMaxSubject:=String:C10([Asignaturas_SintesisAnual:202]P02_Minimo_Puntos:61;$vs_PointsFormat)
				vs_PuntosMinSubject:=String:C10([Asignaturas_SintesisAnual:202]P02_Minimo_Puntos:61;$vs_PointsFormat)
				vs_PuntosAvgSubject:=String:C10([Asignaturas_SintesisAnual:202]P02_Minimo_Puntos:61;$vs_PointsFormat)
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
				vs_NotaMinSubject:=String:C10([Asignaturas_SintesisAnual:202]P03_Minimo_Nota:57;$vs_GradesFormat)
				vs_NotaMaxSubject:=String:C10([Asignaturas_SintesisAnual:202]P03_Maximo_Nota:92;$vs_GradesFormat)
				vs_NotaAvgSubject:=String:C10([Asignaturas_SintesisAnual:202]P03_Promedio_Nota:36;$vs_GradesFormat)
				vs_PuntosMaxSubject:=String:C10([Asignaturas_SintesisAnual:202]P03_Minimo_Puntos:62;$vs_PointsFormat)
				vs_PuntosMinSubject:=String:C10([Asignaturas_SintesisAnual:202]P03_Minimo_Puntos:62;$vs_PointsFormat)
				vs_PuntosAvgSubject:=String:C10([Asignaturas_SintesisAnual:202]P03_Minimo_Puntos:62;$vs_PointsFormat)
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
				vs_NotaMinSubject:=String:C10([Asignaturas_SintesisAnual:202]P04_Minimo_Nota:58;$vs_GradesFormat)
				vs_NotaMaxSubject:=String:C10([Asignaturas_SintesisAnual:202]P04_Maximo_Nota:93;$vs_GradesFormat)
				vs_NotaAvgSubject:=String:C10([Asignaturas_SintesisAnual:202]P04_Promedio_Nota:41;$vs_GradesFormat)
				vs_PuntosMaxSubject:=String:C10([Asignaturas_SintesisAnual:202]P04_Minimo_Puntos:63;$vs_PointsFormat)
				vs_PuntosMinSubject:=String:C10([Asignaturas_SintesisAnual:202]P04_Minimo_Puntos:63;$vs_PointsFormat)
				vs_PuntosAvgSubject:=String:C10([Asignaturas_SintesisAnual:202]P04_Minimo_Puntos:63;$vs_PointsFormat)
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
				vs_NotaMinSubject:=String:C10([Asignaturas_SintesisAnual:202]P05_Minimo_Nota:59;$vs_GradesFormat)
				vs_NotaMaxSubject:=String:C10([Asignaturas_SintesisAnual:202]P05_Maximo_Nota:94;$vs_GradesFormat)
				vs_NotaAvgSubject:=String:C10([Asignaturas_SintesisAnual:202]P05_Promedio_Nota:46;$vs_GradesFormat)
				vr_PorcentajesMaxSubject:=[Asignaturas_SintesisAnual:202]P05_Minimo_Real:54
				vr_PorcentajesMinSubject:=[Asignaturas_SintesisAnual:202]P05_Maximo_Real:89
				vr_PorcentajesAvgSubject:=[Asignaturas_SintesisAnual:202]P05_Promedio_Real:45
				vs_PuntosMaxSubject:=String:C10([Asignaturas_SintesisAnual:202]P05_Minimo_Puntos:64;$vs_PointsFormat)
				vs_PuntosMinSubject:=String:C10([Asignaturas_SintesisAnual:202]P05_Minimo_Puntos:64;$vs_PointsFormat)
				vs_PuntosAvgSubject:=String:C10([Asignaturas_SintesisAnual:202]P05_Minimo_Puntos:64;$vs_PointsFormat)
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
		For ($i;1;12;5)
			$pct:=Field:C253($tableNumber;$nextField)->
			If ($pct<rPctMinimum)
				aSRpTextColorsPointers{$i}->:="Red"
			Else 
				aSRpTextColorsPointers{$i}->:="Blue"
			End if 
			aSRpDefaultModePointers{$i}->:=Field:C253($tableNumber;$nextField+4)->
			aSRpNotasPointers{$i}->:=String:C10(Field:C253($tableNumber;$nextField+1)->;$vs_GradesFormat)
			aSRpPuntosPointers{$i}->:=String:C10(Field:C253($tableNumber;$nextField+2)->;$vs_PointsFormat)
			aSRpSimbolosPointers{$i}->:=Field:C253($tableNumber;$nextField+3)->
			aSRpIndicadoresPointers{$i}->:=_Evaluacion_a_Indicador ($pct)
			aSRpPorcentajesPointers{$i}->:=Round:C94($pct;1)
			$nextField:=$nextField+5
		End for 
		
		  // Nota de presentacion
		If ([Alumnos_Calificaciones:208]PeriodoActual_Present_Real:477<rPctMinimum)
			vs_TextColorPresentacion:="Red"
		Else 
			vs_TextColorPresentacion:="Blue"
		End if 
		vs_EvaluacionPresentacion:=[Alumnos_Calificaciones:208]PeriodoActual_Present_Literal:481
		vs_NotaPresentacion:=String:C10([Alumnos_Calificaciones:208]PeriodoActual_Present_Nota:478;$vs_GradesFormat)
		vs_puntosPresentacion:=String:C10([Alumnos_Calificaciones:208]PeriodoActual_Present_Puntos:479;$vs_PointsFormat)
		vs_SimbolosPresentacion:=[Alumnos_Calificaciones:208]PeriodoActual_Present_Simbolo:480
		vs_IndicadorPresentacion:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]PeriodoActual_Present_Real:477)
		vr_PorcentajePresentacion:=Round:C94([Alumnos_Calificaciones:208]PeriodoActual_Present_Real:477;1)
		
		  // control de periodo
		If ([Alumnos_Calificaciones:208]PeriodoActual_Control_Real:482<rPctMinimum)
			vs_TextColorEXP:="Red"
		Else 
			vs_TextColorEXP:="Blue"
		End if 
		vs_EvaluacionEXP:=[Alumnos_Calificaciones:208]PeriodoActual_Control_Literal:486
		vs_NotaEXP:=String:C10([Alumnos_Calificaciones:208]PeriodoActual_Control_Nota:483;$vs_GradesFormat)
		vs_puntosEXP:=String:C10([Alumnos_Calificaciones:208]PeriodoActual_Control_Puntos:484;$vs_PointsFormat)
		vs_SimbolosEXP:=[Alumnos_Calificaciones:208]PeriodoActual_Control_Simbolo:485
		vs_IndicadorEXP:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]PeriodoActual_Present_Real:477)
		vr_PorcentajeEXP:=Round:C94([Alumnos_Calificaciones:208]PeriodoActual_Control_Real:482;1)
		
		  // Promedio Periodo
		If ([Alumnos_Calificaciones:208]PeriodoActual_Final_Real:487<rPctMinimum)
			vs_TextColorPromedioPeriodo:="Red"
		Else 
			vs_TextColorPromedioPeriodo:="Blue"
		End if 
		vs_EvaluacionPromedioPeriodo:=[Alumnos_Calificaciones:208]PeriodoActual_Final_Literal:491
		vs_NotaPromedioPeriodo:=String:C10([Alumnos_Calificaciones:208]PeriodoActual_Final_Nota:488;$vs_GradesFormat)
		vs_puntosPromedioPeriodo:=String:C10([Alumnos_Calificaciones:208]PeriodoActual_Final_Puntos:489;$vs_PointsFormat)
		vs_SimbolosPromedioPeriodo:=[Alumnos_Calificaciones:208]PeriodoActual_Final_Simbolo:490
		vs_IndicadorPromedioPeriodo:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]PeriodoActual_Final_Real:487)
		vr_PorcentajePromedioPeriodo:=Round:C94([Alumnos_Calificaciones:208]PeriodoActual_Final_Real:487;1)
		
		  //  ========================================================
		
		
		  // =================FINALES DEL PERIODO 1=================
		  // presentacion
		If ([Alumnos_Calificaciones:208]P01_Presentacion_Real:102<rPctMinimum)
			vs_TextColorPresentacionP1:="Red"
		Else 
			vs_TextColorPresentacionP1:="Blue"
		End if 
		
		vs_EvaluacionPresentacionP1:=[Alumnos_Calificaciones:208]P01_Presentacion_Literal:106
		vs_NotaPresentacionP1:=String:C10([Alumnos_Calificaciones:208]P01_Presentacion_Nota:103;$vs_GradesFormat)
		vs_puntosPresentacionP1:=String:C10([Alumnos_Calificaciones:208]P01_Presentacion_Puntos:104;$vs_PointsFormat)
		vs_SimbolosPresentacionP1:=[Alumnos_Calificaciones:208]P01_Presentacion_Simbolo:105
		vs_IndicadorPresentacionP1:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P01_Presentacion_Real:102)
		vr_PorcentajePresentacionP1:=Round:C94([Alumnos_Calificaciones:208]P01_Presentacion_Real:102;1)
		
		  // control fin de periodo
		If ([Alumnos_Calificaciones:208]P01_Control_Real:107<rPctMinimum)
			vs_TextColorEXP1:="Red"
		Else 
			vs_TextColorEXP1:="Blue"
		End if 
		vs_EvaluacionEXP1:=[Alumnos_Calificaciones:208]P01_Control_Literal:111
		vs_NotaEXP1:=String:C10([Alumnos_Calificaciones:208]P01_Control_Nota:108;$vs_GradesFormat)
		vs_puntosEXP1:=String:C10([Alumnos_Calificaciones:208]P01_Control_Puntos:109;$vs_PointsFormat)
		vs_SimbolosEXP1:=[Alumnos_Calificaciones:208]P01_Control_Simbolo:110
		vs_IndicadorEXP1:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P01_Control_Real:107)
		vr_PorcentajeEXP1:=Round:C94([Alumnos_Calificaciones:208]P01_Control_Real:107;1)
		
		  // promedio periodo
		If ([Alumnos_Calificaciones:208]P01_Final_Real:112<rPctMinimum)
			vs_TextColorPromedio1:="Red"
		Else 
			vs_TextColorPromedio1:="Blue"
		End if 
		vs_EvaluacionPromedio1:=[Alumnos_Calificaciones:208]P01_Final_Literal:116
		vs_NotaPromedio1:=String:C10([Alumnos_Calificaciones:208]P01_Final_Nota:113;$vs_GradesFormat)
		vs_puntosPromedio1:=String:C10([Alumnos_Calificaciones:208]P01_Final_Puntos:114;$vs_PointsFormat)
		vs_SimbolosPromedio1:=[Alumnos_Calificaciones:208]P01_Final_Simbolo:115
		vs_IndicadorPromedio1:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P01_Final_Real:112)
		vr_PorcentajePromedio1:=Round:C94([Alumnos_Calificaciones:208]P01_Final_Real:112;1)
		vt_Esfuerzo_P1:=[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16
		
		
		
		  // =================FINALES DEL PERIODO 2=================
		  // presentacion
		If ([Alumnos_Calificaciones:208]P02_Presentacion_Real:177<rPctMinimum)
			vs_TextColorPresentacionP2:="Red"
		Else 
			vs_TextColorPresentacionP2:="Blue"
		End if 
		
		vs_EvaluacionPresentacionP2:=[Alumnos_Calificaciones:208]P02_Presentacion_Literal:181
		vs_NotaPresentacionP2:=String:C10([Alumnos_Calificaciones:208]P02_Presentacion_Nota:178;$vs_GradesFormat)
		vs_puntosPresentacionP2:=String:C10([Alumnos_Calificaciones:208]P02_Presentacion_Puntos:179;$vs_PointsFormat)
		vs_SimbolosPresentacionP2:=[Alumnos_Calificaciones:208]P02_Presentacion_Simbolo:180
		vs_IndicadorPresentacionP2:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P02_Presentacion_Real:177)
		vr_PorcentajePresentacionP2:=Round:C94([Alumnos_Calificaciones:208]P02_Presentacion_Real:177;1)
		
		  // control fin de periodo
		If ([Alumnos_Calificaciones:208]P02_Control_Real:182<rPctMinimum)
			vs_TextColorEXP2:="Red"
		Else 
			vs_TextColorEXP2:="Blue"
		End if 
		vs_EvaluacionEXP2:=[Alumnos_Calificaciones:208]P02_Control_Literal:186
		vs_NotaEXP2:=String:C10([Alumnos_Calificaciones:208]P02_Control_Nota:183;$vs_GradesFormat)
		vs_puntosEXP2:=String:C10([Alumnos_Calificaciones:208]P02_Control_Puntos:184;$vs_PointsFormat)
		vs_SimbolosEXP2:=[Alumnos_Calificaciones:208]P02_Control_Simbolo:185
		vs_IndicadorEXP2:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P02_Control_Real:182)
		vr_PorcentajeEXP2:=Round:C94([Alumnos_Calificaciones:208]P02_Control_Real:182;1)
		
		  // promedio periodo
		If ([Alumnos_Calificaciones:208]P02_Final_Real:187<rPctMinimum)
			vs_TextColorPromedio2:="Red"
		Else 
			vs_TextColorPromedio2:="Blue"
		End if 
		vs_EvaluacionPromedio2:=[Alumnos_Calificaciones:208]P02_Final_Literal:191
		vs_NotaPromedio2:=String:C10([Alumnos_Calificaciones:208]P02_Final_Nota:188;$vs_GradesFormat)
		vs_puntosPromedio2:=String:C10([Alumnos_Calificaciones:208]P02_Final_Puntos:189;$vs_PointsFormat)
		vs_SimbolosPromedio2:=[Alumnos_Calificaciones:208]P02_Final_Simbolo:190
		vs_IndicadorPromedio2:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P02_Final_Real:187)
		vr_PorcentajePromedio2:=Round:C94([Alumnos_Calificaciones:208]P02_Final_Real:187;1)
		vt_Esfuerzo_P2:=[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21
		
		
		  // =================FINALES DEL PERIODO 3=================
		  // presentacion
		If ([Alumnos_Calificaciones:208]P03_Presentacion_Real:252<rPctMinimum)
			vs_TextColorPresentacionP3:="Red"
		Else 
			vs_TextColorPresentacionP3:="Blue"
		End if 
		
		vs_EvaluacionPresentacionP3:=[Alumnos_Calificaciones:208]P03_Presentacion_Literal:256
		vs_NotaPresentacionP3:=String:C10([Alumnos_Calificaciones:208]P03_Presentacion_Nota:253;$vs_GradesFormat)
		vs_puntosPresentacionP3:=String:C10([Alumnos_Calificaciones:208]P03_Presentacion_Puntos:254;$vs_PointsFormat)
		vs_SimbolosPresentacionP3:=[Alumnos_Calificaciones:208]P03_Presentacion_Simbolo:255
		vs_IndicadorPresentacionP3:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P03_Presentacion_Real:252)
		vr_PorcentajePresentacionP3:=Round:C94([Alumnos_Calificaciones:208]P03_Presentacion_Real:252;1)
		
		  // control fin de periodo
		If ([Alumnos_Calificaciones:208]P03_Control_Real:257<rPctMinimum)
			vs_TextColorEXP3:="Red"
		Else 
			vs_TextColorEXP3:="Blue"
		End if 
		vs_EvaluacionEXP3:=[Alumnos_Calificaciones:208]P03_Control_Literal:261
		vs_NotaEXP3:=String:C10([Alumnos_Calificaciones:208]P03_Control_Nota:258;$vs_GradesFormat)
		vs_puntosEXP3:=String:C10([Alumnos_Calificaciones:208]P03_Control_Puntos:259;$vs_PointsFormat)
		vs_SimbolosEXP3:=[Alumnos_Calificaciones:208]P03_Control_Simbolo:260
		vs_IndicadorEXP3:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P03_Control_Real:257)
		vr_PorcentajeEXP3:=Round:C94([Alumnos_Calificaciones:208]P03_Control_Real:257;1)
		
		  // promedio periodo
		If ([Alumnos_Calificaciones:208]P03_Final_Real:262<rPctMinimum)
			vs_TextColorPromedio3:="Red"
		Else 
			vs_TextColorPromedio3:="Blue"
		End if 
		vs_EvaluacionPromedio3:=[Alumnos_Calificaciones:208]P03_Final_Literal:266
		vs_NotaPromedio3:=String:C10([Alumnos_Calificaciones:208]P03_Final_Nota:263;$vs_GradesFormat)
		vs_puntosPromedio3:=String:C10([Alumnos_Calificaciones:208]P03_Final_Puntos:264;$vs_PointsFormat)
		vs_SimbolosPromedio3:=[Alumnos_Calificaciones:208]P03_Final_Simbolo:265
		vs_IndicadorPromedio3:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P03_Final_Real:262)
		vr_PorcentajePromedio3:=Round:C94([Alumnos_Calificaciones:208]P03_Final_Real:262;1)
		vt_Esfuerzo_P3:=[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26
		
		
		  // =================FINALES DEL PERIODO 4=================
		  // presentacion
		If ([Alumnos_Calificaciones:208]P04_Presentacion_Real:327<rPctMinimum)
			vs_TextColorPresentacionP4:="Red"
		Else 
			vs_TextColorPresentacionP4:="Blue"
		End if 
		
		vs_EvaluacionPresentacionP4:=[Alumnos_Calificaciones:208]P04_Presentacion_Literal:331
		vs_NotaPresentacionP4:=String:C10([Alumnos_Calificaciones:208]P04_Presentacion_Nota:328;$vs_GradesFormat)
		vs_puntosPresentacionP4:=String:C10([Alumnos_Calificaciones:208]P04_Presentacion_Puntos:329;$vs_PointsFormat)
		vs_SimbolosPresentacionP4:=[Alumnos_Calificaciones:208]P04_Presentacion_Simbolo:330
		vs_IndicadorPresentacionP4:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P04_Presentacion_Real:327)
		vr_PorcentajePresentacionP4:=Round:C94([Alumnos_Calificaciones:208]P04_Presentacion_Real:327;1)
		
		  // control fin de periodo
		If ([Alumnos_Calificaciones:208]P04_Control_Real:332<rPctMinimum)
			vs_TextColorEXP4:="Red"
		Else 
			vs_TextColorEXP4:="Blue"
		End if 
		vs_EvaluacionEXP4:=[Alumnos_Calificaciones:208]P04_Control_Literal:336
		vs_NotaEXP4:=String:C10([Alumnos_Calificaciones:208]P04_Control_Nota:333;$vs_GradesFormat)
		vs_puntosEXP4:=String:C10([Alumnos_Calificaciones:208]P04_Control_Puntos:334;$vs_PointsFormat)
		vs_SimbolosEXP4:=[Alumnos_Calificaciones:208]P04_Control_Simbolo:335
		vs_IndicadorEXP4:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P04_Control_Real:332)
		vr_PorcentajeEXP4:=Round:C94([Alumnos_Calificaciones:208]P04_Control_Real:332;1)
		
		  // promedio periodo
		If ([Alumnos_Calificaciones:208]P04_Final_Real:337<rPctMinimum)
			vs_TextColorPromedio4:="Red"
		Else 
			vs_TextColorPromedio4:="Blue"
		End if 
		vs_EvaluacionPromedio4:=[Alumnos_Calificaciones:208]P04_Final_Literal:341
		vs_NotaPromedio4:=String:C10([Alumnos_Calificaciones:208]P04_Final_Nota:338;$vs_GradesFormat)
		vs_puntosPromedio4:=String:C10([Alumnos_Calificaciones:208]P04_Final_Puntos:339;$vs_PointsFormat)
		vs_SimbolosPromedio4:=[Alumnos_Calificaciones:208]P04_Final_Simbolo:340
		vs_IndicadorPromedio4:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P04_Final_Real:337)
		vr_PorcentajePromedio4:=Round:C94([Alumnos_Calificaciones:208]P04_Final_Real:337;1)
		vt_Esfuerzo_P4:=[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16
		
		
		  // =================FINALES DEL PERIODO 5=================
		  // presentacion
		If ([Alumnos_Calificaciones:208]P05_Presentacion_Real:402<rPctMinimum)
			vs_TextColorPresentacionP5:="Red"
		Else 
			vs_TextColorPresentacionP5:="Blue"
		End if 
		
		vs_EvaluacionPresentacionP5:=[Alumnos_Calificaciones:208]P05_Presentacion_Literal:406
		vs_NotaPresentacionP5:=String:C10([Alumnos_Calificaciones:208]P05_Presentacion_Nota:403;$vs_GradesFormat)
		vs_puntosPresentacionP5:=String:C10([Alumnos_Calificaciones:208]P05_Presentacion_Puntos:404;$vs_PointsFormat)
		vs_SimbolosPresentacionP5:=[Alumnos_Calificaciones:208]P05_Presentacion_Simbolo:405
		vs_IndicadorPresentacionP5:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P05_Presentacion_Real:402)
		vr_PorcentajePresentacionP5:=Round:C94([Alumnos_Calificaciones:208]P05_Presentacion_Real:402;1)
		
		  // control fin de periodo
		If ([Alumnos_Calificaciones:208]P05_Control_Real:407<rPctMinimum)
			vs_TextColorEXP5:="Red"
		Else 
			vs_TextColorEXP5:="Blue"
		End if 
		vs_EvaluacionEXP5:=[Alumnos_Calificaciones:208]P05_Control_Literal:411
		vs_NotaEXP5:=String:C10([Alumnos_Calificaciones:208]P05_Control_Nota:408;$vs_GradesFormat)
		vs_puntosEXP5:=String:C10([Alumnos_Calificaciones:208]P05_Control_Puntos:409;$vs_PointsFormat)
		vs_SimbolosEXP5:=[Alumnos_Calificaciones:208]P05_Control_Simbolo:410
		vs_IndicadorEXP5:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P05_Control_Real:407)
		vr_PorcentajeEXP5:=Round:C94([Alumnos_Calificaciones:208]P05_Control_Real:407;1)
		
		  // promedio periodo
		If ([Alumnos_Calificaciones:208]P05_Final_Real:412<rPctMinimum)
			vs_TextColorPromedio5:="Red"
		Else 
			vs_TextColorPromedio5:="Blue"
		End if 
		vs_EvaluacionPromedio5:=[Alumnos_Calificaciones:208]P05_Final_Literal:416
		vs_NotaPromedio5:=String:C10([Alumnos_Calificaciones:208]P05_Final_Nota:413;$vs_GradesFormat)
		vs_puntosPromedio5:=String:C10([Alumnos_Calificaciones:208]P05_Final_Puntos:414;$vs_PointsFormat)
		vs_SimbolosPromedio5:=[Alumnos_Calificaciones:208]P05_Final_Simbolo:415
		vs_IndicadorPromedio5:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]P05_Final_Real:412)
		vr_PorcentajePromedio5:=Round:C94([Alumnos_Calificaciones:208]P05_Final_Real:412;1)
		vt_Esfuerzo_P5:=[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16
		  //-------------------------    
		
		
		
		If ([Alumnos_Calificaciones:208]Anual_Real:11<rPctMinimum)
			vs_TextColorPromedioFinal:="Red"
		Else 
			vs_TextColorPromedioFinal:="Blue"
		End if 
		vs_EvaluacionPromedioFinal:=[Alumnos_Calificaciones:208]Anual_Literal:15
		vs_NotaPromedioFinal:=String:C10([Alumnos_Calificaciones:208]Anual_Nota:12;$vs_GradesFormat)
		vs_puntosPromedioFinal:=String:C10([Alumnos_Calificaciones:208]Anual_Nota:12;$vs_PointsFormat)
		vs_SimbolosPromedioFinal:=[Alumnos_Calificaciones:208]Anual_Simbolo:14
		vs_IndicadorPromedioFinal:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]Anual_Real:11)
		vr_PorcentajePromedioFinal:=Round:C94([Alumnos_Calificaciones:208]Anual_Real:11;1)
		
		If ([Alumnos_Calificaciones:208]ExamenAnual_Real:16<rPctMinimum)
			vs_TextColorExamen:="Red"
		Else 
			vs_TextColorExamen:="Blue"
		End if 
		vs_EvaluacionExamen:=[Alumnos_Calificaciones:208]ExamenAnual_Literal:20
		vs_NotaExamen:=String:C10([Alumnos_Calificaciones:208]ExamenAnual_Nota:17;$vs_GradesFormat)
		vs_puntosExamen:=String:C10([Alumnos_Calificaciones:208]ExamenAnual_Puntos:18;$vs_PointsFormat)
		vs_SimbolosExamen:=[Alumnos_Calificaciones:208]ExamenAnual_Simbolo:19
		vs_IndicadorExamen:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]ExamenAnual_Real:16)
		vr_PorcentajeExamen:=Round:C94([Alumnos_Calificaciones:208]ExamenAnual_Real:16;1)
		
		If ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26<rPctMinimum)
			vs_TextColorFinal:="Red"
		Else 
			vs_TextColorFinal:="Blue"
		End if 
		vs_EvaluacionFinal:=[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
		vs_NotaFinal:=String:C10([Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;$vs_GradesFormat)
		vs_puntosFinal:=String:C10([Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28;$vs_PointsFormat)
		vs_SimbolosFinal:=_Evaluacion_a_Simbolos ($pct)
		vs_IndicadorFinal:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26)
		vr_PorcentajeFinal:=Round:C94([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;1)
		
		READ ONLY:C145([xxSTR_Niveles:6])
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Asignaturas:18]Numero_del_Nivel:6)
		EVS_ReadStyleData ([xxSTR_Niveles:6]EvStyle_oficial:23)
		If ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32<rPctMinimum)
			vs_TextColorFinalOficialG:="Red"
		Else 
			vs_TextColorFinalOficialG:="Blue"
		End if 
		vs_EvaluacionOficial:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36
		vs_NotaOficial:=String:C10([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;$vs_GradesFormat)
		vs_puntosOficial:=String:C10([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34;$vs_PointsFormat)
		vs_SimbolosOficial:=[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35
		vs_IndicadorOficial:=_Evaluacion_a_Indicador ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32)
		vr_PorcentajeOficial:=Round:C94([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;1)
		
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
		vs_NotaMinSubjectF:=String:C10([Asignaturas_SintesisAnual:202]Final_Minimo_Nota:81;$vs_GradesFormat)
		vs_NotaMaxSubjectF:=String:C10([Asignaturas_SintesisAnual:202]Final_Maximo_Nota:116;$vs_GradesFormat)
		vs_NotaAvgSubjectF:=String:C10([Asignaturas_SintesisAnual:202]PromedioAnual_Nota:11;$vs_GradesFormat)
		vs_PuntosMaxSubjectF:=String:C10([Asignaturas_SintesisAnual:202]Final_Minimo_Puntos:82;$vs_PointsFormat)
		vs_PuntosMinSubjectF:=String:C10([Asignaturas_SintesisAnual:202]Final_Maximo_Puntos:117;$vs_PointsFormat)
		vs_PuntosAvgSubjectF:=String:C10([Asignaturas_SintesisAnual:202]PromedioFinal_Puntos:17;$vs_PointsFormat)
		vs_PorcentajesMaxSubjectF:=String:C10(Round:C94([Asignaturas_SintesisAnual:202]Final_Maximo_Real:115;1))
		vs_PorcentajesMinSubjectF:=String:C10(Round:C94([Asignaturas_SintesisAnual:202]Final_Minimo_Real:80;1))
		vs_PorcentajesAvgSubjectF:=String:C10(Round:C94([Asignaturas_SintesisAnual:202]PromedioFinal_Real:15;1))
		vs_SimbolosMaxSubjectF:=NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]Final_Maximo_Real:115;Simbolos)
		vs_SimbolosMinSubjectF:=NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]Final_Minimo_Real:80;Simbolos)
		vs_SimbolosAvgSubjectF:=NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]PromedioFinal_Real:15;Simbolos)
		iConversionTable:=$conversionTable
		
		vsPromedioSubEval_1:=""
		vsPromedioSubEval_2:=""
		vsPromedioSubEval_3:=""
		vsPromedioSubEval_4:=""
		vsPromedioSubEval_5:=""
		vsPromedioSubEval_6:=""
		vsPromedioSubEval_7:=""
		vsPromedioSubEval_8:=""
		vsPromedioSubEval_9:=""
		vsPromedioSubEval_10:=""
		vsPromedioSubEval_11:=""
		vsPromedioSubEval_12:=""
		
		ASsev_InitArrays 
		EV2_InitArrays (0)
		Case of 
			: ($detail>0)
				SRal_ResizeSubEvalArrays (0)
				$size:=0
				$tableNumber:=Table:C252(->[Alumnos_Calificaciones:208])
				$nextFieldP1:=Field:C253(->[Alumnos_Calificaciones:208]PeriodoActual_Eval01_Real:417)
				$nextFieldP2:=Field:C253(->[Alumnos_Calificaciones:208]PeriodoActual_Eval02_Real:422)
				$nextFieldP3:=Field:C253(->[Alumnos_Calificaciones:208]PeriodoActual_Eval03_Real:427)
				$nextFieldP4:=Field:C253(->[Alumnos_Calificaciones:208]PeriodoActual_Eval04_Real:432)
				$nextFieldP5:=Field:C253(->[Alumnos_Calificaciones:208]PeriodoActual_Eval05_Real:437)
				For ($parciales;1;Size of array:C274(alAS_EvalPropSourceID))
					If (abAS_EvalPropPrintDetail{$parciales})
						$size:=$size+1
						SRal_ResizeSubEvalArrays ($size)
						atSRal_SubEvalName{$size}:=atAS_EvalPropPrintName{$parciales}
						arSRal_SubEvalCoeff{$size}:=arAS_EvalPropPonderacion{$parciales}
						Case of 
							: (alAS_EvalPropSourceID{$parciales}=0)
								atSRal_SubEval1_Eval{$size}:=Get pointer:C304("VS_Evaluacion"+String:C10($parciales))->
								atSRal_SubEval1_Nota{$size}:=Get pointer:C304("VS_Nota"+String:C10($parciales))->
								atSRal_SubEval1_Puntos{$size}:=Get pointer:C304("VS_Puntos"+String:C10($parciales))->
								atSRal_SubEval1_Simbolos{$size}:=Get pointer:C304("VS_Simbolos"+String:C10($parciales))->
								atSRal_SubEval1_Porcentajes{$size}:=String:C10(Get pointer:C304("VR_Porcentaje"+String:C10($parciales))->;"##0,0")
								atSRal_SubEval1_Indicadores{$size}:=Get pointer:C304("VS_Indicador"+String:C10($parciales))->
								
								$pct:=Field:C253($tableNumber;$nextFieldP1)->
								atSRal_SubEvalP1_Eval{$size}:=Field:C253($tableNumber;$nextFieldP1+4)->
								atSRal_SubEvalP1_Nota{$size}:=String:C10(Field:C253($tableNumber;$nextFieldP1+1)->;$vs_GradesFormat)
								atSRal_SubEvalP1_Puntos{$size}:=String:C10(Field:C253($tableNumber;$nextFieldP1+2)->;$vs_PointsFormat)
								atSRal_SubEvalP1_Simbolos{$size}:=Field:C253($tableNumber;$nextFieldP1+3)->
								atSRal_SubEvalP1_Indicadores{$size}:=_Evaluacion_a_Indicador ($pct;0)
								atSRal_SubEvalP1_Porcentajes{$size}:=String:C10($pct;vs_PercentFormat)
								
								$pct:=Field:C253($tableNumber;$nextFieldP2)->
								atSRal_SubEvalP2_Eval{$size}:=Field:C253($tableNumber;$nextFieldP2+4)->
								atSRal_SubEvalP2_Nota{$size}:=String:C10(Field:C253($tableNumber;$nextFieldP2+1)->;$vs_GradesFormat)
								atSRal_SubEvalP2_Puntos{$size}:=String:C10(Field:C253($tableNumber;$nextFieldP2+2)->;$vs_PointsFormat)
								atSRal_SubEvalP2_Simbolos{$size}:=Field:C253($tableNumber;$nextFieldP2+3)->
								atSRal_SubEvalP2_Indicadores{$size}:=_Evaluacion_a_Indicador ($pct;0)
								atSRal_SubEvalP2_Porcentajes{$size}:=String:C10($pct;vs_PercentFormat)
								
								$pct:=Field:C253($tableNumber;$nextFieldP3)->
								atSRal_SubEvalP3_Eval{$size}:=Field:C253($tableNumber;$nextFieldP3+4)->
								atSRal_SubEvalP3_Nota{$size}:=String:C10(Field:C253($tableNumber;$nextFieldP3+1)->;$vs_GradesFormat)
								atSRal_SubEvalP3_Puntos{$size}:=String:C10(Field:C253($tableNumber;$nextFieldP3+2)->;$vs_PointsFormat)
								atSRal_SubEvalP3_Simbolos{$size}:=Field:C253($tableNumber;$nextFieldP3+3)->
								atSRal_SubEvalP3_Indicadores{$size}:=_Evaluacion_a_Indicador ($pct;0)
								atSRal_SubEvalP3_Porcentajes{$size}:=String:C10($pct;vs_PercentFormat)
								
								$pct:=Field:C253($tableNumber;$nextFieldP4)->
								atSRal_SubEvalP4_Eval{$size}:=Field:C253($tableNumber;$nextFieldP4+4)->
								atSRal_SubEvalP4_Nota{$size}:=String:C10(Field:C253($tableNumber;$nextFieldP4+1)->;$vs_GradesFormat)
								atSRal_SubEvalP4_Puntos{$size}:=String:C10(Field:C253($tableNumber;$nextFieldP4+2)->;$vs_PointsFormat)
								atSRal_SubEvalP4_Simbolos{$size}:=Field:C253($tableNumber;$nextFieldP4+3)->
								atSRal_SubEvalP4_Indicadores{$size}:=_Evaluacion_a_Indicador ($pct;0)
								atSRal_SubEvalP4_Porcentajes{$size}:=String:C10($pct;vs_PercentFormat)
								
								$pct:=Field:C253($tableNumber;$nextFieldP5)->
								atSRal_SubEvalP5_Eval{$size}:=Field:C253($tableNumber;$nextFieldP5+4)->
								atSRal_SubEvalP5_Nota{$size}:=String:C10(Field:C253($tableNumber;$nextFieldP5+1)->;$vs_GradesFormat)
								atSRal_SubEvalP5_Puntos{$size}:=String:C10(Field:C253($tableNumber;$nextFieldP5+2)->;$vs_PointsFormat)
								atSRal_SubEvalP5_Simbolos{$size}:=Field:C253($tableNumber;$nextFieldP5+3)->
								atSRal_SubEvalP5_Indicadores{$size}:=_Evaluacion_a_Indicador ($pct;0)
								atSRal_SubEvalP5_Porcentajes{$size}:=String:C10($pct;vs_PercentFormat)
								
								
							: (alAS_EvalPropSourceID{$parciales}<0)
								$refSubAsignatura:=String:C10([Asignaturas:18]Numero:1)+"."+String:C10($periodo)+"."+String:C10($parciales)
								SRal_NotasSubAsignaturas ($refSubAsignatura;$size;[Alumnos:2]numero:1)
								
								atSRal_SubEval1_Eval{$size}:=Get pointer:C304("VS_Evaluacion"+String:C10($parciales))->
								atSRal_SubEval1_Nota{$size}:=Get pointer:C304("VS_Nota"+String:C10($parciales))->
								atSRal_SubEval1_Puntos{$size}:=Get pointer:C304("VS_Puntos"+String:C10($parciales))->
								atSRal_SubEval1_Simbolos{$size}:=Get pointer:C304("VS_Simbolos"+String:C10($parciales))->
								atSRal_SubEval1_Porcentajes{$size}:=String:C10(Get pointer:C304("VR_Porcentaje"+String:C10($parciales))->;"##0,0")
								atSRal_SubEval1_Indicadores{$size}:=Get pointer:C304("VS_Indicador"+String:C10($parciales))->
								
								$pct:=Field:C253($tableNumber;$nextFieldP1)->
								atSRal_SubEvalP1_Eval{$size}:=Field:C253($tableNumber;$nextFieldP1+4)->
								atSRal_SubEvalP1_Nota{$size}:=String:C10(Field:C253($tableNumber;$nextFieldP1+1)->;$vs_GradesFormat)
								atSRal_SubEvalP1_Puntos{$size}:=String:C10(Field:C253($tableNumber;$nextFieldP1+2)->;$vs_PointsFormat)
								atSRal_SubEvalP1_Simbolos{$size}:=Field:C253($tableNumber;$nextFieldP1+3)->
								atSRal_SubEvalP1_Indicadores{$size}:=_Evaluacion_a_Indicador ($pct;0)
								atSRal_SubEvalP1_Porcentajes{$size}:=String:C10($pct;vs_PercentFormat)
								
								$pct:=Field:C253($tableNumber;$nextFieldP2)->
								atSRal_SubEvalP2_Eval{$size}:=Field:C253($tableNumber;$nextFieldP2+4)->
								atSRal_SubEvalP2_Nota{$size}:=String:C10(Field:C253($tableNumber;$nextFieldP2+1)->;$vs_GradesFormat)
								atSRal_SubEvalP2_Puntos{$size}:=String:C10(Field:C253($tableNumber;$nextFieldP2+2)->;$vs_PointsFormat)
								atSRal_SubEvalP2_Simbolos{$size}:=Field:C253($tableNumber;$nextFieldP2+3)->
								atSRal_SubEvalP2_Indicadores{$size}:=_Evaluacion_a_Indicador ($pct;0)
								atSRal_SubEvalP2_Porcentajes{$size}:=String:C10($pct;vs_PercentFormat)
								
								$pct:=Field:C253($tableNumber;$nextFieldP3)->
								atSRal_SubEvalP3_Eval{$size}:=Field:C253($tableNumber;$nextFieldP3+4)->
								atSRal_SubEvalP3_Nota{$size}:=String:C10(Field:C253($tableNumber;$nextFieldP3+1)->;$vs_GradesFormat)
								atSRal_SubEvalP3_Puntos{$size}:=String:C10(Field:C253($tableNumber;$nextFieldP3+2)->;$vs_PointsFormat)
								atSRal_SubEvalP3_Simbolos{$size}:=Field:C253($tableNumber;$nextFieldP3+3)->
								atSRal_SubEvalP3_Indicadores{$size}:=_Evaluacion_a_Indicador ($pct;0)
								atSRal_SubEvalP3_Porcentajes{$size}:=String:C10($pct;vs_PercentFormat)
								
								$pct:=Field:C253($tableNumber;$nextFieldP4)->
								atSRal_SubEvalP4_Eval{$size}:=Field:C253($tableNumber;$nextFieldP4+4)->
								atSRal_SubEvalP4_Nota{$size}:=String:C10(Field:C253($tableNumber;$nextFieldP4+1)->;$vs_GradesFormat)
								atSRal_SubEvalP4_Puntos{$size}:=String:C10(Field:C253($tableNumber;$nextFieldP4+2)->;$vs_PointsFormat)
								atSRal_SubEvalP4_Simbolos{$size}:=Field:C253($tableNumber;$nextFieldP4+3)->
								atSRal_SubEvalP4_Indicadores{$size}:=_Evaluacion_a_Indicador ($pct;0)
								atSRal_SubEvalP4_Porcentajes{$size}:=String:C10($pct;vs_PercentFormat)
								
								$pct:=Field:C253($tableNumber;$nextFieldP5)->
								atSRal_SubEvalP5_Eval{$size}:=Field:C253($tableNumber;$nextFieldP5+4)->
								atSRal_SubEvalP5_Nota{$size}:=String:C10(Field:C253($tableNumber;$nextFieldP5+1)->;$vs_GradesFormat)
								atSRal_SubEvalP5_Puntos{$size}:=String:C10(Field:C253($tableNumber;$nextFieldP5+2)->;$vs_PointsFormat)
								atSRal_SubEvalP5_Simbolos{$size}:=Field:C253($tableNumber;$nextFieldP5+3)->
								atSRal_SubEvalP5_Indicadores{$size}:=_Evaluacion_a_Indicador ($pct;0)
								atSRal_SubEvalP5_Porcentajes{$size}:=String:C10($pct;vs_PercentFormat)
								
								
							: (alAS_EvalPropSourceID{$parciales}>0)
								$result:=SRal_NotasAsigConsolidables (alAS_EvalPropSourceID{$parciales};$periodo;$size;$estiloPropioEnHijas)
								If ($result=0)
									$size:=$size-1
									SRal_ResizeSubEvalArrays ($size)
								End if 
						End case 
					End if 
					$nextFieldP1:=$nextFieldP1+5
					$nextFieldP2:=$nextFieldP2+5
					$nextFieldP3:=$nextFieldP3+5
					$nextFieldP4:=$nextFieldP4+5
					$nextFieldP5:=$nextFieldP5+5
				End for 
		End case 
		
		
		vs_PromedioG_Periodo:=[Alumnos_SintesisAnual:210]P00_Promedio_Literal:67
		vs_ObservacionesPeriodoG:=[Alumnos_SintesisAnual:210]P00_Observaciones_Academicas:85
		
		If (vs_PromedioG_Periodo=(Char:C90(0)+"@"))
			vs_TextColorG_Periodo:="Red"
			vs_PromedioG_Periodo:=Substring:C12(vs_PromedioG_Periodo;2)
		Else 
			vs_TextColorG_Periodo:="Blue"
		End if 
		
		If (vs_PromedioG_PS=(Char:C90(0)+"@"))
			vs_TextColorG_PS:="Red"
			vs_PromedioG_PS:=Substring:C12(vs_PromedioG_PS;2)
		Else 
			vs_TextColorG_PS:="Blue"
		End if 
		
		vs_Observaciones1G:=[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
		vs_Observaciones2G:=[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
		vs_Observaciones3G:=[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
		vs_Observaciones4G:=[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34
		vs_Observaciones5G:=[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39
		vtSRal_ComentariosFinal:=[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46
		
		RELATE ONE:C42([Alumnos:2]curso:20)
		RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)
		vt_profesorJefe:=[Profesores:4]Nombre_comun:21
End case 

