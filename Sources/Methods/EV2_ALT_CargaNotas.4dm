//%attributes = {}
  // Método: EV2_ALT_CargaNotas
  //
  //
  // por Alberto Bachler Klein
  // creación 18/07/17, 19:10:20
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_BOOLEAN:C305($b_calculosCompetencias)
C_LONGINT:C283($i;$j)
C_POINTER:C301($y_arregloReal;$y_arregloLiteral)
C_REAL:C285($r_minimoEscala)
C_TEXT:C284($t_formatoNF;$t_formatoNO;$t_formatoParciales;$t_formatoPF;$t_formatoPP)

EV2_InitArrays 
PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
EV2_Examenes_LeeConfigExamenes (vlSTR_PeriodoSeleccionado)
EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)


ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6;>)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aNtaRecNum;[Alumnos_Calificaciones:208]Llave_principal:1;at_KeyEvaluacionPrincipal;[Alumnos_Calificaciones:208]ID_Alumno:6;aNtaIDAlumno;[Alumnos:2]apellidos_y_nombres:40;aNtaStdNme;[Alumnos:2]curso:20;aNtaCurso;[Alumnos_Calificaciones:208]NoDeLista:10;aNtaOrden;[Alumnos:2]Status:50;aNtaStatus;[Alumnos_Calificaciones:208]Reprobada:9;aNtaReprobada;[Alumnos_Calificaciones:208]P01_Final_Nota:113;aRealNtaP1;[Alumnos_Calificaciones:208]P02_Final_Nota:188;aRealNtaP2;[Alumnos_Calificaciones:208]P03_Final_Nota:263;aRealNtaP3;[Alumnos_Calificaciones:208]P04_Final_Nota:338;aRealNtaP4;[Alumnos_Calificaciones:208]P05_Final_Nota:413;aRealNtaP5;[Alumnos_Calificaciones:208]P01_Final_Literal:116;aNtaP1;[Alumnos_Calificaciones:208]P02_Final_Literal:191;aNtaP2;[Alumnos_Calificaciones:208]P03_Final_Literal:266;aNtaP3;[Alumnos_Calificaciones:208]P04_Final_Literal:341;aNtaP4;[Alumnos_Calificaciones:208]P05_Final_Literal:416;aNtaP5;[Alumnos_Calificaciones:208]Anual_Nota:12;aRealNtaPF;[Alumnos_Calificaciones:208]ExamenAnual_Nota:17;aRealNtaEX;[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;aRealNtaF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;aRealNtaOficial;[Alumnos_Calificaciones:208]Anual_Literal:15;aNtaPF;[Alumnos_Calificaciones:208]ExamenAnual_Literal:20;aNtaEX;[Alumnos_Calificaciones:208]ExamenExtra_Nota:22;aRealNtaEXX;[Alumnos_Calificaciones:208]ExamenExtra_Literal:25;aNtaEXX;[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;aNtaF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;aNtaOf;[Alumnos_Calificaciones:208]AutoEval_Literal:41;aNtaAutoEval;[Alumnos_Calificaciones:208]AutoEval_Nota:38;aRealNtaAutoEval;[Alumnos_ComplementoEvaluacion:209]Eximicion_NoRegistro:8;aNtaRegEximicion;[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Nota:96;aRealEXRecuperatorio;[Alumnos:2]Sexo:49;aSexoAlumnos)
$b_calculosCompetencias:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9)

Case of 
	: (vlSTR_PeriodoSeleccionado=1)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Eval01_Nota:43;aRealNta1;[Alumnos_Calificaciones:208]P01_Eval02_Nota:48;aRealNta2;[Alumnos_Calificaciones:208]P01_Eval03_Nota:53;aRealNta3;[Alumnos_Calificaciones:208]P01_Eval04_Nota:58;aRealNta4;[Alumnos_Calificaciones:208]P01_Eval05_Nota:63;aRealNta5;[Alumnos_Calificaciones:208]P01_Eval06_Nota:68;aRealNta6;[Alumnos_Calificaciones:208]P01_Eval07_Nota:73;aRealNta7;[Alumnos_Calificaciones:208]P01_Eval08_Nota:78;aRealNta8;[Alumnos_Calificaciones:208]P01_Eval09_Nota:83;aRealNta9;[Alumnos_Calificaciones:208]P01_Eval10_Nota:88;aRealNta10;[Alumnos_Calificaciones:208]P01_Eval11_Nota:93;aRealNta11;[Alumnos_Calificaciones:208]P01_Eval12_Nota:98;aRealNta12;[Alumnos_Calificaciones:208]P01_Control_Nota:108;aRealNtaEXP;[Alumnos_Calificaciones:208]P01_Presentacion_Nota:103;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16;aNtaEsfuerzo;[Alumnos_ComplementoEvaluacion:209]P01_Inasistencias:18;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P01_Bonificacion_Nota:511;aRealNtaBX)
		If (Not:C34($b_calculosCompetencias))
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Eval01_Literal:46;aNta1;[Alumnos_Calificaciones:208]P01_Eval02_Literal:51;aNta2;[Alumnos_Calificaciones:208]P01_Eval03_Literal:56;aNta3;[Alumnos_Calificaciones:208]P01_Eval04_Literal:61;aNta4;[Alumnos_Calificaciones:208]P01_Eval05_Literal:66;aNta5;[Alumnos_Calificaciones:208]P01_Eval06_Literal:71;aNta6;[Alumnos_Calificaciones:208]P01_Eval07_Literal:76;aNta7;[Alumnos_Calificaciones:208]P01_Eval08_Literal:81;aNta8;[Alumnos_Calificaciones:208]P01_Eval09_Literal:86;aNta9;[Alumnos_Calificaciones:208]P01_Eval10_Literal:91;aNta10;[Alumnos_Calificaciones:208]P01_Eval11_Literal:96;aNta11;[Alumnos_Calificaciones:208]P01_Eval12_Literal:101;aNta12;[Alumnos_Calificaciones:208]P01_Control_Literal:111;aNtaEXP;[Alumnos_Calificaciones:208]P01_Presentacion_Literal:106;aNtaPresentP;[Alumnos_Calificaciones:208]P01_Bonificacion_Literal:514;aNtaBX)
		Else 
			EV2_InitArrays (Size of array:C274(aNtaIDAlumno))
		End if 
		
	: (vlSTR_PeriodoSeleccionado=2)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Eval01_Nota:118;aRealNta1;[Alumnos_Calificaciones:208]P02_Eval02_Nota:123;aRealNta2;[Alumnos_Calificaciones:208]P02_Eval03_Nota:128;aRealNta3;[Alumnos_Calificaciones:208]P02_Eval04_Nota:133;aRealNta4;[Alumnos_Calificaciones:208]P02_Eval05_Nota:138;aRealNta5;[Alumnos_Calificaciones:208]P02_Eval06_Nota:143;aRealNta6;[Alumnos_Calificaciones:208]P02_Eval07_Nota:148;aRealNta7;[Alumnos_Calificaciones:208]P02_Eval08_Nota:153;aRealNta8;[Alumnos_Calificaciones:208]P02_Eval09_Nota:158;aRealNta9;[Alumnos_Calificaciones:208]P02_Eval10_Nota:163;aRealNta10;[Alumnos_Calificaciones:208]P02_Eval11_Nota:168;aRealNta11;[Alumnos_Calificaciones:208]P02_Eval12_Nota:173;aRealNta12;[Alumnos_Calificaciones:208]P02_Control_Nota:183;aRealNtaEXP;[Alumnos_Calificaciones:208]P02_Presentacion_Nota:178;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21;aNtaEsfuerzo;[Alumnos_ComplementoEvaluacion:209]P02_Inasistencias:23;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P02_Bonificacion_Nota:516;aRealNtaBX)
		If (Not:C34($b_calculosCompetencias))
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Eval01_Literal:121;aNta1;[Alumnos_Calificaciones:208]P02_Eval02_Literal:126;aNta2;[Alumnos_Calificaciones:208]P02_Eval03_Literal:131;aNta3;[Alumnos_Calificaciones:208]P02_Eval04_Literal:136;aNta4;[Alumnos_Calificaciones:208]P02_Eval05_Literal:141;aNta5;[Alumnos_Calificaciones:208]P02_Eval06_Literal:146;aNta6;[Alumnos_Calificaciones:208]P02_Eval07_Literal:151;aNta7;[Alumnos_Calificaciones:208]P02_Eval08_Literal:156;aNta8;[Alumnos_Calificaciones:208]P02_Eval09_Literal:161;aNta9;[Alumnos_Calificaciones:208]P02_Eval10_Literal:166;aNta10;[Alumnos_Calificaciones:208]P02_Eval11_Literal:171;aNta11;[Alumnos_Calificaciones:208]P02_Eval12_Literal:176;aNta12;[Alumnos_Calificaciones:208]P02_Control_Literal:186;aNtaEXP;[Alumnos_Calificaciones:208]P02_Presentacion_Literal:181;aNtaPresentP;[Alumnos_Calificaciones:208]P02_Bonificacion_Literal:519;aNtaBX)
		Else 
			EV2_InitArrays (Size of array:C274(aNtaIDAlumno))
		End if 
		
	: (vlSTR_PeriodoSeleccionado=3)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Eval01_Nota:193;aRealNta1;[Alumnos_Calificaciones:208]P03_Eval02_Nota:198;aRealNta2;[Alumnos_Calificaciones:208]P03_Eval03_Nota:203;aRealNta3;[Alumnos_Calificaciones:208]P03_Eval04_Nota:208;aRealNta4;[Alumnos_Calificaciones:208]P03_Eval05_Nota:213;aRealNta5;[Alumnos_Calificaciones:208]P03_Eval06_Nota:218;aRealNta6;[Alumnos_Calificaciones:208]P03_Eval07_Nota:223;aRealNta7;[Alumnos_Calificaciones:208]P03_Eval08_Nota:228;aRealNta8;[Alumnos_Calificaciones:208]P03_Eval09_Nota:233;aRealNta9;[Alumnos_Calificaciones:208]P03_Eval10_Nota:238;aRealNta10;[Alumnos_Calificaciones:208]P03_Eval11_Nota:243;aRealNta11;[Alumnos_Calificaciones:208]P03_Eval12_Nota:248;aRealNta12;[Alumnos_Calificaciones:208]P03_Control_Nota:258;aRealNtaEXP;[Alumnos_Calificaciones:208]P03_Presentacion_Nota:253;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26;aNtaEsfuerzo;[Alumnos_ComplementoEvaluacion:209]P03_Inasistencias:28;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P03_Bonificacion_Nota:521;aRealNtaBX)
		If (Not:C34($b_calculosCompetencias))
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Eval01_Literal:196;aNta1;[Alumnos_Calificaciones:208]P03_Eval02_Literal:201;aNta2;[Alumnos_Calificaciones:208]P03_Eval03_Literal:206;aNta3;[Alumnos_Calificaciones:208]P03_Eval04_Literal:211;aNta4;[Alumnos_Calificaciones:208]P03_Eval05_Literal:216;aNta5;[Alumnos_Calificaciones:208]P03_Eval06_Literal:221;aNta6;[Alumnos_Calificaciones:208]P03_Eval07_Literal:226;aNta7;[Alumnos_Calificaciones:208]P03_Eval08_Literal:231;aNta8;[Alumnos_Calificaciones:208]P03_Eval09_Literal:236;aNta9;[Alumnos_Calificaciones:208]P03_Eval10_Literal:241;aNta10;[Alumnos_Calificaciones:208]P03_Eval11_Literal:246;aNta11;[Alumnos_Calificaciones:208]P03_Eval12_Literal:251;aNta12;[Alumnos_Calificaciones:208]P03_Control_Literal:261;aNtaEXP;[Alumnos_Calificaciones:208]P03_Presentacion_Literal:256;aNtaPresentP;[Alumnos_Calificaciones:208]P03_Bonificacion_Literal:524;aNtaBX)
		Else 
			EV2_InitArrays (Size of array:C274(aNtaIDAlumno))
		End if 
		
	: (vlSTR_PeriodoSeleccionado=4)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Eval01_Nota:268;aRealNta1;[Alumnos_Calificaciones:208]P04_Eval02_Nota:273;aRealNta2;[Alumnos_Calificaciones:208]P04_Eval03_Nota:278;aRealNta3;[Alumnos_Calificaciones:208]P04_Eval04_Nota:283;aRealNta4;[Alumnos_Calificaciones:208]P04_Eval05_Nota:288;aRealNta5;[Alumnos_Calificaciones:208]P04_Eval06_Nota:293;aRealNta6;[Alumnos_Calificaciones:208]P04_Eval07_Nota:298;aRealNta7;[Alumnos_Calificaciones:208]P04_Eval08_Nota:303;aRealNta8;[Alumnos_Calificaciones:208]P04_Eval09_Nota:308;aRealNta9;[Alumnos_Calificaciones:208]P04_Eval10_Nota:313;aRealNta10;[Alumnos_Calificaciones:208]P04_Eval11_Nota:318;aRealNta11;[Alumnos_Calificaciones:208]P04_Eval12_Nota:323;aRealNta12;[Alumnos_Calificaciones:208]P04_Control_Nota:333;aRealNtaEXP;[Alumnos_Calificaciones:208]P04_Presentacion_Nota:328;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31;aNtaEsfuerzo;[Alumnos_ComplementoEvaluacion:209]P04_Inasistencias:33;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P04_Bonificacion_Nota:526;aRealNtaBX)
		If (Not:C34($b_calculosCompetencias))
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Eval01_Literal:271;aNta1;[Alumnos_Calificaciones:208]P04_Eval02_Literal:276;aNta2;[Alumnos_Calificaciones:208]P04_Eval03_Literal:281;aNta3;[Alumnos_Calificaciones:208]P04_Eval04_Literal:286;aNta4;[Alumnos_Calificaciones:208]P04_Eval05_Literal:291;aNta5;[Alumnos_Calificaciones:208]P04_Eval06_Literal:296;aNta6;[Alumnos_Calificaciones:208]P04_Eval07_Literal:301;aNta7;[Alumnos_Calificaciones:208]P04_Eval08_Literal:306;aNta8;[Alumnos_Calificaciones:208]P04_Eval09_Literal:311;aNta9;[Alumnos_Calificaciones:208]P04_Eval10_Literal:316;aNta10;[Alumnos_Calificaciones:208]P04_Eval11_Literal:321;aNta11;[Alumnos_Calificaciones:208]P04_Eval12_Literal:326;aNta12;[Alumnos_Calificaciones:208]P04_Control_Literal:336;aNtaEXP;[Alumnos_Calificaciones:208]P04_Presentacion_Literal:331;aNtaPresentP;[Alumnos_Calificaciones:208]P04_Bonificacion_Literal:529;aNtaBX)
		Else 
			EV2_InitArrays (Size of array:C274(aNtaIDAlumno))
		End if 
		
	: (vlSTR_PeriodoSeleccionado=5)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Eval01_Nota:343;aRealNta1;[Alumnos_Calificaciones:208]P05_Eval02_Nota:348;aRealNta2;[Alumnos_Calificaciones:208]P05_Eval03_Nota:353;aRealNta3;[Alumnos_Calificaciones:208]P05_Eval04_Nota:358;aRealNta4;[Alumnos_Calificaciones:208]P05_Eval05_Nota:363;aRealNta5;[Alumnos_Calificaciones:208]P05_Eval06_Nota:368;aRealNta6;[Alumnos_Calificaciones:208]P05_Eval07_Nota:373;aRealNta7;[Alumnos_Calificaciones:208]P05_Eval08_Nota:378;aRealNta8;[Alumnos_Calificaciones:208]P05_Eval09_Nota:383;aRealNta9;[Alumnos_Calificaciones:208]P05_Eval10_Nota:388;aRealNta10;[Alumnos_Calificaciones:208]P05_Eval11_Nota:393;aRealNta11;[Alumnos_Calificaciones:208]P05_Eval12_Nota:398;aRealNta12;[Alumnos_Calificaciones:208]P05_Control_Nota:408;aRealNtaEXP;[Alumnos_Calificaciones:208]P05_Presentacion_Nota:403;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36;aNtaEsfuerzo;[Alumnos_ComplementoEvaluacion:209]P05_Inasistencias:38;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P05_Bonificacion_Nota:531;aRealNtaBX)
		If (Not:C34($b_calculosCompetencias))
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Eval01_Literal:346;aNta1;[Alumnos_Calificaciones:208]P05_Eval02_Literal:351;aNta2;[Alumnos_Calificaciones:208]P05_Eval03_Literal:356;aNta3;[Alumnos_Calificaciones:208]P05_Eval04_Literal:361;aNta4;[Alumnos_Calificaciones:208]P05_Eval05_Literal:366;aNta5;[Alumnos_Calificaciones:208]P05_Eval06_Literal:371;aNta6;[Alumnos_Calificaciones:208]P05_Eval07_Literal:376;aNta7;[Alumnos_Calificaciones:208]P05_Eval08_Literal:381;aNta8;[Alumnos_Calificaciones:208]P05_Eval09_Literal:386;aNta9;[Alumnos_Calificaciones:208]P05_Eval10_Literal:391;aNta10;[Alumnos_Calificaciones:208]P05_Eval11_Literal:396;aNta11;[Alumnos_Calificaciones:208]P05_Eval12_Literal:401;aNta12;[Alumnos_Calificaciones:208]P05_Control_Literal:411;aNtaEXP;[Alumnos_Calificaciones:208]P05_Presentacion_Literal:406;aNtaPresentP;[Alumnos_Calificaciones:208]P05_Bonificacion_Literal:534;aNtaBX)
		Else 
			EV2_InitArrays (Size of array:C274(aNtaIDAlumno))
		End if 
		
End case 
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

For ($i;1;Size of array:C274(aNtaRealArrPointers))
	AT_ResizeArrays (aNtaStrArrPointers{$i};Size of array:C274(aNtaRealArrPointers{$i}->))
End for 

EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
$r_minimoEscala:=rGradesFrom
$t_formatoParciales:=EV2_ALT_FormatoString (iGradesDec)
$t_formatoPP:=EV2_ALT_FormatoString (iGradesDecPP)
$t_formatoPF:=EV2_ALT_FormatoString (iGradesDecPF)
$t_formatoNF:=EV2_ALT_FormatoString (iGradesDecNF)

$l_IdEstiloOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]EvStyle_oficial:23)
$b_usarEstiloOficial:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]ConvertirEval_a_EstiloOficial:37)
$b_usarEstiloOficial:=$b_usarEstiloOficial & Not:C34([Asignaturas:18]NotaOficial_conEstiloAsignatura:95)
If ($b_usarEstiloOficial)
	EVS_ReadStyleData ($l_IdEstiloOficial)
End if 
Case of 
	: (iPrintActa=Notas)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;aNtaOf;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;aRealNtaOficial)
	: (iPrintActa=Puntos)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;aNtaOf;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34;aRealNtaOficial)
	Else 
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;aNtaOf;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;aRealNtaOficial)
End case 
EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

For ($i;1;Size of array:C274(aNtaRealArrPointers))
	AT_ResizeArrays (aNtaStrArrPointers{$i};Size of array:C274(aNtaRealArrPointers{$i}->))
End for 


For ($i;1;13)
	$y_arregloReal:=aNtaRealArrPointers{$i}
	$y_arregloLiteral:=aNtaStrArrPointers{$i}
	For ($j;1;Size of array:C274($y_arregloReal->))
		Case of 
			: ($y_arregloReal->{$j}=-10)
				$y_arregloLiteral->{$j}:=""
			: ($y_arregloReal->{$j}=-4)
				$y_arregloLiteral->{$j}:="*"
			: ($y_arregloReal->{$j}=-3)
				$y_arregloLiteral->{$j}:="X"
			: ($y_arregloReal->{$j}=-2)
				$y_arregloLiteral->{$j}:="P"
			: ($y_arregloReal->{$j}>=$r_minimoEscala)
				$y_arregloLiteral->{$j}:=String:C10($y_arregloReal->{$j};$t_formatoParciales)
		End case 
	End for 
End for 

For ($i;14;18)
	$y_arregloReal:=aNtaRealArrPointers{$i}
	$y_arregloLiteral:=aNtaStrArrPointers{$i}
	For ($j;1;Size of array:C274($y_arregloReal->))
		Case of 
			: ($y_arregloReal->{$j}=-10)
				$y_arregloLiteral->{$j}:=""
			: ($y_arregloReal->{$j}=-4)
				$y_arregloLiteral->{$j}:="*"
			: ($y_arregloReal->{$j}=-3)
				$y_arregloLiteral->{$j}:="X"
			: ($y_arregloReal->{$j}=-2)
				$y_arregloLiteral->{$j}:="P"
			: ($y_arregloReal->{$j}>=$r_minimoEscala)
				$y_arregloLiteral->{$j}:=String:C10($y_arregloReal->{$j};$t_formatoPP)
		End case 
	End for 
End for 

$y_arregloReal:=->aRealNtaPF
$y_arregloLiteral:=->aNtaPF
For ($j;1;Size of array:C274(aNtaPF))
	Case of 
		: ($y_arregloReal->{$j}=-10)
			$y_arregloLiteral->{$j}:=""
		: ($y_arregloReal->{$j}=-4)
			$y_arregloLiteral->{$j}:="*"
		: ($y_arregloReal->{$j}=-3)
			$y_arregloLiteral->{$j}:="X"
		: ($y_arregloReal->{$j}=-2)
			$y_arregloLiteral->{$j}:="P"
		: ($y_arregloReal->{$j}>=$r_minimoEscala)
			$y_arregloLiteral->{$j}:=String:C10($y_arregloReal->{$j};$t_formatoPF)
	End case 
End for 

$y_arregloReal:=->aRealNtaEX
$y_arregloLiteral:=->aNtaEX
For ($j;1;Size of array:C274(aNtaEX))
	$y_arregloLiteral->{$j}:=String:C10($y_arregloReal->{$j};$t_formatoParciales)
End for 

$y_arregloReal:=->aRealNtaEXX
$y_arregloLiteral:=->aNtaEXX
For ($j;1;Size of array:C274(aNtaEXX))
	Case of 
		: ($y_arregloReal->{$j}=-10)
			$y_arregloLiteral->{$j}:=""
		: ($y_arregloReal->{$j}=-4)
			$y_arregloLiteral->{$j}:="*"
		: ($y_arregloReal->{$j}=-3)
			$y_arregloLiteral->{$j}:="X"
		: ($y_arregloReal->{$j}=-2)
			$y_arregloLiteral->{$j}:="P"
		: ($y_arregloReal->{$j}>=$r_minimoEscala)
			$y_arregloLiteral->{$j}:=String:C10($y_arregloReal->{$j};$t_formatoParciales)
	End case 
End for 


$y_arregloReal:=->aRealNtaF
$y_arregloLiteral:=->aNtaF
For ($j;1;Size of array:C274(aNtaF))
	Case of 
		: ($y_arregloReal->{$j}=-10)
			$y_arregloLiteral->{$j}:=""
		: ($y_arregloReal->{$j}=-4)
			$y_arregloLiteral->{$j}:="*"
		: ($y_arregloReal->{$j}=-3)
			$y_arregloLiteral->{$j}:="X"
		: ($y_arregloReal->{$j}=-2)
			$y_arregloLiteral->{$j}:="P"
		: ($y_arregloReal->{$j}>=$r_minimoEscala)
			$y_arregloLiteral->{$j}:=String:C10($y_arregloReal->{$j};$t_formatoNF)
	End case 
End for 


  //$y_arregloReal:=->aRealNtaOficial
  //$y_arregloLiteral:=->aNtaOF
  //For ($j;1;Size of array(aNtaOF))
  //Case of 
  //: ($y_arregloReal->{$j}=-10)
  //$y_arregloLiteral->{$j}:=""
  //: ($y_arregloReal->{$j}=-4)
  //$y_arregloLiteral->{$j}:="*"
  //: ($y_arregloReal->{$j}=-3)
  //$y_arregloLiteral->{$j}:="X"
  //: ($y_arregloReal->{$j}=-2)
  //$y_arregloLiteral->{$j}:="P"
  //: ($y_arregloReal->{$j}>=$r_minimoEscala)
  //$y_arregloLiteral->{$j}:=String($y_arregloReal->{$j};$t_formatoNO)
  //End case 
  //End for 