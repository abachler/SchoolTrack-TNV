//%attributes = {}
  //EV2_LeeCalificaciones


  //DECLARACIONES & INICIALIZACIONES
C_LONGINT:C283($idAsignatura;$1;$periodo;$2;$recNum;$styleID;$4)
C_POINTER:C301($convertTo;$3)
C_BOOLEAN:C305(vb_NotaOficialVisible)  //<---- no sacar... requerido por STWA!!!
$idAsignatura:=$1
$periodo:=$2

$convertTo:=->iViewMode
Case of 
	: (Count parameters:C259=4)
		$convertTo:=$3
		$styleID:=$4
	: (Count parameters:C259>=3)
		$convertTo:=$3
		iViewMode:=$convertTo->
End case 


  //CUERPO
EV2_InitArrays 
PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
EV2_Examenes_LeeConfigExamenes ($periodo)
EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6;>)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)

SET FIELD RELATION:C919([Alumnos_SintesisAnual:210]ID_Alumno:4;Automatic:K51:4;Automatic:K51:4)
SET FIELD RELATION:C919([Alumnos:2]numero:1;Automatic:K51:4;Automatic:K51:4)

SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aNtaRecNum;[Alumnos_Calificaciones:208]Llave_principal:1;at_KeyEvaluacionPrincipal;[Alumnos_Calificaciones:208]ID_Alumno:6;aNtaIDAlumno;*)
SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;aNtaStdNme;[Alumnos:2]curso:20;aNtaCurso;[Alumnos_Calificaciones:208]NoDeLista:10;aNtaOrden;[Alumnos:2]Status:50;aNtaStatus;[Alumnos_Calificaciones:208]Reprobada:9;aNtaReprobada;*)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Real:112;aRealNtaP1;[Alumnos_Calificaciones:208]P02_Final_Real:187;aRealNtaP2;[Alumnos_Calificaciones:208]P03_Final_Real:262;aRealNtaP3;*)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Final_Real:337;aRealNtaP4;[Alumnos_Calificaciones:208]P05_Final_Real:412;aRealNtaP5;[Alumnos_Calificaciones:208]P01_Final_Literal:116;aNtaP1;*)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Final_Literal:191;aNtaP2;[Alumnos_Calificaciones:208]P03_Final_Literal:266;aNtaP3;[Alumnos_Calificaciones:208]P04_Final_Literal:341;aNtaP4;*)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Final_Literal:416;aNtaP5;[Alumnos_Calificaciones:208]Anual_Real:11;aRealNtaPF;[Alumnos_Calificaciones:208]ExamenAnual_Real:16;aRealNtaEX;*)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;aRealNtaF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;aRealNtaOficial;[Alumnos_Calificaciones:208]Anual_Literal:15;aNtaPF;*)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ExamenAnual_Literal:20;aNtaEX;[Alumnos_Calificaciones:208]ExamenExtra_Real:21;aRealNtaEXX;[Alumnos_Calificaciones:208]ExamenExtra_Literal:25;aNtaEXX;*)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;aNtaF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;aNtaOf;[Alumnos_Calificaciones:208]AutoEval_Literal:41;aNtaAutoEval;[Alumnos_Calificaciones:208]AutoEval_Real:37;aRealNtaAutoEval;*)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]PTC_Literal:539;aNtaPTC_literal;[Alumnos_Calificaciones:208]PTC_Real:535;aNtaPTC_real;[Alumnos_Calificaciones:208]PTC_Nota:536;aNtaPTC_Nota;[Alumnos_Calificaciones:208]PTC_Puntos:537;aNtaPTC_Puntos;[Alumnos_Calificaciones:208]PTC_Simbolos:538;aNtaPTC_simbolos;*)
SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209]Eximicion_NoRegistro:8;aNtaRegEximicion;*)

SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95;aRealEXRecuperatorio;[Alumnos:2]Sexo:49;aSexoAlumnos;*)
SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]Condicionalidad_Activada:57;aBoolCondicional;*)

SELECTION TO ARRAY:C260

SET FIELD RELATION:C919([Alumnos_SintesisAnual:210]ID_Alumno:4;Structure configuration:K51:2;Structure configuration:K51:2)
SET FIELD RELATION:C919([Alumnos:2]numero:1;Structure configuration:K51:2;Structure configuration:K51:2)

$calculosSobreCompetencias:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9)

Case of 
	: ($periodo=1)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Eval01_Real:42;aRealNta1;[Alumnos_Calificaciones:208]P01_Eval02_Real:47;aRealNta2;[Alumnos_Calificaciones:208]P01_Eval03_Real:52;aRealNta3;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Eval04_Real:57;aRealNta4;[Alumnos_Calificaciones:208]P01_Eval05_Real:62;aRealNta5;[Alumnos_Calificaciones:208]P01_Eval06_Real:67;aRealNta6;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Eval07_Real:72;aRealNta7;[Alumnos_Calificaciones:208]P01_Eval08_Real:77;aRealNta8;[Alumnos_Calificaciones:208]P01_Eval09_Real:82;aRealNta9;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Eval10_Real:87;aRealNta10;[Alumnos_Calificaciones:208]P01_Eval11_Real:92;aRealNta11;[Alumnos_Calificaciones:208]P01_Eval12_Real:97;aRealNta12;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Control_Real:107;aRealNtaEXP;[Alumnos_Calificaciones:208]P01_Presentacion_Real:102;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16;aNtaEsfuerzo;*)
		SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209]P01_Inasistencias:18;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P01_Bonificacion_Real:510;aRealNtaBX;*)
		SELECTION TO ARRAY:C260
		
		If (Not:C34($calculosSobreCompetencias))
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Eval01_Literal:46;aNta1;[Alumnos_Calificaciones:208]P01_Eval02_Literal:51;aNta2;[Alumnos_Calificaciones:208]P01_Eval03_Literal:56;aNta3;*)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Eval04_Literal:61;aNta4;[Alumnos_Calificaciones:208]P01_Eval05_Literal:66;aNta5;[Alumnos_Calificaciones:208]P01_Eval06_Literal:71;aNta6;*)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Eval07_Literal:76;aNta7;[Alumnos_Calificaciones:208]P01_Eval08_Literal:81;aNta8;[Alumnos_Calificaciones:208]P01_Eval09_Literal:86;aNta9;*)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Eval10_Literal:91;aNta10;[Alumnos_Calificaciones:208]P01_Eval11_Literal:96;aNta11;[Alumnos_Calificaciones:208]P01_Eval12_Literal:101;aNta12;*)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Control_Literal:111;aNtaEXP;[Alumnos_Calificaciones:208]P01_Presentacion_Literal:106;aNtaPresentP;[Alumnos_Calificaciones:208]P01_Bonificacion_Literal:514;aNtaBX;*)
			SELECTION TO ARRAY:C260
		Else 
			EV2_InitArrays (Size of array:C274(aNtaIDAlumno))
		End if 
		
	: ($periodo=2)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Eval01_Real:117;aRealNta1;[Alumnos_Calificaciones:208]P02_Eval02_Real:122;aRealNta2;[Alumnos_Calificaciones:208]P02_Eval03_Real:127;aRealNta3;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Eval04_Real:132;aRealNta4;[Alumnos_Calificaciones:208]P02_Eval05_Real:137;aRealNta5;[Alumnos_Calificaciones:208]P02_Eval06_Real:142;aRealNta6;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Eval07_Real:147;aRealNta7;[Alumnos_Calificaciones:208]P02_Eval08_Real:152;aRealNta8;[Alumnos_Calificaciones:208]P02_Eval09_Real:157;aRealNta9;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Eval10_Real:162;aRealNta10;[Alumnos_Calificaciones:208]P02_Eval11_Real:167;aRealNta11;[Alumnos_Calificaciones:208]P02_Eval12_Real:172;aRealNta12;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Control_Real:182;aRealNtaEXP;[Alumnos_Calificaciones:208]P02_Presentacion_Real:177;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21;aNtaEsfuerzo;*)
		SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209]P02_Inasistencias:23;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P02_Bonificacion_Real:515;aRealNtaBX;*)
		SELECTION TO ARRAY:C260
		
		If (Not:C34($calculosSobreCompetencias))
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Eval01_Literal:121;aNta1;[Alumnos_Calificaciones:208]P02_Eval02_Literal:126;aNta2;[Alumnos_Calificaciones:208]P02_Eval03_Literal:131;aNta3;*)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Eval04_Literal:136;aNta4;[Alumnos_Calificaciones:208]P02_Eval05_Literal:141;aNta5;[Alumnos_Calificaciones:208]P02_Eval06_Literal:146;aNta6;*)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Eval07_Literal:151;aNta7;[Alumnos_Calificaciones:208]P02_Eval08_Literal:156;aNta8;[Alumnos_Calificaciones:208]P02_Eval09_Literal:161;aNta9;*)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Eval10_Literal:166;aNta10;[Alumnos_Calificaciones:208]P02_Eval11_Literal:171;aNta11;[Alumnos_Calificaciones:208]P02_Eval12_Literal:176;aNta12;*)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Control_Literal:186;aNtaEXP;[Alumnos_Calificaciones:208]P02_Presentacion_Literal:181;aNtaPresentP;[Alumnos_Calificaciones:208]P02_Bonificacion_Literal:519;aNtaBX;*)
			SELECTION TO ARRAY:C260
		Else 
			EV2_InitArrays (Size of array:C274(aNtaIDAlumno))
		End if 
		
	: ($periodo=3)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Eval01_Real:192;aRealNta1;[Alumnos_Calificaciones:208]P03_Eval02_Real:197;aRealNta2;[Alumnos_Calificaciones:208]P03_Eval03_Real:202;aRealNta3;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Eval04_Real:207;aRealNta4;[Alumnos_Calificaciones:208]P03_Eval05_Real:212;aRealNta5;[Alumnos_Calificaciones:208]P03_Eval06_Real:217;aRealNta6;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Eval07_Real:222;aRealNta7;[Alumnos_Calificaciones:208]P03_Eval08_Real:227;aRealNta8;[Alumnos_Calificaciones:208]P03_Eval09_Real:232;aRealNta9;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Eval10_Real:237;aRealNta10;[Alumnos_Calificaciones:208]P03_Eval11_Real:242;aRealNta11;[Alumnos_Calificaciones:208]P03_Eval12_Real:247;aRealNta12;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Control_Real:257;aRealNtaEXP;[Alumnos_Calificaciones:208]P03_Presentacion_Real:252;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26;aNtaEsfuerzo;*)
		SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209]P03_Inasistencias:28;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P03_Bonificacion_Real:520;aRealNtaBX;*)
		SELECTION TO ARRAY:C260
		If (Not:C34($calculosSobreCompetencias))
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Eval01_Literal:196;aNta1;[Alumnos_Calificaciones:208]P03_Eval02_Literal:201;aNta2;[Alumnos_Calificaciones:208]P03_Eval03_Literal:206;aNta3;*)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Eval04_Literal:211;aNta4;[Alumnos_Calificaciones:208]P03_Eval05_Literal:216;aNta5;[Alumnos_Calificaciones:208]P03_Eval06_Literal:221;aNta6;*)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Eval07_Literal:226;aNta7;[Alumnos_Calificaciones:208]P03_Eval08_Literal:231;aNta8;[Alumnos_Calificaciones:208]P03_Eval09_Literal:236;aNta9;*)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Eval10_Literal:241;aNta10;[Alumnos_Calificaciones:208]P03_Eval11_Literal:246;aNta11;[Alumnos_Calificaciones:208]P03_Eval12_Literal:251;aNta12;*)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Control_Literal:261;aNtaEXP;[Alumnos_Calificaciones:208]P03_Presentacion_Literal:256;aNtaPresentP;[Alumnos_Calificaciones:208]P03_Bonificacion_Literal:524;aNtaBX;*)
			SELECTION TO ARRAY:C260
		Else 
			EV2_InitArrays (Size of array:C274(aNtaIDAlumno))
		End if 
		
	: ($periodo=4)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Eval01_Real:267;aRealNta1;[Alumnos_Calificaciones:208]P04_Eval02_Real:272;aRealNta2;[Alumnos_Calificaciones:208]P04_Eval03_Real:277;aRealNta3;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Eval04_Real:282;aRealNta4;[Alumnos_Calificaciones:208]P04_Eval05_Real:287;aRealNta5;[Alumnos_Calificaciones:208]P04_Eval06_Real:292;aRealNta6;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Eval07_Real:297;aRealNta7;[Alumnos_Calificaciones:208]P04_Eval08_Real:302;aRealNta8;[Alumnos_Calificaciones:208]P04_Eval09_Real:307;aRealNta9;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Eval10_Real:312;aRealNta10;[Alumnos_Calificaciones:208]P04_Eval11_Real:317;aRealNta11;[Alumnos_Calificaciones:208]P04_Eval12_Real:322;aRealNta12;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Control_Real:332;aRealNtaEXP;[Alumnos_Calificaciones:208]P04_Presentacion_Real:327;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31;aNtaEsfuerzo;*)
		SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209]P04_Inasistencias:33;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P04_Bonificacion_Real:525;aRealNtaBX;*)
		SELECTION TO ARRAY:C260
		If (Not:C34($calculosSobreCompetencias))
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Eval01_Literal:271;aNta1;[Alumnos_Calificaciones:208]P04_Eval02_Literal:276;aNta2;[Alumnos_Calificaciones:208]P04_Eval03_Literal:281;aNta3;*)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Eval04_Literal:286;aNta4;[Alumnos_Calificaciones:208]P04_Eval05_Literal:291;aNta5;[Alumnos_Calificaciones:208]P04_Eval06_Literal:296;aNta6;*)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Eval07_Literal:301;aNta7;[Alumnos_Calificaciones:208]P04_Eval08_Literal:306;aNta8;[Alumnos_Calificaciones:208]P04_Eval09_Literal:311;aNta9;*)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Eval10_Literal:316;aNta10;[Alumnos_Calificaciones:208]P04_Eval11_Literal:321;aNta11;[Alumnos_Calificaciones:208]P04_Eval12_Literal:326;aNta12;*)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Control_Literal:336;aNtaEXP;[Alumnos_Calificaciones:208]P04_Presentacion_Literal:331;aNtaPresentP;[Alumnos_Calificaciones:208]P04_Bonificacion_Literal:529;aNtaBX;*)
			SELECTION TO ARRAY:C260
		Else 
			EV2_InitArrays (Size of array:C274(aNtaIDAlumno))
		End if 
		
	: ($periodo=5)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Eval01_Real:342;aRealNta1;[Alumnos_Calificaciones:208]P05_Eval02_Real:347;aRealNta2;[Alumnos_Calificaciones:208]P05_Eval03_Real:352;aRealNta3;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Eval04_Real:357;aRealNta4;[Alumnos_Calificaciones:208]P05_Eval05_Real:362;aRealNta5;[Alumnos_Calificaciones:208]P05_Eval06_Real:367;aRealNta6;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Eval07_Real:372;aRealNta7;[Alumnos_Calificaciones:208]P05_Eval08_Real:377;aRealNta8;[Alumnos_Calificaciones:208]P05_Eval09_Real:382;aRealNta9;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Eval10_Real:387;aRealNta10;[Alumnos_Calificaciones:208]P05_Eval11_Real:392;aRealNta11;[Alumnos_Calificaciones:208]P05_Eval12_Real:397;aRealNta12;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Control_Real:407;aRealNtaEXP;[Alumnos_Calificaciones:208]P05_Presentacion_Real:402;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36;aNtaEsfuerzo;*)
		SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209]P05_Inasistencias:38;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P05_Bonificacion_Real:530;aRealNtaBX;*)
		SELECTION TO ARRAY:C260
		If (Not:C34($calculosSobreCompetencias))
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Eval01_Literal:346;aNta1;[Alumnos_Calificaciones:208]P05_Eval02_Literal:351;aNta2;[Alumnos_Calificaciones:208]P05_Eval03_Literal:356;aNta3;*)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Eval04_Literal:361;aNta4;[Alumnos_Calificaciones:208]P05_Eval05_Literal:366;aNta5;[Alumnos_Calificaciones:208]P05_Eval06_Literal:371;aNta6;*)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Eval07_Literal:376;aNta7;[Alumnos_Calificaciones:208]P05_Eval08_Literal:381;aNta8;[Alumnos_Calificaciones:208]P05_Eval09_Literal:386;aNta9;*)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Eval10_Literal:391;aNta10;[Alumnos_Calificaciones:208]P05_Eval11_Literal:396;aNta11;[Alumnos_Calificaciones:208]P05_Eval12_Literal:401;aNta12;*)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Control_Literal:411;aNtaEXP;[Alumnos_Calificaciones:208]P05_Presentacion_Literal:406;aNtaPresentP;[Alumnos_Calificaciones:208]P05_Bonificacion_Literal:534;aNtaBX;*)
			SELECTION TO ARRAY:C260
		Else 
			EV2_InitArrays (Size of array:C274(aNtaIDAlumno))
		End if 
		
End case 


SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)





If (iViewMode#iPrintMode)
	NTA_ModeConversion (iPrintMode;iViewMode)
End if 

  //If (iEvaluationMode#iViewMode)
  //NTA_ModeConversion (iEvaluationMode;iViewMode)
  //End if 

COPY ARRAY:C226(aNtaIDAlumno;aCpyIDAlumno)
COPY ARRAY:C226(aNta1;aCpyNta1)
COPY ARRAY:C226(aNta2;aCpyNta2)
COPY ARRAY:C226(aNta3;aCpyNta3)
COPY ARRAY:C226(aNta4;aCpyNta4)
COPY ARRAY:C226(aNta5;aCpyNta5)
COPY ARRAY:C226(aNta6;aCpyNta6)
COPY ARRAY:C226(aNta7;aCpyNta7)
COPY ARRAY:C226(aNta8;aCpyNta8)
COPY ARRAY:C226(aNta9;aCpyNta9)
COPY ARRAY:C226(aNta10;aCpyNta10)
COPY ARRAY:C226(aNta11;aCpyNta11)
COPY ARRAY:C226(aNta12;aCpyNta12)
COPY ARRAY:C226(aNtaEXP;aCpyNtaEXP)
COPY ARRAY:C226(aNtaP1;aCpyNtaP1)
COPY ARRAY:C226(aNtaP2;aCpyNtaP2)
COPY ARRAY:C226(aNtaP3;aCpyNtaP3)
COPY ARRAY:C226(aNtaP4;aCpyNtaP4)
COPY ARRAY:C226(aNtaP5;aCpyNtaP5)
COPY ARRAY:C226(aNtaPF;aCpyNtaPF)
COPY ARRAY:C226(aNtaEX;aCpyNtaEX)
COPY ARRAY:C226(aNtaF;aCpyNtaF)
COPY ARRAY:C226(aNtaEXX;aCpyNtaEXX)
COPY ARRAY:C226(aNtaEsfuerzo;aCpyNtaEsfuerzo)

AT_ResizeArrays (->aStrAsgAverage;Size of array:C274(aRealNtaF))
AT_ResizeArrays (->aRealAsgAverage;Size of array:C274(aRealNtaF))


ARRAY REAL:C219(aRealNtaEsfuerzo;0)
ARRAY REAL:C219(aRealNtaEsfuerzo;Size of array:C274(aNtaEsfuerzo))
dummy:=0
AT_Populate (->aRealNtaEsfuerzo;->dummy)
For ($t;1;Size of array:C274(aNtaEsfuerzo))
	$found:=Find in array:C230(aIndEsfuerzo;aNtaEsfuerzo{$t})
	If ($found>0)
		aRealNtaEsfuerzo{$t}:=aFactorEsfuerzo{$found}/100
	End if 
End for 

If (vb_NotaOficialVisible=False:C215)
	For ($i;1;Size of array:C274(aNtaOf))
		If (aNtaOf{$i}#aNtaF{$i})
			vb_NotaOficialVisible:=True:C214
			$i:=Size of array:C274(aNtaOf)+1
		End if 
	End for 
End if 

$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Asignaturas:18]Numero:1)
$recNum:=KRL_FindAndLoadRecordByIndex (->[Asignaturas_SintesisAnual:202]LLavePrimaria:5;->$key;True:C214)
If ($recNum>=0)
	vs_FooterText:=__ ("Media\rMínima\rMáxima")
	vs_avg1:=NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]P01_Promedio_Real:25;$convertTo->)+"\r"+NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]P01_Minimo_Real:50;$convertTo->)+"\r"+NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]P01_Maximo_Real:85;$convertTo->)
	vs_avg2:=NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]P02_Promedio_Real:30;$convertTo->)+"\r"+NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]P02_Minimo_Real:51;$convertTo->)+"\r"+NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]P02_Maximo_Real:86;$convertTo->)
	vs_avg3:=NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]P03_Promedio_Real:35;$convertTo->)+"\r"+NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]P03_Minimo_Real:52;$convertTo->)+"\r"+NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]P03_Maximo_Real:87;$convertTo->)
	vs_avg4:=NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]P04_Promedio_Real:40;$convertTo->)+"\r"+NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]P04_Minimo_Real:53;$convertTo->)+"\r"+NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]P04_Maximo_Real:88;$convertTo->)
	vs_avg5:=NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]P05_Promedio_Real:45;$convertTo->)+"\r"+NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]P05_Minimo_Real:54;$convertTo->)+"\r"+NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]P05_Maximo_Real:89;$convertTo->)
	vs_avgPF:=NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]PromedioAnual_Real:10;$convertTo->)+"\r"+NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]Anual_Minimo_Real:75;$convertTo->)+"\r"+NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]Anual_Maximo_Real:110;$convertTo->)
	vs_avgEX:=NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]Examen_Promedio_Real:132;$convertTo->)+"\r"+NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]Examen_Minimo_Real:122;$convertTo->)+"\r"+NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]Examen_Maximo_Real:127;$convertTo->)
	vs_avgNF:=NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]PromedioFinal_Real:15;$convertTo->)+"\r"+NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]PromedioFinal_Real:15;$convertTo->)+"\r"+NTA_PercentValue2StringValue ([Asignaturas_SintesisAnual:202]PromedioFinal_Real:15;$convertTo->)
Else 
	vs_FooterText:=__ ("Media\rMínima\rMáxima")
	vs_avg1:=""
	vs_avg2:=""
	vs_avg3:=""
	vs_avg4:=""
	vs_avg5:=""
	vs_avgPF:=""
	vs_avgEX:=""
	vs_avgNF:=""
End if 
