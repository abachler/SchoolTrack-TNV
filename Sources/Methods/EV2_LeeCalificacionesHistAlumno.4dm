//%attributes = {}
  //EV2_LeeCalificacionesHistAlumno
  // ----------------------------------------------------
  // User name (OS): Alberto Bachler
  // Date and time: 28/10/09, 06:48:08
  // ----------------------------------------------------
  // Method: EV2_LeeCalificacionesHistAlumno
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------


C_LONGINT:C283($1;$periodo;$2;$convertTo;$recNum;$styleID;$3;vi_SoloPromedioOficial)
C_BOOLEAN:C305($convertPercents;$4)
C_BOOLEAN:C305(vb_NotaOficialVisible)
C_BOOLEAN:C305($b_noMostrarPO)  //20180904 RCH Ticket 215184
$periodo:=$1

$convertPercents:=True:C214
Case of 
	: (Count parameters:C259=5)
		$nivel:=$5
		$convertPercents:=$4
		$styleID:=$3
		$convertTo:=$2
	: (Count parameters:C259=4)
		$convertPercents:=$4
		$styleID:=$3
		$convertTo:=$2
	: (Count parameters:C259=3)
		$convertTo:=$2
		$styleID:=$3
	: (Count parameters:C259>=2)
		$convertTo:=$2
End case 


If ($nivel=0)
	$nivel:=[Alumnos:2]nivel_numero:29
End if 


  //CUERPO
EV2_InitArrays 
PERIODOS_LeeDatosHistoricos ($nivel;vl_Year)

  //QUERY([Alumnos_SintesisAnual];[Alumnos_SintesisAnual]ID_Alumno;=;$nivel;*)
  //QUERY([Alumnos_SintesisAnual]; & ;[Alumnos_SintesisAnual]Año=vl_Year)
  //SELECTION TO ARRAY([Alumnos_SintesisAnual]NumeroNivel;$aNiveles)
  //SORT ARRAY($aNiveles;>)


EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;$nivel;vl_Year)
$recNumSintesis:=Record number:C243([Alumnos_SintesisAnual:210])

$keyHistoricoNivel:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6)+"."+String:C10(vl_Year)
$estiloEvaluacionOficial:=KRL_GetNumericFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$keyHistoricoNivel;->[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9)
$estiloEvaluacionInterno:=KRL_GetNumericFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$keyHistoricoNivel;->[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8)

$vx_EstiloEvaluacionInterno:=KRL_GetBlobFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->$estiloEvaluacionInterno;->[xxSTR_HistoricoEstilosEval:88]xData:6)
$vx_EstiloEvaluacionOficial:=KRL_GetBlobFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->$estiloEvaluacionOficial;->[xxSTR_HistoricoEstilosEval:88]xData:6)


SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
If (vi_SoloPromedioOficial=1)
	
End if 


Case of 
	: ((vi_SoloPromedioOficial=1) & (vi_SoloPromedioInterno=1))
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas_Historico:84]Promediable:6=True:C214;*)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & ;[Asignaturas_Historico:84]IncideEnPromedioInterno:27=True:C214)
	: (vi_SoloPromedioOficial=1)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas_Historico:84]Promediable:6=True:C214)
	: (vi_SoloPromedioInterno=1)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas_Historico:84]IncideEnPromedioInterno:27=True:C214)
End case 

ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas_Historico:84]OrdenGeneral:42;>)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aNtaRecNum;[Asignaturas_Historico:84]Nombre_interno:3;aNtaAsignatura;[Asignaturas_SintesisAnual:202]PromedioFinal_Real:15;aRealAsgAverage;[Asignaturas_Historico:84]OrdenGeneral:42;at_OrdenAsignaturas;[Asignaturas_Historico:84]Nombre_interno:3;aNtaInternalName;[Asignaturas_Historico:84]Promediable:6;aIncide;[Asignaturas_Historico:84]Sector:38;aSector;[Asignaturas_Historico:84]Electiva:10;aElectiva;[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25;aNtaEvStyleID;[Alumnos_Calificaciones:208]Llave_principal:1;at_KeyEvaluacionPrincipal;[Alumnos_Calificaciones:208]ID_Alumno:6;aNtaIDAlumno;[Alumnos:2]apellidos_y_nombres:40;aNtaStdNme;[Alumnos:2]curso:20;aNtaCurso;[Alumnos_Calificaciones:208]NoDeLista:10;aNtaOrden;[Alumnos:2]Status:50;aNtaStatus;[Alumnos_Calificaciones:208]Reprobada:9;aNtaReprobada;[Alumnos_Calificaciones:208]P01_Final_Real:112;aRealNtaP1;[Alumnos_Calificaciones:208]P02_Final_Real:187;aRealNtaP2;[Alumnos_Calificaciones:208]P03_Final_Real:262;aRealNtaP3;[Alumnos_Calificaciones:208]P04_Final_Real:337;aRealNtaP4;[Alumnos_Calificaciones:208]P05_Final_Real:412;aRealNtaP5;[Alumnos_Calificaciones:208]P01_Final_Literal:116;aNtaP1;[Alumnos_Calificaciones:208]P02_Final_Literal:191;aNtaP2;[Alumnos_Calificaciones:208]P03_Final_Literal:266;aNtaP3;[Alumnos_Calificaciones:208]P04_Final_Literal:341;aNtaP4;[Alumnos_Calificaciones:208]P05_Final_Literal:416;aNtaP5;[Alumnos_Calificaciones:208]Anual_Real:11;aRealNtaPF;[Alumnos_Calificaciones:208]ExamenAnual_Real:16;aRealNtaEX;[Alumnos_Calificaciones:208]ExamenExtra_Real:21;aRealNtaEXX;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;aRealNtaF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;aRealNtaOficial;[Alumnos_Calificaciones:208]Anual_Literal:15;aNtaPF;[Alumnos_Calificaciones:208]ExamenAnual_Literal:20;aNtaEX;[Alumnos_Calificaciones:208]ExamenExtra_Literal:25;aNtaEXX;[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;aNtaF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;aNtaOf;[Asignaturas_Historico:84]Incluida_En_Actas:7;ab_AsgOficial)
ARRAY LONGINT:C221($aNivelJerarquico;Size of array:C274(aNtaRecNum))
ARRAY TEXT:C222(aNtaAsgAbrev;Size of array:C274(aNtaRecNum))
For ($i;1;Size of array:C274(aNtaRecNum))
	$aNivelJerarquico{$i}:=ST_CountWords (at_OrdenAsignaturas{$i};0;".")-1
End for 



Case of 
	: ($periodo=1)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Eval01_Real:42;aRealNta1;[Alumnos_Calificaciones:208]P01_Eval02_Real:47;aRealNta2;[Alumnos_Calificaciones:208]P01_Eval03_Real:52;aRealNta3;[Alumnos_Calificaciones:208]P01_Eval04_Real:57;aRealNta4;[Alumnos_Calificaciones:208]P01_Eval05_Real:62;aRealNta5;[Alumnos_Calificaciones:208]P01_Eval06_Real:67;aRealNta6;[Alumnos_Calificaciones:208]P01_Eval07_Real:72;aRealNta7;[Alumnos_Calificaciones:208]P01_Eval08_Real:77;aRealNta8;[Alumnos_Calificaciones:208]P01_Eval09_Real:82;aRealNta9;[Alumnos_Calificaciones:208]P01_Eval10_Real:87;aRealNta10;[Alumnos_Calificaciones:208]P01_Eval11_Real:92;aRealNta11;[Alumnos_Calificaciones:208]P01_Eval12_Real:97;aRealNta12;[Alumnos_Calificaciones:208]P01_Control_Real:107;aRealNtaEXP;[Alumnos_Calificaciones:208]P01_Presentacion_Real:102;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16;aNtaEsfuerzo;[Alumnos_ComplementoEvaluacion:209]P01_Inasistencias:18;alSTR_InasistenciasPeriodo)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Eval01_Literal:46;aNta1;[Alumnos_Calificaciones:208]P01_Eval02_Literal:51;aNta2;[Alumnos_Calificaciones:208]P01_Eval03_Literal:56;aNta3;[Alumnos_Calificaciones:208]P01_Eval04_Literal:61;aNta4;[Alumnos_Calificaciones:208]P01_Eval05_Literal:66;aNta5;[Alumnos_Calificaciones:208]P01_Eval06_Literal:71;aNta6;[Alumnos_Calificaciones:208]P01_Eval07_Literal:76;aNta7;[Alumnos_Calificaciones:208]P01_Eval08_Literal:81;aNta8;[Alumnos_Calificaciones:208]P01_Eval09_Literal:86;aNta9;[Alumnos_Calificaciones:208]P01_Eval10_Literal:91;aNta10;[Alumnos_Calificaciones:208]P01_Eval11_Literal:96;aNta11;[Alumnos_Calificaciones:208]P01_Eval12_Literal:101;aNta12;[Alumnos_Calificaciones:208]P01_Control_Literal:111;aNtaEXP;[Alumnos_Calificaciones:208]P01_Presentacion_Literal:106;aNtaPresentP)
		
	: ($periodo=2)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Eval01_Real:117;aRealNta1;[Alumnos_Calificaciones:208]P02_Eval02_Real:122;aRealNta2;[Alumnos_Calificaciones:208]P02_Eval03_Real:127;aRealNta3;[Alumnos_Calificaciones:208]P02_Eval04_Real:132;aRealNta4;[Alumnos_Calificaciones:208]P02_Eval05_Real:137;aRealNta5;[Alumnos_Calificaciones:208]P02_Eval06_Real:142;aRealNta6;[Alumnos_Calificaciones:208]P02_Eval07_Real:147;aRealNta7;[Alumnos_Calificaciones:208]P02_Eval08_Real:152;aRealNta8;[Alumnos_Calificaciones:208]P02_Eval09_Real:157;aRealNta9;[Alumnos_Calificaciones:208]P02_Eval10_Real:162;aRealNta10;[Alumnos_Calificaciones:208]P02_Eval11_Real:167;aRealNta11;[Alumnos_Calificaciones:208]P02_Eval12_Real:172;aRealNta12;[Alumnos_Calificaciones:208]P02_Control_Real:182;aRealNtaEXP;[Alumnos_Calificaciones:208]P02_Presentacion_Real:177;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21;aNtaEsfuerzo;[Alumnos_ComplementoEvaluacion:209]P02_Inasistencias:23;alSTR_InasistenciasPeriodo)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Eval01_Literal:121;aNta1;[Alumnos_Calificaciones:208]P02_Eval02_Literal:126;aNta2;[Alumnos_Calificaciones:208]P02_Eval03_Literal:131;aNta3;[Alumnos_Calificaciones:208]P02_Eval04_Literal:136;aNta4;[Alumnos_Calificaciones:208]P02_Eval05_Literal:141;aNta5;[Alumnos_Calificaciones:208]P02_Eval06_Literal:146;aNta6;[Alumnos_Calificaciones:208]P02_Eval07_Literal:151;aNta7;[Alumnos_Calificaciones:208]P02_Eval08_Literal:156;aNta8;[Alumnos_Calificaciones:208]P02_Eval09_Literal:161;aNta9;[Alumnos_Calificaciones:208]P02_Eval10_Literal:166;aNta10;[Alumnos_Calificaciones:208]P02_Eval11_Literal:171;aNta11;[Alumnos_Calificaciones:208]P02_Eval12_Literal:176;aNta12;[Alumnos_Calificaciones:208]P02_Control_Literal:186;aNtaEXP;[Alumnos_Calificaciones:208]P02_Presentacion_Literal:181;aNtaPresentP)
		
	: ($periodo=3)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Eval01_Real:192;aRealNta1;[Alumnos_Calificaciones:208]P03_Eval02_Real:197;aRealNta2;[Alumnos_Calificaciones:208]P03_Eval03_Real:202;aRealNta3;[Alumnos_Calificaciones:208]P03_Eval04_Real:207;aRealNta4;[Alumnos_Calificaciones:208]P03_Eval05_Real:212;aRealNta5;[Alumnos_Calificaciones:208]P03_Eval06_Real:217;aRealNta6;[Alumnos_Calificaciones:208]P03_Eval07_Real:222;aRealNta7;[Alumnos_Calificaciones:208]P03_Eval08_Real:227;aRealNta8;[Alumnos_Calificaciones:208]P03_Eval09_Real:232;aRealNta9;[Alumnos_Calificaciones:208]P03_Eval10_Real:237;aRealNta10;[Alumnos_Calificaciones:208]P03_Eval11_Real:242;aRealNta11;[Alumnos_Calificaciones:208]P03_Eval12_Real:247;aRealNta12;[Alumnos_Calificaciones:208]P03_Control_Real:257;aRealNtaEXP;[Alumnos_Calificaciones:208]P03_Presentacion_Real:252;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26;aNtaEsfuerzo;[Alumnos_ComplementoEvaluacion:209]P03_Inasistencias:28;alSTR_InasistenciasPeriodo)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Eval01_Literal:196;aNta1;[Alumnos_Calificaciones:208]P03_Eval02_Literal:201;aNta2;[Alumnos_Calificaciones:208]P03_Eval03_Literal:206;aNta3;[Alumnos_Calificaciones:208]P03_Eval04_Literal:211;aNta4;[Alumnos_Calificaciones:208]P03_Eval05_Literal:216;aNta5;[Alumnos_Calificaciones:208]P03_Eval06_Literal:221;aNta6;[Alumnos_Calificaciones:208]P03_Eval07_Literal:226;aNta7;[Alumnos_Calificaciones:208]P03_Eval08_Literal:231;aNta8;[Alumnos_Calificaciones:208]P03_Eval09_Literal:236;aNta9;[Alumnos_Calificaciones:208]P03_Eval10_Literal:241;aNta10;[Alumnos_Calificaciones:208]P03_Eval11_Literal:246;aNta11;[Alumnos_Calificaciones:208]P03_Eval12_Literal:251;aNta12;[Alumnos_Calificaciones:208]P03_Control_Literal:261;aNtaEXP;[Alumnos_Calificaciones:208]P03_Presentacion_Literal:256;aNtaPresentP)
		
	: ($periodo=4)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Eval01_Real:267;aRealNta1;[Alumnos_Calificaciones:208]P04_Eval02_Real:272;aRealNta2;[Alumnos_Calificaciones:208]P04_Eval03_Real:277;aRealNta3;[Alumnos_Calificaciones:208]P04_Eval04_Real:282;aRealNta4;[Alumnos_Calificaciones:208]P04_Eval05_Real:287;aRealNta5;[Alumnos_Calificaciones:208]P04_Eval06_Real:292;aRealNta6;[Alumnos_Calificaciones:208]P04_Eval07_Real:297;aRealNta7;[Alumnos_Calificaciones:208]P04_Eval08_Real:302;aRealNta8;[Alumnos_Calificaciones:208]P04_Eval09_Real:307;aRealNta9;[Alumnos_Calificaciones:208]P04_Eval10_Real:312;aRealNta10;[Alumnos_Calificaciones:208]P04_Eval11_Real:317;aRealNta11;[Alumnos_Calificaciones:208]P04_Eval12_Real:322;aRealNta12;[Alumnos_Calificaciones:208]P04_Control_Real:332;aRealNtaEXP;[Alumnos_Calificaciones:208]P04_Presentacion_Real:327;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31;aNtaEsfuerzo;[Alumnos_ComplementoEvaluacion:209]P04_Inasistencias:33;alSTR_InasistenciasPeriodo)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Eval01_Literal:271;aNta1;[Alumnos_Calificaciones:208]P04_Eval02_Literal:276;aNta2;[Alumnos_Calificaciones:208]P04_Eval03_Literal:281;aNta3;[Alumnos_Calificaciones:208]P04_Eval04_Literal:286;aNta4;[Alumnos_Calificaciones:208]P04_Eval05_Literal:291;aNta5;[Alumnos_Calificaciones:208]P04_Eval06_Literal:296;aNta6;[Alumnos_Calificaciones:208]P04_Eval07_Literal:301;aNta7;[Alumnos_Calificaciones:208]P04_Eval08_Literal:306;aNta8;[Alumnos_Calificaciones:208]P04_Eval09_Literal:311;aNta9;[Alumnos_Calificaciones:208]P04_Eval10_Literal:316;aNta10;[Alumnos_Calificaciones:208]P04_Eval11_Literal:321;aNta11;[Alumnos_Calificaciones:208]P04_Eval12_Literal:326;aNta12;[Alumnos_Calificaciones:208]P04_Control_Literal:336;aNtaEXP;[Alumnos_Calificaciones:208]P04_Presentacion_Literal:331;aNtaPresentP)
		
	: ($periodo=5)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Eval01_Real:342;aRealNta1;[Alumnos_Calificaciones:208]P05_Eval02_Real:347;aRealNta2;[Alumnos_Calificaciones:208]P05_Eval03_Real:352;aRealNta3;[Alumnos_Calificaciones:208]P05_Eval04_Real:357;aRealNta4;[Alumnos_Calificaciones:208]P05_Eval05_Real:362;aRealNta5;[Alumnos_Calificaciones:208]P05_Eval06_Real:367;aRealNta6;[Alumnos_Calificaciones:208]P05_Eval07_Real:372;aRealNta7;[Alumnos_Calificaciones:208]P05_Eval08_Real:377;aRealNta8;[Alumnos_Calificaciones:208]P05_Eval09_Real:382;aRealNta9;[Alumnos_Calificaciones:208]P05_Eval10_Real:387;aRealNta10;[Alumnos_Calificaciones:208]P05_Eval11_Real:392;aRealNta11;[Alumnos_Calificaciones:208]P05_Eval12_Real:397;aRealNta12;[Alumnos_Calificaciones:208]P05_Control_Real:407;aRealNtaEXP;[Alumnos_Calificaciones:208]P05_Presentacion_Real:402;aRealNtaPresentP;[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36;aNtaEsfuerzo;[Alumnos_ComplementoEvaluacion:209]P05_Inasistencias:38;alSTR_InasistenciasPeriodo)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Eval01_Literal:346;aNta1;[Alumnos_Calificaciones:208]P05_Eval02_Literal:351;aNta2;[Alumnos_Calificaciones:208]P05_Eval03_Literal:356;aNta3;[Alumnos_Calificaciones:208]P05_Eval04_Literal:361;aNta4;[Alumnos_Calificaciones:208]P05_Eval05_Literal:366;aNta5;[Alumnos_Calificaciones:208]P05_Eval06_Literal:371;aNta6;[Alumnos_Calificaciones:208]P05_Eval07_Literal:376;aNta7;[Alumnos_Calificaciones:208]P05_Eval08_Literal:381;aNta8;[Alumnos_Calificaciones:208]P05_Eval09_Literal:386;aNta9;[Alumnos_Calificaciones:208]P05_Eval10_Literal:391;aNta10;[Alumnos_Calificaciones:208]P05_Eval11_Literal:396;aNta11;[Alumnos_Calificaciones:208]P05_Eval12_Literal:401;aNta12;[Alumnos_Calificaciones:208]P05_Control_Literal:411;aNtaEXP;[Alumnos_Calificaciones:208]P05_Presentacion_Literal:406;aNtaPresentP)
		
End case 
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

ARRAY REAL:C219(aRealPctMinimum;0)
ARRAY REAL:C219(aRealPctMinimum;Size of array:C274(aNtaRecNum))
For ($i;1;Size of array:C274(aRealNtaP1))
	$id:=aNtaEvStyleID{$i}
	$blob:=KRL_GetBlobFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->$id;->[xxSTR_HistoricoEstilosEval:88]xData:6)
	EVS_LeeEstiloEvalHistorico ($blob)
	aRealPctMinimum{$i}:=rPctMinimum
	If ($aNivelJerarquico{$i}>0)
		aNtaAsignatura{$i}:=("   "*$aNivelJerarquico{$i})+aNtaAsignatura{$i}
	End if 
End for 


vb_NotaOficialVisible:=False:C215
For ($i;1;Size of array:C274(aNtaOf))
	If (aNtaOf{$i}#aNtaF{$i})
		vb_NotaOficialVisible:=True:C214
		$i:=Size of array:C274(aNtaOf)+1
	End if 
End for 

KRL_GotoRecord (->[Alumnos_SintesisAnual:210];$recNumSintesis;False:C215)

  //20180904 RCH Ticket 215184
$b_noMostrarPO:=([Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96=[Alumnos_SintesisAnual:210]P01_PromedioOficial_Literal:241)
$b_noMostrarPO:=$b_noMostrarPO & ([Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125=[Alumnos_SintesisAnual:210]P02_PromedioOficial_Literal:246)
$b_noMostrarPO:=$b_noMostrarPO & ([Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154=[Alumnos_SintesisAnual:210]P03_PromedioOficial_Literal:251)
$b_noMostrarPO:=$b_noMostrarPO & ([Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183=[Alumnos_SintesisAnual:210]P04_PromedioOficial_Literal:256)
$b_noMostrarPO:=$b_noMostrarPO & ([Alumnos_SintesisAnual:210]P05_PromedioInterno_Literal:212=[Alumnos_SintesisAnual:210]P05_PromedioOficial_Literal:261)
$b_noMostrarPO:=$b_noMostrarPO & ([Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14=[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19)

If ($b_noMostrarPO)
	vs_Avg1:=[Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96  //+"\r"+[Alumnos_SintesisAnual]P01_PromedioOficial_Literal
	vs_Avg2:=[Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125  //+"\r"+[Alumnos_SintesisAnual]P02_PromedioOficial_Literal
	vs_Avg3:=[Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154  //+"\r"+[Alumnos_SintesisAnual]P03_PromedioOficial_Literal
	vs_avg4:=[Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183  //+"\r"+[Alumnos_SintesisAnual]P04_PromedioOficial_Literal
	vs_avg5:=[Alumnos_SintesisAnual:210]P05_PromedioInterno_Literal:212  //+"\r"+[Alumnos_SintesisAnual]P05_PromedioOficial_Literal
	vs_avgPF:=[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14  //+"\r"+[Alumnos_SintesisAnual]PromedioAnualOficial_Literal
Else 
	vs_Avg1:=[Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96+"\r"+[Alumnos_SintesisAnual:210]P01_PromedioOficial_Literal:241
	vs_Avg2:=[Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125+"\r"+[Alumnos_SintesisAnual:210]P02_PromedioOficial_Literal:246
	vs_Avg3:=[Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154+"\r"+[Alumnos_SintesisAnual:210]P03_PromedioOficial_Literal:251
	vs_avg4:=[Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183+"\r"+[Alumnos_SintesisAnual:210]P04_PromedioOficial_Literal:256
	vs_avg5:=[Alumnos_SintesisAnual:210]P05_PromedioInterno_Literal:212+"\r"+[Alumnos_SintesisAnual:210]P05_PromedioOficial_Literal:261
	vs_avgPF:=[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14+"\r"+[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19
End if 

vs_avgEX:=""
vs_avgNF:=[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24
vs_avgNO:="\r"+[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29
vs_avgGR:=""

EVS_LeeEstiloEvalHistorico ($vx_EstiloEvaluacionOficial)
If ([Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Real:268>=vrNTA_MinimoEscalaReferencia)
	  //si en el histórico hay promedios no aproximados
	Case of 
		: (iPrintActa=Notas)
			vr_PromedioNoAproximado:=[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Nota:269
		: (iPrintActa=Puntos)
			vr_PromedioNoAproximado:=[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Puntos:270
		: (iPrintActa=Porcentaje)
			vr_PromedioNoAproximado:=[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Real:268
		: (iPrintActa=Simbolos)
			vr_PromedioNoAproximado:=[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Real:268
	End case 
Else 
	  //si no hay se utilizan los promedios oficiales
	Case of 
		: (iPrintActa=Notas)
			vr_PromedioNoAproximado:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Nota:26
		: (iPrintActa=Puntos)
			vr_PromedioNoAproximado:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Puntos:27
		: (iPrintActa=Porcentaje)
			vr_PromedioNoAproximado:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Real:25
		: (iPrintActa=Simbolos)
			vr_PromedioNoAproximado:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Real:25
	End case 
End if 


EVS_LeeEstiloEvalHistorico ($vx_EstiloEvaluacionInterno)
If ([Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Real:272>=vrNTA_MinimoEscalaReferencia)
	  //si en el histórico hay promedios no aproximados
	Case of 
		: (iPrintActa=Notas)
			vr_PromedioNoAproximadoInt:=[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Nota:273
		: (iPrintActa=Puntos)
			vr_PromedioNoAproximadoInt:=[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Puntos:274
		: (iPrintActa=Porcentaje)
			vr_PromedioNoAproximadoInt:=[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Real:272
		: (iPrintActa=Simbolos)
			vr_PromedioNoAproximadoInt:=[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Real:272
	End case 
Else 
	  //si no hay se utilizan los promedios oficiales
	Case of 
		: (iPrintActa=Notas)
			vr_PromedioNoAproximadoInt:=[Alumnos_SintesisAnual:210]PromedioFinalInterno_Nota:21
		: (iPrintActa=Puntos)
			vr_PromedioNoAproximadoInt:=[Alumnos_SintesisAnual:210]PromedioFinalInterno_Puntos:22
		: (iPrintActa=Porcentaje)
			vr_PromedioNoAproximadoInt:=[Alumnos_SintesisAnual:210]PromedioFinalInterno_Real:20
		: (iPrintActa=Simbolos)
			vr_PromedioNoAproximadoInt:=[Alumnos_SintesisAnual:210]PromedioFinalInterno_Real:20
	End case 
End if 








