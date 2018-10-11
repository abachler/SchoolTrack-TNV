//%attributes = {}
  // Método: EV2_ALT_CargaPuntos
  //
  // 
  // por Alberto Bachler Klein
  // creación 18/07/17, 20:37:17
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
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aNtaRecNum;[Alumnos_Calificaciones:208]Llave_principal:1;at_KeyEvaluacionPrincipal;[Alumnos_Calificaciones:208]ID_Alumno:6;aNtaIDAlumno;[Alumnos:2]apellidos_y_nombres:40;aNtaStdNme;[Alumnos:2]curso:20;aNtaCurso;[Alumnos_Calificaciones:208]NoDeLista:10;aNtaOrden;[Alumnos:2]Status:50;aNtaStatus;[Alumnos_Calificaciones:208]Reprobada:9;aNtaReprobada;[Alumnos_Calificaciones:208]P01_Final_Puntos:114;aRealNtaP1;[Alumnos_Calificaciones:208]P02_Final_Puntos:189;aRealNtaP2;[Alumnos_Calificaciones:208]P03_Final_Puntos:264;aRealNtaP3;[Alumnos_Calificaciones:208]P04_Final_Puntos:339;aRealNtaP4;[Alumnos_Calificaciones:208]P05_Final_Puntos:414;aRealNtaP5;[Alumnos_Calificaciones:208]P01_Final_Literal:116;aNtaP1;[Alumnos_Calificaciones:208]P02_Final_Literal:191;aNtaP2;[Alumnos_Calificaciones:208]P03_Final_Literal:266;aNtaP3;[Alumnos_Calificaciones:208]P04_Final_Literal:341;aNtaP4;[Alumnos_Calificaciones:208]P05_Final_Literal:416;aNtaP5;[Alumnos_Calificaciones:208]Anual_Puntos:13;aRealNtaPF;[Alumnos_Calificaciones:208]ExamenAnual_Puntos:18;aRealNtaEX;[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28;aRealNtaF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34;aRealNtaOficial;[Alumnos_Calificaciones:208]Anual_Literal:15;aNtaPF;[Alumnos_Calificaciones:208]ExamenAnual_Literal:20;aNtaEX;[Alumnos_Calificaciones:208]ExamenExtra_Puntos:23;aRealNtaEXX;[Alumnos_Calificaciones:208]ExamenExtra_Literal:25;aNtaEXX;[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;aNtaF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;aNtaOf;[Alumnos_Calificaciones:208]AutoEval_Literal:41;aNtaAutoEval;[Alumnos_Calificaciones:208]AutoEval_Puntos:39;aRealNtaAutoEval;[Alumnos_ComplementoEvaluacion:209]Eximicion_NoRegistro:8;aNtaRegEximicion;[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Puntos:97;aRealEXRecuperatorio;[Alumnos:2]Sexo:49;aSexoAlumnos)
$b_calculosCompetencias:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9)

Case of 
	: (vlSTR_PeriodoSeleccionado=1)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Eval01_Puntos:44;aRealNta1;[Alumnos_Calificaciones:208]P01_Eval02_Puntos:49;aRealNta2;[Alumnos_Calificaciones:208]P01_Eval03_Puntos:54;aRealNta3;[Alumnos_Calificaciones:208]P01_Eval04_Puntos:59;aRealNta4;[Alumnos_Calificaciones:208]P01_Eval05_Puntos:64;aRealNta5;[Alumnos_Calificaciones:208]P01_Eval06_Puntos:69;aRealNta6;[Alumnos_Calificaciones:208]P01_Eval07_Puntos:74;aRealNta7;[Alumnos_Calificaciones:208]P01_Eval08_Puntos:79;aRealNta8;[Alumnos_Calificaciones:208]P01_Eval09_Puntos:84;aRealNta9;[Alumnos_Calificaciones:208]P01_Eval10_Puntos:89;aRealNta10;[Alumnos_Calificaciones:208]P01_Eval11_Puntos:94;aRealNta11;[Alumnos_Calificaciones:208]P01_Eval12_Puntos:99;aRealNta12;[Alumnos_Calificaciones:208]P01_Control_Puntos:109;aRealNtaEXP;[Alumnos_Calificaciones:208]P01_Presentacion_Puntos:104;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16;aNtaEsfuerzo;[Alumnos_ComplementoEvaluacion:209]P01_Inasistencias:18;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P01_Bonificacion_Puntos:512;aRealNtaBX)
		If (Not:C34($b_calculosCompetencias))
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Eval01_Literal:46;aNta1;[Alumnos_Calificaciones:208]P01_Eval02_Literal:51;aNta2;[Alumnos_Calificaciones:208]P01_Eval03_Literal:56;aNta3;[Alumnos_Calificaciones:208]P01_Eval04_Literal:61;aNta4;[Alumnos_Calificaciones:208]P01_Eval05_Literal:66;aNta5;[Alumnos_Calificaciones:208]P01_Eval06_Literal:71;aNta6;[Alumnos_Calificaciones:208]P01_Eval07_Literal:76;aNta7;[Alumnos_Calificaciones:208]P01_Eval08_Literal:81;aNta8;[Alumnos_Calificaciones:208]P01_Eval09_Literal:86;aNta9;[Alumnos_Calificaciones:208]P01_Eval10_Literal:91;aNta10;[Alumnos_Calificaciones:208]P01_Eval11_Literal:96;aNta11;[Alumnos_Calificaciones:208]P01_Eval12_Literal:101;aNta12;[Alumnos_Calificaciones:208]P01_Control_Literal:111;aNtaEXP;[Alumnos_Calificaciones:208]P01_Presentacion_Literal:106;aNtaPresentP;[Alumnos_Calificaciones:208]P01_Bonificacion_Literal:514;aNtaBX)
		Else 
			EV2_InitArrays (Size of array:C274(aNtaIDAlumno))
		End if 
		
	: (vlSTR_PeriodoSeleccionado=2)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Eval01_Puntos:119;aRealNta1;[Alumnos_Calificaciones:208]P02_Eval02_Puntos:124;aRealNta2;[Alumnos_Calificaciones:208]P02_Eval03_Puntos:129;aRealNta3;[Alumnos_Calificaciones:208]P02_Eval04_Puntos:134;aRealNta4;[Alumnos_Calificaciones:208]P02_Eval05_Puntos:139;aRealNta5;[Alumnos_Calificaciones:208]P02_Eval06_Puntos:144;aRealNta6;[Alumnos_Calificaciones:208]P02_Eval07_Puntos:149;aRealNta7;[Alumnos_Calificaciones:208]P02_Eval08_Puntos:154;aRealNta8;[Alumnos_Calificaciones:208]P02_Eval09_Puntos:159;aRealNta9;[Alumnos_Calificaciones:208]P02_Eval10_Puntos:164;aRealNta10;[Alumnos_Calificaciones:208]P02_Eval11_Puntos:169;aRealNta11;[Alumnos_Calificaciones:208]P02_Eval12_Puntos:174;aRealNta12;[Alumnos_Calificaciones:208]P02_Control_Puntos:184;aRealNtaEXP;[Alumnos_Calificaciones:208]P02_Presentacion_Puntos:179;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21;aNtaEsfuerzo;[Alumnos_ComplementoEvaluacion:209]P02_Inasistencias:23;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P02_Bonificacion_Puntos:517;aRealNtaBX)
		If (Not:C34($b_calculosCompetencias))
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Eval01_Literal:121;aNta1;[Alumnos_Calificaciones:208]P02_Eval02_Literal:126;aNta2;[Alumnos_Calificaciones:208]P02_Eval03_Literal:131;aNta3;[Alumnos_Calificaciones:208]P02_Eval04_Literal:136;aNta4;[Alumnos_Calificaciones:208]P02_Eval05_Literal:141;aNta5;[Alumnos_Calificaciones:208]P02_Eval06_Literal:146;aNta6;[Alumnos_Calificaciones:208]P02_Eval07_Literal:151;aNta7;[Alumnos_Calificaciones:208]P02_Eval08_Literal:156;aNta8;[Alumnos_Calificaciones:208]P02_Eval09_Literal:161;aNta9;[Alumnos_Calificaciones:208]P02_Eval10_Literal:166;aNta10;[Alumnos_Calificaciones:208]P02_Eval11_Literal:171;aNta11;[Alumnos_Calificaciones:208]P02_Eval12_Literal:176;aNta12;[Alumnos_Calificaciones:208]P02_Control_Literal:186;aNtaEXP;[Alumnos_Calificaciones:208]P02_Presentacion_Literal:181;aNtaPresentP;[Alumnos_Calificaciones:208]P02_Bonificacion_Literal:519;aNtaBX)
		Else 
			EV2_InitArrays (Size of array:C274(aNtaIDAlumno))
		End if 
		
	: (vlSTR_PeriodoSeleccionado=3)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Eval01_Puntos:194;aRealNta1;[Alumnos_Calificaciones:208]P03_Eval02_Puntos:199;aRealNta2;[Alumnos_Calificaciones:208]P03_Eval03_Puntos:204;aRealNta3;[Alumnos_Calificaciones:208]P03_Eval04_Puntos:209;aRealNta4;[Alumnos_Calificaciones:208]P03_Eval05_Puntos:214;aRealNta5;[Alumnos_Calificaciones:208]P03_Eval06_Puntos:219;aRealNta6;[Alumnos_Calificaciones:208]P03_Eval07_Puntos:224;aRealNta7;[Alumnos_Calificaciones:208]P03_Eval08_Puntos:229;aRealNta8;[Alumnos_Calificaciones:208]P03_Eval09_Puntos:234;aRealNta9;[Alumnos_Calificaciones:208]P03_Eval10_Puntos:239;aRealNta10;[Alumnos_Calificaciones:208]P03_Eval11_Puntos:244;aRealNta11;[Alumnos_Calificaciones:208]P03_Eval12_Puntos:249;aRealNta12;[Alumnos_Calificaciones:208]P03_Control_Puntos:259;aRealNtaEXP;[Alumnos_Calificaciones:208]P03_Presentacion_Puntos:254;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26;aNtaEsfuerzo;[Alumnos_ComplementoEvaluacion:209]P03_Inasistencias:28;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P03_Bonificacion_Puntos:522;aRealNtaBX)
		If (Not:C34($b_calculosCompetencias))
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Eval01_Literal:196;aNta1;[Alumnos_Calificaciones:208]P03_Eval02_Literal:201;aNta2;[Alumnos_Calificaciones:208]P03_Eval03_Literal:206;aNta3;[Alumnos_Calificaciones:208]P03_Eval04_Literal:211;aNta4;[Alumnos_Calificaciones:208]P03_Eval05_Literal:216;aNta5;[Alumnos_Calificaciones:208]P03_Eval06_Literal:221;aNta6;[Alumnos_Calificaciones:208]P03_Eval07_Literal:226;aNta7;[Alumnos_Calificaciones:208]P03_Eval08_Literal:231;aNta8;[Alumnos_Calificaciones:208]P03_Eval09_Literal:236;aNta9;[Alumnos_Calificaciones:208]P03_Eval10_Literal:241;aNta10;[Alumnos_Calificaciones:208]P03_Eval11_Literal:246;aNta11;[Alumnos_Calificaciones:208]P03_Eval12_Literal:251;aNta12;[Alumnos_Calificaciones:208]P03_Control_Literal:261;aNtaEXP;[Alumnos_Calificaciones:208]P03_Presentacion_Literal:256;aNtaPresentP;[Alumnos_Calificaciones:208]P03_Bonificacion_Literal:524;aNtaBX)
		Else 
			EV2_InitArrays (Size of array:C274(aNtaIDAlumno))
		End if 
		
	: (vlSTR_PeriodoSeleccionado=4)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Eval01_Puntos:269;aRealNta1;[Alumnos_Calificaciones:208]P04_Eval02_Puntos:274;aRealNta2;[Alumnos_Calificaciones:208]P04_Eval03_Puntos:279;aRealNta3;[Alumnos_Calificaciones:208]P04_Eval04_Puntos:284;aRealNta4;[Alumnos_Calificaciones:208]P04_Eval05_Puntos:289;aRealNta5;[Alumnos_Calificaciones:208]P04_Eval06_Puntos:294;aRealNta6;[Alumnos_Calificaciones:208]P04_Eval07_Puntos:299;aRealNta7;[Alumnos_Calificaciones:208]P04_Eval08_Puntos:304;aRealNta8;[Alumnos_Calificaciones:208]P04_Eval09_Puntos:309;aRealNta9;[Alumnos_Calificaciones:208]P04_Eval10_Puntos:314;aRealNta10;[Alumnos_Calificaciones:208]P04_Eval11_Puntos:319;aRealNta11;[Alumnos_Calificaciones:208]P04_Eval12_Puntos:324;aRealNta12;[Alumnos_Calificaciones:208]P04_Control_Puntos:334;aRealNtaEXP;[Alumnos_Calificaciones:208]P04_Presentacion_Puntos:329;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31;aNtaEsfuerzo;[Alumnos_ComplementoEvaluacion:209]P04_Inasistencias:33;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P04_Bonificacion_Puntos:527;aRealNtaBX)
		If (Not:C34($b_calculosCompetencias))
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Eval01_Literal:271;aNta1;[Alumnos_Calificaciones:208]P04_Eval02_Literal:276;aNta2;[Alumnos_Calificaciones:208]P04_Eval03_Literal:281;aNta3;[Alumnos_Calificaciones:208]P04_Eval04_Literal:286;aNta4;[Alumnos_Calificaciones:208]P04_Eval05_Literal:291;aNta5;[Alumnos_Calificaciones:208]P04_Eval06_Literal:296;aNta6;[Alumnos_Calificaciones:208]P04_Eval07_Literal:301;aNta7;[Alumnos_Calificaciones:208]P04_Eval08_Literal:306;aNta8;[Alumnos_Calificaciones:208]P04_Eval09_Literal:311;aNta9;[Alumnos_Calificaciones:208]P04_Eval10_Literal:316;aNta10;[Alumnos_Calificaciones:208]P04_Eval11_Literal:321;aNta11;[Alumnos_Calificaciones:208]P04_Eval12_Literal:326;aNta12;[Alumnos_Calificaciones:208]P04_Control_Literal:336;aNtaEXP;[Alumnos_Calificaciones:208]P04_Presentacion_Literal:331;aNtaPresentP;[Alumnos_Calificaciones:208]P04_Bonificacion_Literal:529;aNtaBX)
		Else 
			EV2_InitArrays (Size of array:C274(aNtaIDAlumno))
		End if 
		
	: (vlSTR_PeriodoSeleccionado=5)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Eval01_Puntos:344;aRealNta1;[Alumnos_Calificaciones:208]P05_Eval02_Puntos:349;aRealNta2;[Alumnos_Calificaciones:208]P05_Eval03_Puntos:354;aRealNta3;[Alumnos_Calificaciones:208]P05_Eval04_Puntos:359;aRealNta4;[Alumnos_Calificaciones:208]P05_Eval05_Puntos:364;aRealNta5;[Alumnos_Calificaciones:208]P05_Eval06_Puntos:369;aRealNta6;[Alumnos_Calificaciones:208]P05_Eval07_Puntos:374;aRealNta7;[Alumnos_Calificaciones:208]P05_Eval08_Puntos:379;aRealNta8;[Alumnos_Calificaciones:208]P05_Eval09_Puntos:384;aRealNta9;[Alumnos_Calificaciones:208]P05_Eval10_Puntos:389;aRealNta10;[Alumnos_Calificaciones:208]P05_Eval11_Puntos:394;aRealNta11;[Alumnos_Calificaciones:208]P05_Eval12_Puntos:399;aRealNta12;[Alumnos_Calificaciones:208]P05_Control_Puntos:409;aRealNtaEXP;[Alumnos_Calificaciones:208]P05_Presentacion_Puntos:404;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36;aNtaEsfuerzo;[Alumnos_ComplementoEvaluacion:209]P05_Inasistencias:38;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P05_Bonificacion_Puntos:532;aRealNtaBX)
		If (Not:C34($b_calculosCompetencias))
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Eval02_Literal:351;aNta1;[Alumnos_Calificaciones:208]P05_Eval02_Literal:351;aNta2;[Alumnos_Calificaciones:208]P05_Eval03_Literal:356;aNta3;[Alumnos_Calificaciones:208]P05_Eval04_Literal:361;aNta4;[Alumnos_Calificaciones:208]P05_Eval05_Literal:366;aNta5;[Alumnos_Calificaciones:208]P05_Eval06_Literal:371;aNta6;[Alumnos_Calificaciones:208]P05_Eval07_Literal:376;aNta7;[Alumnos_Calificaciones:208]P05_Eval08_Literal:381;aNta8;[Alumnos_Calificaciones:208]P05_Eval09_Literal:386;aNta9;[Alumnos_Calificaciones:208]P05_Eval10_Literal:391;aNta10;[Alumnos_Calificaciones:208]P05_Eval11_Literal:396;aNta11;[Alumnos_Calificaciones:208]P05_Eval12_Literal:401;aNta12;[Alumnos_Calificaciones:208]P05_Control_Literal:411;aNtaEXP;[Alumnos_Calificaciones:208]P05_Presentacion_Literal:406;aNtaPresentP;[Alumnos_Calificaciones:208]P05_Bonificacion_Literal:534;aNtaBX)
		Else 
			EV2_InitArrays (Size of array:C274(aNtaIDAlumno))
		End if 
End case 

EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
$r_minimoEscala:=rPointsFrom
$t_formatoParciales:=EV2_ALT_FormatoString (iPointsDec)
$t_formatoPP:=EV2_ALT_FormatoString (iPointsDecPP)
$t_formatoPF:=EV2_ALT_FormatoString (iPointsDecPF)
$t_formatoNF:=EV2_ALT_FormatoString (iPointsDecNF)

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

