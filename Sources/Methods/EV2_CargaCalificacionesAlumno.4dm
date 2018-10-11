//%attributes = {}
  // Método: EV2_CargaCalificacionesAlumno
  //
  //
  // por Alberto Bachler Klein
  // creación 23/07/17, 11:59:59
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($aNivelJerarquico;$aRecNum;$idAsignaturas;$l_modoReales;$l_periodos)


If (False:C215)
	C_LONGINT:C283(EV2_CargaCalificacionesAlumno ;$1)
	C_LONGINT:C283(EV2_CargaCalificacionesAlumno ;$2)
End if 

$l_modoReales:=$1
$l_periodos:=$2
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)


Case of 
	: ($l_modoReales=Notas)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aNtaRecNum;[Alumnos_Calificaciones:208]Llave_principal:1;at_KeyEvaluacionPrincipal;[Alumnos_Calificaciones:208]ID_Alumno:6;aNtaIDAlumno;\
			[Alumnos_Calificaciones:208]NoDeLista:10;aNtaOrden;[Asignaturas:18]Asignatura:3;aNtaAsignatura;[Asignaturas:18]denominacion_interna:16;aNtaInternalName;[Asignaturas:18]ordenGeneral:105;at_OrdenAsignaturas;\
			[Asignaturas:18]Numero_de_EstiloEvaluacion:39;aNtaEvStyleID;[Asignaturas:18]Incide_en_promedio:27;aIncide;[Asignaturas:18]Sector:9;aSector;\
			[Asignaturas:18]Electiva:11;aElectiva;[Asignaturas:18]Abreviación:26;aNtaAsgAbrev;[Alumnos:2]apellidos_y_nombres:40;aNtaStdNme;[Alumnos:2]curso:20;aNtaCurso;[Alumnos:2]Status:50;aNtaStatus;\
			[Asignaturas_SintesisAnual:202]PromedioFinal_Nota:16;aRealAsgAverage;[Asignaturas_SintesisAnual:202]PromedioFinal_Literal:19;aSTRAsgAverage;[Asignaturas:18]Incluida_en_Actas:44;ab_AsgOficial;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aNtaRecNum;[Alumnos_Calificaciones:208]Llave_principal:1;at_KeyEvaluacionPrincipal;[Alumnos_Calificaciones:208]ID_Alumno:6;aNtaIDAlumno;[Alumnos_Calificaciones:208]NoDeLista:10;aNtaOrden;\
			[Alumnos_Calificaciones:208]Reprobada:9;aNtaReprobada;[Alumnos_Calificaciones:208]P01_Final_Nota:113;aRealNtaP1;[Alumnos_Calificaciones:208]P02_Final_Nota:188;aRealNtaP2;[Alumnos_Calificaciones:208]P03_Final_Nota:263;aRealNtaP3;\
			[Alumnos_Calificaciones:208]P04_Final_Nota:338;aRealNtaP4;[Alumnos_Calificaciones:208]P05_Final_Nota:413;aRealNtaP5;[Alumnos_Calificaciones:208]P01_Final_Literal:116;aNtaP1;[Alumnos_Calificaciones:208]P02_Final_Literal:191;aNtaP2;\
			[Alumnos_Calificaciones:208]P03_Final_Literal:266;aNtaP3;[Alumnos_Calificaciones:208]P04_Final_Literal:341;aNtaP4;[Alumnos_Calificaciones:208]P05_Final_Literal:416;aNtaP5;[Alumnos_Calificaciones:208]Anual_Nota:12;aRealNtaPF;\
			[Alumnos_Calificaciones:208]ExamenAnual_Nota:17;aRealNtaEX;[Alumnos_Calificaciones:208]ExamenExtra_Nota:22;aRealNtaEXX;[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;aRealNtaF;\
			[Alumnos_Calificaciones:208]Anual_Literal:15;aNtaPF;[Alumnos_Calificaciones:208]ExamenAnual_Literal:20;aNtaEX;[Alumnos_Calificaciones:208]ExamenExtra_Literal:25;aNtaEXX;[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;aNtaF;\
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;aRealNtaOficial;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;aNtaOf;[Asignaturas_SintesisAnual:202]PromedioFinal_Literal:19;aSTRAsgAverage;[Asignaturas_SintesisAnual:202]PromedioFinal_Nota:16;aRealAsgAverage;*)
		
		Case of 
			: ($l_periodos=1)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Eval01_Nota:43;aRealNta1;[Alumnos_Calificaciones:208]P01_Eval02_Nota:48;aRealNta2;[Alumnos_Calificaciones:208]P01_Eval03_Nota:53;aRealNta3;[Alumnos_Calificaciones:208]P01_Eval04_Nota:58;aRealNta4;\
					[Alumnos_Calificaciones:208]P01_Eval05_Nota:63;aRealNta5;[Alumnos_Calificaciones:208]P01_Eval06_Nota:68;aRealNta6;[Alumnos_Calificaciones:208]P01_Eval07_Nota:73;aRealNta7;[Alumnos_Calificaciones:208]P01_Eval08_Nota:78;aRealNta8;\
					[Alumnos_Calificaciones:208]P01_Eval09_Nota:83;aRealNta9;[Alumnos_Calificaciones:208]P01_Eval10_Nota:88;aRealNta10;[Alumnos_Calificaciones:208]P01_Eval11_Nota:93;aRealNta11;[Alumnos_Calificaciones:208]P01_Eval12_Nota:98;aRealNta12;\
					[Alumnos_Calificaciones:208]P01_Control_Nota:108;aRealNtaEXP;[Alumnos_Calificaciones:208]P01_Presentacion_Nota:103;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16;aNtaEsfuerzo;\
					[Alumnos_ComplementoEvaluacion:209]P01_Inasistencias:18;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P01_Bonificacion_Nota:511;aRealNtaBX;\
					[Alumnos_Calificaciones:208]P01_Eval01_Literal:46;aNta1;[Alumnos_Calificaciones:208]P01_Eval02_Literal:51;aNta2;[Alumnos_Calificaciones:208]P01_Eval03_Literal:56;aNta3;[Alumnos_Calificaciones:208]P01_Eval04_Literal:61;aNta4;\
					[Alumnos_Calificaciones:208]P01_Eval05_Literal:66;aNta5;[Alumnos_Calificaciones:208]P01_Eval06_Literal:71;aNta6;[Alumnos_Calificaciones:208]P01_Eval07_Literal:76;aNta7;[Alumnos_Calificaciones:208]P01_Eval08_Literal:81;aNta8;\
					[Alumnos_Calificaciones:208]P01_Eval09_Literal:86;aNta9;[Alumnos_Calificaciones:208]P01_Eval10_Literal:91;aNta10;[Alumnos_Calificaciones:208]P01_Eval11_Literal:96;aNta11;[Alumnos_Calificaciones:208]P01_Eval12_Literal:101;aNta12;\
					[Alumnos_Calificaciones:208]P01_Control_Literal:111;aNtaEXP;[Alumnos_Calificaciones:208]P01_Presentacion_Literal:106;aNtaPresentP;[Alumnos_Calificaciones:208]P01_Bonificacion_Literal:514;aNtaBX;*)
			: ($l_periodos=2)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Eval01_Nota:118;aRealNta1;[Alumnos_Calificaciones:208]P02_Eval02_Nota:123;aRealNta2;[Alumnos_Calificaciones:208]P02_Eval03_Nota:128;aRealNta3;[Alumnos_Calificaciones:208]P02_Eval04_Nota:133;aRealNta4;\
					[Alumnos_Calificaciones:208]P02_Eval05_Nota:138;aRealNta5;[Alumnos_Calificaciones:208]P02_Eval06_Nota:143;aRealNta6;[Alumnos_Calificaciones:208]P02_Eval07_Nota:148;aRealNta7;[Alumnos_Calificaciones:208]P02_Eval08_Nota:153;aRealNta8;\
					[Alumnos_Calificaciones:208]P02_Eval09_Nota:158;aRealNta9;[Alumnos_Calificaciones:208]P02_Eval10_Nota:163;aRealNta10;[Alumnos_Calificaciones:208]P02_Eval11_Nota:168;aRealNta11;[Alumnos_Calificaciones:208]P02_Eval12_Nota:173;aRealNta12;\
					[Alumnos_Calificaciones:208]P02_Control_Nota:183;aRealNtaEXP;[Alumnos_Calificaciones:208]P02_Presentacion_Nota:178;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21;aNtaEsfuerzo;\
					[Alumnos_ComplementoEvaluacion:209]P02_Inasistencias:23;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P02_Bonificacion_Nota:516;aRealNtaBX;\
					[Alumnos_Calificaciones:208]P02_Eval01_Literal:121;aNta1;[Alumnos_Calificaciones:208]P02_Eval02_Literal:126;aNta2;[Alumnos_Calificaciones:208]P02_Eval03_Literal:131;aNta3;[Alumnos_Calificaciones:208]P02_Eval04_Literal:136;aNta4;\
					[Alumnos_Calificaciones:208]P02_Eval05_Literal:141;aNta5;[Alumnos_Calificaciones:208]P02_Eval06_Literal:146;aNta6;[Alumnos_Calificaciones:208]P02_Eval07_Literal:151;aNta7;[Alumnos_Calificaciones:208]P02_Eval08_Literal:156;aNta8;\
					[Alumnos_Calificaciones:208]P02_Eval09_Literal:161;aNta9;[Alumnos_Calificaciones:208]P02_Eval10_Literal:166;aNta10;[Alumnos_Calificaciones:208]P02_Eval11_Literal:171;aNta11;[Alumnos_Calificaciones:208]P02_Eval12_Literal:176;aNta12;\
					[Alumnos_Calificaciones:208]P02_Control_Literal:186;aNtaEXP;[Alumnos_Calificaciones:208]P02_Presentacion_Literal:181;aNtaPresentP;[Alumnos_Calificaciones:208]P02_Bonificacion_Literal:519;aNtaBX;*)
				
			: ($l_periodos=3)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Eval01_Nota:193;aRealNta1;[Alumnos_Calificaciones:208]P03_Eval02_Nota:198;aRealNta2;[Alumnos_Calificaciones:208]P03_Eval03_Nota:203;aRealNta3;[Alumnos_Calificaciones:208]P03_Eval04_Nota:208;aRealNta4;\
					[Alumnos_Calificaciones:208]P03_Eval05_Nota:213;aRealNta5;[Alumnos_Calificaciones:208]P03_Eval06_Nota:218;aRealNta6;[Alumnos_Calificaciones:208]P03_Eval07_Nota:223;aRealNta7;[Alumnos_Calificaciones:208]P03_Eval08_Nota:228;aRealNta8;\
					[Alumnos_Calificaciones:208]P03_Eval09_Nota:233;aRealNta9;[Alumnos_Calificaciones:208]P03_Eval10_Nota:238;aRealNta10;[Alumnos_Calificaciones:208]P03_Eval11_Nota:243;aRealNta11;[Alumnos_Calificaciones:208]P03_Eval12_Nota:248;aRealNta12;\
					[Alumnos_Calificaciones:208]P03_Control_Nota:258;aRealNtaEXP;[Alumnos_Calificaciones:208]P03_Presentacion_Nota:253;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26;aNtaEsfuerzo;\
					[Alumnos_ComplementoEvaluacion:209]P03_Inasistencias:28;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P03_Bonificacion_Nota:521;aRealNtaBX;\
					[Alumnos_Calificaciones:208]P03_Eval01_Literal:196;aNta1;[Alumnos_Calificaciones:208]P03_Eval02_Literal:201;aNta2;[Alumnos_Calificaciones:208]P03_Eval03_Literal:206;aNta3;[Alumnos_Calificaciones:208]P03_Eval04_Literal:211;aNta4;\
					[Alumnos_Calificaciones:208]P03_Eval05_Literal:216;aNta5;[Alumnos_Calificaciones:208]P03_Eval06_Literal:221;aNta6;[Alumnos_Calificaciones:208]P03_Eval07_Literal:226;aNta7;[Alumnos_Calificaciones:208]P03_Eval08_Literal:231;aNta8;\
					[Alumnos_Calificaciones:208]P03_Eval09_Literal:236;aNta9;[Alumnos_Calificaciones:208]P03_Eval10_Literal:241;aNta10;[Alumnos_Calificaciones:208]P03_Eval11_Literal:246;aNta11;[Alumnos_Calificaciones:208]P03_Eval12_Literal:251;aNta12;\
					[Alumnos_Calificaciones:208]P03_Control_Literal:261;aNtaEXP;[Alumnos_Calificaciones:208]P03_Presentacion_Literal:256;aNtaPresentP;[Alumnos_Calificaciones:208]P03_Bonificacion_Literal:524;aNtaBX;*)
				
			: ($l_periodos=4)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Eval01_Nota:268;aRealNta1;[Alumnos_Calificaciones:208]P04_Eval02_Nota:273;aRealNta2;[Alumnos_Calificaciones:208]P04_Eval03_Nota:278;aRealNta3;[Alumnos_Calificaciones:208]P04_Eval04_Nota:283;aRealNta4;\
					[Alumnos_Calificaciones:208]P04_Eval05_Nota:288;aRealNta5;[Alumnos_Calificaciones:208]P04_Eval06_Nota:293;aRealNta6;[Alumnos_Calificaciones:208]P04_Eval07_Nota:298;aRealNta7;[Alumnos_Calificaciones:208]P04_Eval08_Nota:303;aRealNta8;\
					[Alumnos_Calificaciones:208]P04_Eval09_Nota:308;aRealNta9;[Alumnos_Calificaciones:208]P04_Eval10_Nota:313;aRealNta10;[Alumnos_Calificaciones:208]P04_Eval11_Nota:318;aRealNta11;[Alumnos_Calificaciones:208]P04_Eval12_Nota:323;aRealNta12;\
					[Alumnos_Calificaciones:208]P04_Control_Nota:333;aRealNtaEXP;[Alumnos_Calificaciones:208]P04_Presentacion_Nota:328;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31;aNtaEsfuerzo;\
					[Alumnos_ComplementoEvaluacion:209]P04_Inasistencias:33;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P04_Bonificacion_Nota:526;aRealNtaBX;\
					[Alumnos_Calificaciones:208]P04_Eval01_Literal:271;aNta1;[Alumnos_Calificaciones:208]P04_Eval02_Literal:276;aNta2;[Alumnos_Calificaciones:208]P04_Eval03_Literal:281;aNta3;[Alumnos_Calificaciones:208]P04_Eval04_Literal:286;aNta4;\
					[Alumnos_Calificaciones:208]P04_Eval05_Literal:291;aNta5;[Alumnos_Calificaciones:208]P04_Eval06_Literal:296;aNta6;[Alumnos_Calificaciones:208]P04_Eval07_Literal:301;aNta7;[Alumnos_Calificaciones:208]P04_Eval08_Literal:306;aNta8;\
					[Alumnos_Calificaciones:208]P04_Eval09_Literal:311;aNta9;[Alumnos_Calificaciones:208]P04_Eval10_Literal:316;aNta10;[Alumnos_Calificaciones:208]P04_Eval11_Literal:321;aNta11;[Alumnos_Calificaciones:208]P04_Eval12_Literal:326;aNta12;\
					[Alumnos_Calificaciones:208]P04_Control_Literal:336;aNtaEXP;[Alumnos_Calificaciones:208]P04_Presentacion_Literal:331;aNtaPresentP;[Alumnos_Calificaciones:208]P04_Bonificacion_Literal:529;aNtaBX)
				
			: ($l_periodos=5)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Eval01_Nota:343;aRealNta1;[Alumnos_Calificaciones:208]P05_Eval02_Nota:348;aRealNta2;[Alumnos_Calificaciones:208]P05_Eval03_Nota:353;aRealNta3;[Alumnos_Calificaciones:208]P05_Eval04_Nota:358;aRealNta4;\
					[Alumnos_Calificaciones:208]P05_Eval05_Nota:363;aRealNta5;[Alumnos_Calificaciones:208]P05_Eval06_Nota:368;aRealNta6;[Alumnos_Calificaciones:208]P05_Eval07_Nota:373;aRealNta7;[Alumnos_Calificaciones:208]P05_Eval08_Nota:378;aRealNta8;\
					[Alumnos_Calificaciones:208]P05_Eval09_Nota:383;aRealNta9;[Alumnos_Calificaciones:208]P05_Eval10_Nota:388;aRealNta10;[Alumnos_Calificaciones:208]P05_Eval11_Nota:393;aRealNta11;[Alumnos_Calificaciones:208]P05_Eval12_Nota:398;aRealNta12;\
					[Alumnos_Calificaciones:208]P05_Control_Nota:408;aRealNtaEXP;[Alumnos_Calificaciones:208]P05_Presentacion_Nota:403;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36;aNtaEsfuerzo;\
					[Alumnos_ComplementoEvaluacion:209]P05_Inasistencias:38;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P05_Bonificacion_Nota:531;aRealNtaBX;\
					[Alumnos_Calificaciones:208]P05_Eval01_Literal:346;aNta1;[Alumnos_Calificaciones:208]P05_Eval02_Literal:351;aNta2;[Alumnos_Calificaciones:208]P05_Eval03_Literal:356;aNta3;[Alumnos_Calificaciones:208]P05_Eval04_Literal:361;aNta4;\
					[Alumnos_Calificaciones:208]P05_Eval05_Literal:366;aNta5;[Alumnos_Calificaciones:208]P05_Eval06_Literal:371;aNta6;[Alumnos_Calificaciones:208]P05_Eval07_Literal:376;aNta7;[Alumnos_Calificaciones:208]P05_Eval08_Literal:381;aNta8;\
					[Alumnos_Calificaciones:208]P05_Eval09_Literal:386;aNta9;[Alumnos_Calificaciones:208]P05_Eval10_Literal:391;aNta10;[Alumnos_Calificaciones:208]P05_Eval11_Literal:396;aNta11;[Alumnos_Calificaciones:208]P05_Eval12_Literal:401;aNta12;\
					[Alumnos_Calificaciones:208]P05_Control_Literal:411;aNtaEXP;[Alumnos_Calificaciones:208]P05_Presentacion_Literal:406;aNtaPresentP;[Alumnos_Calificaciones:208]P05_Bonificacion_Literal:534;aNtaBX;*)
		End case 
		SELECTION TO ARRAY:C260
		
		
	: ($l_modoReales=Puntos)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aNtaRecNum;[Alumnos_Calificaciones:208]Llave_principal:1;at_KeyEvaluacionPrincipal;[Alumnos_Calificaciones:208]ID_Alumno:6;aNtaIDAlumno;[Alumnos_Calificaciones:208]NoDeLista:10;aNtaOrden;\
			[Asignaturas:18]Asignatura:3;aNtaAsignatura;[Asignaturas:18]denominacion_interna:16;aNtaInternalName;[Asignaturas:18]ordenGeneral:105;at_OrdenAsignaturas;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;aNtaEvStyleID;[Asignaturas:18]Incide_en_promedio:27;aIncide;[Asignaturas:18]Sector:9;aSector;\
			[Asignaturas:18]Electiva:11;aElectiva;[Asignaturas:18]Abreviación:26;aNtaAsgAbrev;[Alumnos:2]apellidos_y_nombres:40;aNtaStdNme;[Alumnos:2]curso:20;aNtaCurso;[Alumnos:2]Status:50;aNtaStatus;\
			[Asignaturas_SintesisAnual:202]PromedioFinal_Puntos:17;aRealAsgAverage;[Asignaturas_SintesisAnual:202]PromedioFinal_Literal:19;aSTRAsgAverage;[Asignaturas:18]Incluida_en_Actas:44;ab_AsgOficial;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aNtaRecNum;[Alumnos_Calificaciones:208]Llave_principal:1;at_KeyEvaluacionPrincipal;[Alumnos_Calificaciones:208]ID_Alumno:6;aNtaIDAlumno;[Alumnos_Calificaciones:208]NoDeLista:10;aNtaOrden;\
			[Alumnos_Calificaciones:208]Reprobada:9;aNtaReprobada;[Alumnos_Calificaciones:208]P01_Final_Puntos:114;aRealNtaP1;[Alumnos_Calificaciones:208]P02_Final_Puntos:189;aRealNtaP2;[Alumnos_Calificaciones:208]P03_Final_Puntos:264;aRealNtaP3;\
			[Alumnos_Calificaciones:208]P04_Final_Puntos:339;aRealNtaP4;[Alumnos_Calificaciones:208]P05_Final_Puntos:414;aRealNtaP5;[Alumnos_Calificaciones:208]P01_Final_Literal:116;aNtaP1;[Alumnos_Calificaciones:208]P02_Final_Literal:191;aNtaP2;\
			[Alumnos_Calificaciones:208]P03_Final_Literal:266;aNtaP3;[Alumnos_Calificaciones:208]P04_Final_Literal:341;aNtaP4;[Alumnos_Calificaciones:208]P05_Final_Literal:416;aNtaP5;[Alumnos_Calificaciones:208]Anual_Puntos:13;aRealNtaPF;\
			[Alumnos_Calificaciones:208]ExamenAnual_Puntos:18;aRealNtaEX;[Alumnos_Calificaciones:208]ExamenExtra_Puntos:23;aRealNtaEXX;[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28;aRealNtaF;\
			[Alumnos_Calificaciones:208]Anual_Literal:15;aNtaPF;[Alumnos_Calificaciones:208]ExamenAnual_Literal:20;aNtaEX;[Alumnos_Calificaciones:208]ExamenExtra_Literal:25;aNtaEXX;[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;aNtaF;\
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;aRealNtaOficial;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;aNtaOf;[Asignaturas_SintesisAnual:202]PromedioFinal_Literal:19;aSTRAsgAverage;[Asignaturas_SintesisAnual:202]PromedioFinal_Puntos:17;aRealAsgAverage;*)
		Case of 
			: ($l_periodos=1)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Eval01_Puntos:44;aRealNta1;[Alumnos_Calificaciones:208]P01_Eval02_Puntos:49;aRealNta2;[Alumnos_Calificaciones:208]P01_Eval03_Puntos:54;aRealNta3;[Alumnos_Calificaciones:208]P01_Eval04_Puntos:59;aRealNta4;\
					[Alumnos_Calificaciones:208]P01_Eval05_Puntos:64;aRealNta5;[Alumnos_Calificaciones:208]P01_Eval06_Puntos:69;aRealNta6;[Alumnos_Calificaciones:208]P01_Eval07_Puntos:74;aRealNta7;[Alumnos_Calificaciones:208]P01_Eval08_Puntos:79;aRealNta8;\
					[Alumnos_Calificaciones:208]P01_Eval09_Puntos:84;aRealNta9;[Alumnos_Calificaciones:208]P01_Eval10_Puntos:89;aRealNta10;[Alumnos_Calificaciones:208]P01_Eval11_Puntos:94;aRealNta11;[Alumnos_Calificaciones:208]P01_Eval12_Puntos:99;aRealNta12;\
					[Alumnos_Calificaciones:208]P01_Control_Puntos:109;aRealNtaEXP;[Alumnos_Calificaciones:208]P01_Presentacion_Puntos:104;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16;aNtaEsfuerzo;\
					[Alumnos_ComplementoEvaluacion:209]P01_Inasistencias:18;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P01_Bonificacion_Puntos:512;aRealNtaBX;\
					[Alumnos_Calificaciones:208]P01_Eval01_Literal:46;aNta1;[Alumnos_Calificaciones:208]P01_Eval02_Literal:51;aNta2;[Alumnos_Calificaciones:208]P01_Eval03_Literal:56;aNta3;[Alumnos_Calificaciones:208]P01_Eval04_Literal:61;aNta4;\
					[Alumnos_Calificaciones:208]P01_Eval05_Literal:66;aNta5;[Alumnos_Calificaciones:208]P01_Eval06_Literal:71;aNta6;[Alumnos_Calificaciones:208]P01_Eval07_Literal:76;aNta7;[Alumnos_Calificaciones:208]P01_Eval08_Literal:81;aNta8;\
					[Alumnos_Calificaciones:208]P01_Eval09_Literal:86;aNta9;[Alumnos_Calificaciones:208]P01_Eval10_Literal:91;aNta10;[Alumnos_Calificaciones:208]P01_Eval11_Literal:96;aNta11;[Alumnos_Calificaciones:208]P01_Eval12_Literal:101;aNta12;\
					[Alumnos_Calificaciones:208]P01_Control_Literal:111;aNtaEXP;[Alumnos_Calificaciones:208]P01_Presentacion_Literal:106;aNtaPresentP;[Alumnos_Calificaciones:208]P01_Bonificacion_Literal:514;aNtaBX;*)
			: ($l_periodos=2)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Eval01_Puntos:119;aRealNta1;[Alumnos_Calificaciones:208]P02_Eval02_Puntos:124;aRealNta2;[Alumnos_Calificaciones:208]P02_Eval03_Puntos:129;aRealNta3;[Alumnos_Calificaciones:208]P02_Eval04_Puntos:134;aRealNta4;\
					[Alumnos_Calificaciones:208]P02_Eval05_Puntos:139;aRealNta5;[Alumnos_Calificaciones:208]P02_Eval06_Puntos:144;aRealNta6;[Alumnos_Calificaciones:208]P02_Eval07_Puntos:149;aRealNta7;[Alumnos_Calificaciones:208]P02_Eval08_Puntos:154;aRealNta8;\
					[Alumnos_Calificaciones:208]P02_Eval09_Puntos:159;aRealNta9;[Alumnos_Calificaciones:208]P02_Eval10_Puntos:164;aRealNta10;[Alumnos_Calificaciones:208]P02_Eval11_Puntos:169;aRealNta11;[Alumnos_Calificaciones:208]P02_Eval12_Puntos:174;aRealNta12;\
					[Alumnos_Calificaciones:208]P02_Control_Puntos:184;aRealNtaEXP;[Alumnos_Calificaciones:208]P02_Presentacion_Puntos:179;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21;aNtaEsfuerzo;\
					[Alumnos_ComplementoEvaluacion:209]P02_Inasistencias:23;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P02_Bonificacion_Puntos:517;aRealNtaBX;\
					[Alumnos_Calificaciones:208]P02_Eval01_Literal:121;aNta1;[Alumnos_Calificaciones:208]P02_Eval02_Literal:126;aNta2;[Alumnos_Calificaciones:208]P02_Eval03_Literal:131;aNta3;[Alumnos_Calificaciones:208]P02_Eval04_Literal:136;aNta4;\
					[Alumnos_Calificaciones:208]P02_Eval05_Literal:141;aNta5;[Alumnos_Calificaciones:208]P02_Eval06_Literal:146;aNta6;[Alumnos_Calificaciones:208]P02_Eval07_Literal:151;aNta7;[Alumnos_Calificaciones:208]P02_Eval08_Literal:156;aNta8;\
					[Alumnos_Calificaciones:208]P02_Eval09_Literal:161;aNta9;[Alumnos_Calificaciones:208]P02_Eval10_Literal:166;aNta10;[Alumnos_Calificaciones:208]P02_Eval11_Literal:171;aNta11;[Alumnos_Calificaciones:208]P02_Eval12_Literal:176;aNta12;\
					[Alumnos_Calificaciones:208]P02_Control_Literal:186;aNtaEXP;[Alumnos_Calificaciones:208]P02_Presentacion_Literal:181;aNtaPresentP;[Alumnos_Calificaciones:208]P02_Bonificacion_Literal:519;aNtaBX;*)
				
			: ($l_periodos=3)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Eval01_Puntos:194;aRealNta1;[Alumnos_Calificaciones:208]P03_Eval02_Puntos:199;aRealNta2;[Alumnos_Calificaciones:208]P03_Eval03_Puntos:204;aRealNta3;[Alumnos_Calificaciones:208]P03_Eval04_Puntos:209;aRealNta4;\
					[Alumnos_Calificaciones:208]P03_Eval05_Puntos:214;aRealNta5;[Alumnos_Calificaciones:208]P03_Eval06_Puntos:219;aRealNta6;[Alumnos_Calificaciones:208]P03_Eval07_Puntos:224;aRealNta7;[Alumnos_Calificaciones:208]P03_Eval08_Puntos:229;aRealNta8;\
					[Alumnos_Calificaciones:208]P03_Eval09_Puntos:234;aRealNta9;[Alumnos_Calificaciones:208]P03_Eval10_Puntos:239;aRealNta10;[Alumnos_Calificaciones:208]P03_Eval11_Puntos:244;aRealNta11;[Alumnos_Calificaciones:208]P03_Eval12_Puntos:249;aRealNta12;\
					[Alumnos_Calificaciones:208]P03_Control_Puntos:259;aRealNtaEXP;[Alumnos_Calificaciones:208]P03_Presentacion_Puntos:254;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26;aNtaEsfuerzo;\
					[Alumnos_ComplementoEvaluacion:209]P03_Inasistencias:28;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P03_Bonificacion_Puntos:522;aRealNtaBX;\
					[Alumnos_Calificaciones:208]P03_Eval01_Literal:196;aNta1;[Alumnos_Calificaciones:208]P03_Eval02_Literal:201;aNta2;[Alumnos_Calificaciones:208]P03_Eval03_Literal:206;aNta3;[Alumnos_Calificaciones:208]P03_Eval04_Literal:211;aNta4;\
					[Alumnos_Calificaciones:208]P03_Eval05_Literal:216;aNta5;[Alumnos_Calificaciones:208]P03_Eval06_Literal:221;aNta6;[Alumnos_Calificaciones:208]P03_Eval07_Literal:226;aNta7;[Alumnos_Calificaciones:208]P03_Eval08_Literal:231;aNta8;\
					[Alumnos_Calificaciones:208]P03_Eval09_Literal:236;aNta9;[Alumnos_Calificaciones:208]P03_Eval10_Literal:241;aNta10;[Alumnos_Calificaciones:208]P03_Eval11_Literal:246;aNta11;[Alumnos_Calificaciones:208]P03_Eval12_Literal:251;aNta12;\
					[Alumnos_Calificaciones:208]P03_Control_Literal:261;aNtaEXP;[Alumnos_Calificaciones:208]P03_Presentacion_Literal:256;aNtaPresentP;[Alumnos_Calificaciones:208]P03_Bonificacion_Literal:524;aNtaBX;*)
				
			: ($l_periodos=4)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Eval01_Puntos:269;aRealNta1;[Alumnos_Calificaciones:208]P04_Eval02_Puntos:274;aRealNta2;[Alumnos_Calificaciones:208]P04_Eval03_Puntos:279;aRealNta3;[Alumnos_Calificaciones:208]P04_Eval04_Puntos:284;aRealNta4;\
					[Alumnos_Calificaciones:208]P04_Eval05_Puntos:289;aRealNta5;[Alumnos_Calificaciones:208]P04_Eval06_Puntos:294;aRealNta6;[Alumnos_Calificaciones:208]P04_Eval07_Puntos:299;aRealNta7;[Alumnos_Calificaciones:208]P04_Eval08_Puntos:304;aRealNta8;\
					[Alumnos_Calificaciones:208]P04_Eval09_Puntos:309;aRealNta9;[Alumnos_Calificaciones:208]P04_Eval10_Puntos:314;aRealNta10;[Alumnos_Calificaciones:208]P04_Eval11_Puntos:319;aRealNta11;[Alumnos_Calificaciones:208]P04_Eval12_Puntos:324;aRealNta12;\
					[Alumnos_Calificaciones:208]P04_Control_Puntos:334;aRealNtaEXP;[Alumnos_Calificaciones:208]P04_Presentacion_Puntos:329;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31;aNtaEsfuerzo;\
					[Alumnos_ComplementoEvaluacion:209]P04_Inasistencias:33;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P04_Bonificacion_Puntos:527;aRealNtaBX;\
					[Alumnos_Calificaciones:208]P04_Eval01_Literal:271;aNta1;[Alumnos_Calificaciones:208]P04_Eval02_Literal:276;aNta2;[Alumnos_Calificaciones:208]P04_Eval03_Literal:281;aNta3;[Alumnos_Calificaciones:208]P04_Eval04_Literal:286;aNta4;\
					[Alumnos_Calificaciones:208]P04_Eval05_Literal:291;aNta5;[Alumnos_Calificaciones:208]P04_Eval06_Literal:296;aNta6;[Alumnos_Calificaciones:208]P04_Eval07_Literal:301;aNta7;[Alumnos_Calificaciones:208]P04_Eval08_Literal:306;aNta8;\
					[Alumnos_Calificaciones:208]P04_Eval09_Literal:311;aNta9;[Alumnos_Calificaciones:208]P04_Eval10_Literal:316;aNta10;[Alumnos_Calificaciones:208]P04_Eval11_Literal:321;aNta11;[Alumnos_Calificaciones:208]P04_Eval12_Literal:326;aNta12;\
					[Alumnos_Calificaciones:208]P04_Control_Literal:336;aNtaEXP;[Alumnos_Calificaciones:208]P04_Presentacion_Literal:331;aNtaPresentP;[Alumnos_Calificaciones:208]P04_Bonificacion_Literal:529;aNtaBX)
				
			: ($l_periodos=5)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Eval01_Puntos:344;aRealNta1;[Alumnos_Calificaciones:208]P05_Eval02_Puntos:349;aRealNta2;[Alumnos_Calificaciones:208]P05_Eval03_Puntos:354;aRealNta3;[Alumnos_Calificaciones:208]P05_Eval04_Puntos:359;aRealNta4;\
					[Alumnos_Calificaciones:208]P05_Eval05_Puntos:364;aRealNta5;[Alumnos_Calificaciones:208]P05_Eval06_Puntos:369;aRealNta6;[Alumnos_Calificaciones:208]P05_Eval07_Puntos:374;aRealNta7;[Alumnos_Calificaciones:208]P05_Eval08_Puntos:379;aRealNta8;\
					[Alumnos_Calificaciones:208]P05_Eval09_Puntos:384;aRealNta9;[Alumnos_Calificaciones:208]P05_Eval10_Puntos:389;aRealNta10;[Alumnos_Calificaciones:208]P05_Eval11_Puntos:394;aRealNta11;[Alumnos_Calificaciones:208]P05_Eval12_Puntos:399;aRealNta12;\
					[Alumnos_Calificaciones:208]P05_Control_Puntos:409;aRealNtaEXP;[Alumnos_Calificaciones:208]P05_Presentacion_Puntos:404;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36;aNtaEsfuerzo;\
					[Alumnos_ComplementoEvaluacion:209]P05_Inasistencias:38;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P05_Bonificacion_Puntos:532;aRealNtaBX;\
					[Alumnos_Calificaciones:208]P05_Eval01_Literal:346;aNta1;[Alumnos_Calificaciones:208]P05_Eval02_Literal:351;aNta2;[Alumnos_Calificaciones:208]P05_Eval03_Literal:356;aNta3;[Alumnos_Calificaciones:208]P05_Eval04_Literal:361;aNta4;\
					[Alumnos_Calificaciones:208]P05_Eval05_Literal:366;aNta5;[Alumnos_Calificaciones:208]P05_Eval06_Literal:371;aNta6;[Alumnos_Calificaciones:208]P05_Eval07_Literal:376;aNta7;[Alumnos_Calificaciones:208]P05_Eval08_Literal:381;aNta8;\
					[Alumnos_Calificaciones:208]P05_Eval09_Literal:386;aNta9;[Alumnos_Calificaciones:208]P05_Eval10_Literal:391;aNta10;[Alumnos_Calificaciones:208]P05_Eval11_Literal:396;aNta11;[Alumnos_Calificaciones:208]P05_Eval12_Literal:401;aNta12;\
					[Alumnos_Calificaciones:208]P05_Control_Literal:411;aNtaEXP;[Alumnos_Calificaciones:208]P05_Presentacion_Literal:406;aNtaPresentP;[Alumnos_Calificaciones:208]P05_Bonificacion_Literal:534;aNtaBX;*)
		End case 
		SELECTION TO ARRAY:C260
		
		
	Else 
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aNtaRecNum;[Alumnos_Calificaciones:208]Llave_principal:1;at_KeyEvaluacionPrincipal;[Alumnos_Calificaciones:208]ID_Alumno:6;aNtaIDAlumno;[Alumnos_Calificaciones:208]NoDeLista:10;aNtaOrden;\
			[Asignaturas:18]Asignatura:3;aNtaAsignatura;[Asignaturas:18]denominacion_interna:16;aNtaInternalName;[Asignaturas:18]ordenGeneral:105;at_OrdenAsignaturas;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;aNtaEvStyleID;[Asignaturas:18]Incide_en_promedio:27;aIncide;[Asignaturas:18]Sector:9;aSector;\
			[Asignaturas:18]Electiva:11;aElectiva;[Asignaturas:18]Abreviación:26;aNtaAsgAbrev;[Alumnos:2]apellidos_y_nombres:40;aNtaStdNme;[Alumnos:2]curso:20;aNtaCurso;[Alumnos:2]Status:50;aNtaStatus;\
			[Asignaturas_SintesisAnual:202]PromedioFinal_Real:15;aRealAsgAverage;[Asignaturas_SintesisAnual:202]PromedioFinal_Literal:19;aSTRAsgAverage;[Asignaturas:18]Incluida_en_Actas:44;ab_AsgOficial;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aNtaRecNum;[Alumnos_Calificaciones:208]Llave_principal:1;at_KeyEvaluacionPrincipal;[Alumnos_Calificaciones:208]ID_Alumno:6;aNtaIDAlumno;[Alumnos_Calificaciones:208]NoDeLista:10;aNtaOrden;\
			[Alumnos_Calificaciones:208]Reprobada:9;aNtaReprobada;[Alumnos_Calificaciones:208]P01_Final_Real:112;aRealNtaP1;[Alumnos_Calificaciones:208]P02_Final_Real:187;aRealNtaP2;[Alumnos_Calificaciones:208]P03_Final_Real:262;aRealNtaP3;\
			[Alumnos_Calificaciones:208]P04_Final_Real:337;aRealNtaP4;[Alumnos_Calificaciones:208]P05_Final_Real:412;aRealNtaP5;[Alumnos_Calificaciones:208]P01_Final_Literal:116;aNtaP1;[Alumnos_Calificaciones:208]P02_Final_Literal:191;aNtaP2;\
			[Alumnos_Calificaciones:208]P03_Final_Literal:266;aNtaP3;[Alumnos_Calificaciones:208]P04_Final_Literal:341;aNtaP4;[Alumnos_Calificaciones:208]P05_Final_Literal:416;aNtaP5;[Alumnos_Calificaciones:208]Anual_Real:11;aRealNtaPF;\
			[Alumnos_Calificaciones:208]ExamenAnual_Real:16;aRealNtaEX;[Alumnos_Calificaciones:208]ExamenExtra_Real:21;aRealNtaEXX;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;aRealNtaF;\
			[Alumnos_Calificaciones:208]Anual_Literal:15;aNtaPF;[Alumnos_Calificaciones:208]ExamenAnual_Literal:20;aNtaEX;[Alumnos_Calificaciones:208]ExamenExtra_Literal:25;aNtaEXX;[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;aNtaF;\
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;aRealNtaOficial;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;aNtaOf;[Asignaturas_SintesisAnual:202]PromedioFinal_Literal:19;aSTRAsgAverage;[Asignaturas_SintesisAnual:202]PromedioFinal_Real:15;aRealAsgAverage;*)
		
		Case of 
			: ($l_periodos=1)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Eval01_Real:42;aRealNta1;[Alumnos_Calificaciones:208]P01_Eval02_Real:47;aRealNta2;[Alumnos_Calificaciones:208]P01_Eval03_Real:52;aRealNta3;[Alumnos_Calificaciones:208]P01_Eval04_Real:57;aRealNta4;\
					[Alumnos_Calificaciones:208]P01_Eval05_Real:62;aRealNta5;[Alumnos_Calificaciones:208]P01_Eval06_Real:67;aRealNta6;[Alumnos_Calificaciones:208]P01_Eval07_Real:72;aRealNta7;[Alumnos_Calificaciones:208]P01_Eval08_Real:77;aRealNta8;\
					[Alumnos_Calificaciones:208]P01_Eval09_Real:82;aRealNta9;[Alumnos_Calificaciones:208]P01_Eval10_Real:87;aRealNta10;[Alumnos_Calificaciones:208]P01_Eval11_Real:92;aRealNta11;[Alumnos_Calificaciones:208]P01_Eval12_Real:97;aRealNta12;\
					[Alumnos_Calificaciones:208]P01_Control_Real:107;aRealNtaEXP;[Alumnos_Calificaciones:208]P01_Presentacion_Real:102;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16;aNtaEsfuerzo;\
					[Alumnos_ComplementoEvaluacion:209]P01_Inasistencias:18;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P01_Bonificacion_Real:510;aRealNtaBX;\
					[Alumnos_Calificaciones:208]P01_Eval01_Literal:46;aNta1;[Alumnos_Calificaciones:208]P01_Eval02_Literal:51;aNta2;[Alumnos_Calificaciones:208]P01_Eval03_Literal:56;aNta3;[Alumnos_Calificaciones:208]P01_Eval04_Literal:61;aNta4;\
					[Alumnos_Calificaciones:208]P01_Eval05_Literal:66;aNta5;[Alumnos_Calificaciones:208]P01_Eval06_Literal:71;aNta6;[Alumnos_Calificaciones:208]P01_Eval07_Literal:76;aNta7;[Alumnos_Calificaciones:208]P01_Eval08_Literal:81;aNta8;\
					[Alumnos_Calificaciones:208]P01_Eval09_Literal:86;aNta9;[Alumnos_Calificaciones:208]P01_Eval10_Literal:91;aNta10;[Alumnos_Calificaciones:208]P01_Eval11_Literal:96;aNta11;[Alumnos_Calificaciones:208]P01_Eval12_Literal:101;aNta12;\
					[Alumnos_Calificaciones:208]P01_Control_Literal:111;aNtaEXP;[Alumnos_Calificaciones:208]P01_Presentacion_Literal:106;aNtaPresentP;[Alumnos_Calificaciones:208]P01_Bonificacion_Literal:514;aNtaBX;*)
			: ($l_periodos=2)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Eval01_Real:117;aRealNta1;[Alumnos_Calificaciones:208]P02_Eval02_Real:122;aRealNta2;[Alumnos_Calificaciones:208]P02_Eval03_Real:127;aRealNta3;[Alumnos_Calificaciones:208]P02_Eval04_Real:132;aRealNta4;\
					[Alumnos_Calificaciones:208]P02_Eval05_Real:137;aRealNta5;[Alumnos_Calificaciones:208]P02_Eval06_Real:142;aRealNta6;[Alumnos_Calificaciones:208]P02_Eval07_Real:147;aRealNta7;[Alumnos_Calificaciones:208]P02_Eval08_Real:152;aRealNta8;\
					[Alumnos_Calificaciones:208]P02_Eval09_Real:157;aRealNta9;[Alumnos_Calificaciones:208]P02_Eval10_Real:162;aRealNta10;[Alumnos_Calificaciones:208]P02_Eval11_Real:167;aRealNta11;[Alumnos_Calificaciones:208]P02_Eval12_Real:172;aRealNta12;\
					[Alumnos_Calificaciones:208]P02_Control_Real:182;aRealNtaEXP;[Alumnos_Calificaciones:208]P02_Presentacion_Real:177;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21;aNtaEsfuerzo;\
					[Alumnos_ComplementoEvaluacion:209]P02_Inasistencias:23;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P02_Bonificacion_Real:515;aRealNtaBX;\
					[Alumnos_Calificaciones:208]P02_Eval01_Literal:121;aNta1;[Alumnos_Calificaciones:208]P02_Eval02_Literal:126;aNta2;[Alumnos_Calificaciones:208]P02_Eval03_Literal:131;aNta3;[Alumnos_Calificaciones:208]P02_Eval04_Literal:136;aNta4;\
					[Alumnos_Calificaciones:208]P02_Eval05_Literal:141;aNta5;[Alumnos_Calificaciones:208]P02_Eval06_Literal:146;aNta6;[Alumnos_Calificaciones:208]P02_Eval07_Literal:151;aNta7;[Alumnos_Calificaciones:208]P02_Eval08_Literal:156;aNta8;\
					[Alumnos_Calificaciones:208]P02_Eval09_Literal:161;aNta9;[Alumnos_Calificaciones:208]P02_Eval10_Literal:166;aNta10;[Alumnos_Calificaciones:208]P02_Eval11_Literal:171;aNta11;[Alumnos_Calificaciones:208]P02_Eval12_Literal:176;aNta12;\
					[Alumnos_Calificaciones:208]P02_Control_Literal:186;aNtaEXP;[Alumnos_Calificaciones:208]P02_Presentacion_Literal:181;aNtaPresentP;[Alumnos_Calificaciones:208]P02_Bonificacion_Literal:519;aNtaBX;*)
				
			: ($l_periodos=3)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Eval01_Real:192;aRealNta1;[Alumnos_Calificaciones:208]P03_Eval02_Real:197;aRealNta2;[Alumnos_Calificaciones:208]P03_Eval03_Real:202;aRealNta3;[Alumnos_Calificaciones:208]P03_Eval04_Real:207;aRealNta4;\
					[Alumnos_Calificaciones:208]P03_Eval05_Real:212;aRealNta5;[Alumnos_Calificaciones:208]P03_Eval06_Real:217;aRealNta6;[Alumnos_Calificaciones:208]P03_Eval07_Real:222;aRealNta7;[Alumnos_Calificaciones:208]P03_Eval08_Real:227;aRealNta8;\
					[Alumnos_Calificaciones:208]P03_Eval09_Real:232;aRealNta9;[Alumnos_Calificaciones:208]P03_Eval10_Real:237;aRealNta10;[Alumnos_Calificaciones:208]P03_Eval11_Real:242;aRealNta11;[Alumnos_Calificaciones:208]P03_Eval12_Real:247;aRealNta12;\
					[Alumnos_Calificaciones:208]P03_Control_Real:257;aRealNtaEXP;[Alumnos_Calificaciones:208]P03_Presentacion_Real:252;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26;aNtaEsfuerzo;\
					[Alumnos_ComplementoEvaluacion:209]P03_Inasistencias:28;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P03_Bonificacion_Real:520;aRealNtaBX;\
					[Alumnos_Calificaciones:208]P03_Eval01_Literal:196;aNta1;[Alumnos_Calificaciones:208]P03_Eval02_Literal:201;aNta2;[Alumnos_Calificaciones:208]P03_Eval03_Literal:206;aNta3;[Alumnos_Calificaciones:208]P03_Eval04_Literal:211;aNta4;\
					[Alumnos_Calificaciones:208]P03_Eval05_Literal:216;aNta5;[Alumnos_Calificaciones:208]P03_Eval06_Literal:221;aNta6;[Alumnos_Calificaciones:208]P03_Eval07_Literal:226;aNta7;[Alumnos_Calificaciones:208]P03_Eval08_Literal:231;aNta8;\
					[Alumnos_Calificaciones:208]P03_Eval09_Literal:236;aNta9;[Alumnos_Calificaciones:208]P03_Eval10_Literal:241;aNta10;[Alumnos_Calificaciones:208]P03_Eval11_Literal:246;aNta11;[Alumnos_Calificaciones:208]P03_Eval12_Literal:251;aNta12;\
					[Alumnos_Calificaciones:208]P03_Control_Literal:261;aNtaEXP;[Alumnos_Calificaciones:208]P03_Presentacion_Literal:256;aNtaPresentP;[Alumnos_Calificaciones:208]P03_Bonificacion_Literal:524;aNtaBX;*)
				
			: ($l_periodos=4)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Eval01_Real:267;aRealNta1;[Alumnos_Calificaciones:208]P04_Eval02_Real:272;aRealNta2;[Alumnos_Calificaciones:208]P04_Eval03_Real:277;aRealNta3;[Alumnos_Calificaciones:208]P04_Eval04_Real:282;aRealNta4;\
					[Alumnos_Calificaciones:208]P04_Eval05_Real:287;aRealNta5;[Alumnos_Calificaciones:208]P04_Eval06_Real:292;aRealNta6;[Alumnos_Calificaciones:208]P04_Eval07_Real:297;aRealNta7;[Alumnos_Calificaciones:208]P04_Eval08_Real:302;aRealNta8;\
					[Alumnos_Calificaciones:208]P04_Eval09_Real:307;aRealNta9;[Alumnos_Calificaciones:208]P04_Eval10_Real:312;aRealNta10;[Alumnos_Calificaciones:208]P04_Eval11_Real:317;aRealNta11;[Alumnos_Calificaciones:208]P04_Eval12_Real:322;aRealNta12;\
					[Alumnos_Calificaciones:208]P04_Control_Real:332;aRealNtaEXP;[Alumnos_Calificaciones:208]P04_Presentacion_Real:327;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31;aNtaEsfuerzo;\
					[Alumnos_ComplementoEvaluacion:209]P04_Inasistencias:33;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P04_Bonificacion_Real:525;aRealNtaBX;\
					[Alumnos_Calificaciones:208]P04_Eval01_Literal:271;aNta1;[Alumnos_Calificaciones:208]P04_Eval02_Literal:276;aNta2;[Alumnos_Calificaciones:208]P04_Eval03_Literal:281;aNta3;[Alumnos_Calificaciones:208]P04_Eval04_Literal:286;aNta4;\
					[Alumnos_Calificaciones:208]P04_Eval05_Literal:291;aNta5;[Alumnos_Calificaciones:208]P04_Eval06_Literal:296;aNta6;[Alumnos_Calificaciones:208]P04_Eval07_Literal:301;aNta7;[Alumnos_Calificaciones:208]P04_Eval08_Literal:306;aNta8;\
					[Alumnos_Calificaciones:208]P04_Eval09_Literal:311;aNta9;[Alumnos_Calificaciones:208]P04_Eval10_Literal:316;aNta10;[Alumnos_Calificaciones:208]P04_Eval11_Literal:321;aNta11;[Alumnos_Calificaciones:208]P04_Eval12_Literal:326;aNta12;\
					[Alumnos_Calificaciones:208]P04_Control_Literal:336;aNtaEXP;[Alumnos_Calificaciones:208]P04_Presentacion_Literal:331;aNtaPresentP;[Alumnos_Calificaciones:208]P04_Bonificacion_Literal:529;aNtaBX)
				
			: ($l_periodos=5)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Eval01_Real:342;aRealNta1;[Alumnos_Calificaciones:208]P05_Eval02_Real:347;aRealNta2;[Alumnos_Calificaciones:208]P05_Eval03_Real:352;aRealNta3;[Alumnos_Calificaciones:208]P05_Eval04_Real:357;aRealNta4;\
					[Alumnos_Calificaciones:208]P05_Eval05_Real:362;aRealNta5;[Alumnos_Calificaciones:208]P05_Eval06_Real:367;aRealNta6;[Alumnos_Calificaciones:208]P05_Eval07_Real:372;aRealNta7;[Alumnos_Calificaciones:208]P05_Eval08_Real:377;aRealNta8;\
					[Alumnos_Calificaciones:208]P05_Eval09_Real:382;aRealNta9;[Alumnos_Calificaciones:208]P05_Eval10_Real:387;aRealNta10;[Alumnos_Calificaciones:208]P05_Eval11_Real:392;aRealNta11;[Alumnos_Calificaciones:208]P05_Eval12_Real:397;aRealNta12;\
					[Alumnos_Calificaciones:208]P05_Control_Real:407;aRealNtaEXP;[Alumnos_Calificaciones:208]P05_Presentacion_Real:402;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36;aNtaEsfuerzo;\
					[Alumnos_ComplementoEvaluacion:209]P05_Inasistencias:38;alSTR_InasistenciasPeriodo;[Alumnos_Calificaciones:208]P05_Bonificacion_Real:530;aRealNtaBX;\
					[Alumnos_Calificaciones:208]P05_Eval01_Literal:346;aNta1;[Alumnos_Calificaciones:208]P05_Eval02_Literal:351;aNta2;[Alumnos_Calificaciones:208]P05_Eval03_Literal:356;aNta3;[Alumnos_Calificaciones:208]P05_Eval04_Literal:361;aNta4;\
					[Alumnos_Calificaciones:208]P05_Eval05_Literal:366;aNta5;[Alumnos_Calificaciones:208]P05_Eval06_Literal:371;aNta6;[Alumnos_Calificaciones:208]P05_Eval07_Literal:376;aNta7;[Alumnos_Calificaciones:208]P05_Eval08_Literal:381;aNta8;\
					[Alumnos_Calificaciones:208]P05_Eval09_Literal:386;aNta9;[Alumnos_Calificaciones:208]P05_Eval10_Literal:391;aNta10;[Alumnos_Calificaciones:208]P05_Eval11_Literal:396;aNta11;[Alumnos_Calificaciones:208]P05_Eval12_Literal:401;aNta12;\
					[Alumnos_Calificaciones:208]P05_Control_Literal:411;aNtaEXP;[Alumnos_Calificaciones:208]P05_Presentacion_Literal:406;aNtaPresentP;[Alumnos_Calificaciones:208]P05_Bonificacion_Literal:534;aNtaBX;*)
		End case 
		SELECTION TO ARRAY:C260
		
End case 
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

