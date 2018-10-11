//%attributes = {}
  // STWA_AJAX_SendNotas_v15()
  // Por: Alberto Bachler Klein: 16-11-15, 17:52:39
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_calificacionesEditables;$b_examenesEditables;$b_fechaBloqueo;$b_PromediosEditables)
C_LONGINT:C283($l_indice;$l_indice2;$l_periodo)
C_PICTURE:C286($p_iconoConsolidante;$p_iconoEditable;$p_iconoNoEditable;$p_iconoSubAsignatura)
C_POINTER:C301($y_Nta;$y_parEdit;$y_array_bloq)
C_REAL:C285($r_minimo;$r_minimoEscala)
C_TEXT:C284($t_fechaBloqueo;$t_iconoPromedios;$t_json;$t_minimoEscalaSimbolos;$t_minimoSimbolo;$t_refIconoConsolidante;$t_refIconoEditable;$t_refIconoNoEditable;$t_refIconoSubAsignatura;$t_refJson)
C_OBJECT:C1216($ob_nodoEstiloEval;$ob_nodoEstiloEvalOficial;$ob_nodoIconos;$ob_nodoOpcionesExamenes;$ob_nodoParametros;$ob_nodoPeriodos;$ob_nodoPrivilegios;$ob_objeto;$ob_nomEvaGral)

ARRAY LONGINT:C221($aEnterable;0)
ARRAY LONGINT:C221($aFieldNumbers;0)
ARRAY LONGINT:C221($aTableNumbers;0)
ARRAY TEXT:C222($aIcono;0)
ARRAY TEXT:C222(at_par1_edit;0)
ARRAY TEXT:C222(at_par10_edit;0)
ARRAY TEXT:C222(at_par11_edit;0)
ARRAY TEXT:C222(at_par12_edit;0)
ARRAY TEXT:C222(at_par2_edit;0)
ARRAY TEXT:C222(at_par3_edit;0)
ARRAY TEXT:C222(at_par4_edit;0)
ARRAY TEXT:C222(at_par5_edit;0)
ARRAY TEXT:C222(at_par6_edit;0)
ARRAY TEXT:C222(at_par7_edit;0)
ARRAY TEXT:C222(at_par8_edit;0)
ARRAY TEXT:C222(at_par9_edit;0)

If (False:C215)
	C_TEXT:C284(STWA2_AJAX_SendNotas_v15 ;$0)
	C_LONGINT:C283(STWA2_AJAX_SendNotas_v15 ;$1)
End if 

$l_periodo:=$1
$profID:=$2
$userID:=$3

PERIODOS_Init 
PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
  //If (($l_periodo=0) | ($l_periodo>aiSTR_Periodos_Numero{Size of array(aiSTR_Periodos_Numero)}))
  //$l_periodo:=PERIODOS_PeriodosActuales (Current date(*);True)
  //End if
If ($l_periodo=0)
	$l_periodo:=viSTR_PeriodoActual_Numero
End if 
If ($l_periodo>aiSTR_Periodos_Numero{Size of array:C274(aiSTR_Periodos_Numero)})
	$l_periodo:=Size of array:C274(aiSTR_Periodos_Numero)
End if 


EVS_initialize 
EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
AS_PropEval_Lectura ("";$l_periodo)
EV2_LeeCalificaciones ([Asignaturas:18]Numero:1;$l_periodo)
$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]AttendanceMode:3)

$t_fechaBloqueo:=String:C10(<>vd_FechaBloqueoSchoolTrack;Internal date short:K1:7)
$b_fechaBloqueo:=<>vb_BloquearModifSituacionFinal

  //aNtaStatus
  // 20181008 Patricio Aliaga Ticket N° 204363
C_OBJECT:C1216($o_obj;$o_in)
OB SET:C1220($o_in;"nivel";[Asignaturas:18]Numero_del_Nivel:6)
$o_obj:=STR_ordenNominas ("query";$o_in)
Case of 
	: (OB Get:C1224($o_obj;"UsaGenero";Is boolean:K8:9))
		Case of 
			: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					AT_MultiLevelSort ("<>";->aSexoAlumnos;->aNtaOrden;->aNtaCurso;->aNtaStdNme;->aNtaP1;->aNtaP2;->aNtaP3;->aNtaP4;->aNtaP5;->aNtaPF;->aNtaEX;->aNtaEXX;->aNtaF;->aNtaOf;->aNtaEXP;->aNtaEsfuerzo;->aNta1;->aNta2;->aNta3;->aNta4;->aNta5;->aNta6;->aNta7;->aNta8;->aNta9;->aNta10;->aNta11;->aNta12;->aNtaStatus;->aNtaReprobada;->aNtaRegEximicion;->aNtaIDAlumno;->aNtaRecNum;->alSTR_InasistenciasPeriodo;->aRealEXRecuperatorio;->aRealNtaEX;->aRealNtaEXX;->aRealNtaF;->aNtaBX;->aBoolCondicional;->aNtaPTC_literal)
				Else 
					AT_MultiLevelSort (">>";->aSexoAlumnos;->aNtaOrden;->aNtaCurso;->aNtaStdNme;->aNtaP1;->aNtaP2;->aNtaP3;->aNtaP4;->aNtaP5;->aNtaPF;->aNtaEX;->aNtaEXX;->aNtaF;->aNtaOf;->aNtaEXP;->aNtaEsfuerzo;->aNta1;->aNta2;->aNta3;->aNta4;->aNta5;->aNta6;->aNta7;->aNta8;->aNta9;->aNta10;->aNta11;->aNta12;->aNtaStatus;->aNtaReprobada;->aNtaRegEximicion;->aNtaIDAlumno;->aNtaRecNum;->alSTR_InasistenciasPeriodo;->aRealEXRecuperatorio;->aRealNtaEX;->aRealNtaEXX;->aRealNtaF;->aNtaBX;->aBoolCondicional;->aNtaPTC_literal)
				End if 
			: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
						AT_MultiLevelSort ("< >>";->aSexoAlumnos;->aNtaOrden;->aNtaCurso;->aNtaStdNme;->aNtaP1;->aNtaP2;->aNtaP3;->aNtaP4;->aNtaP5;->aNtaPF;->aNtaEX;->aNtaEXX;->aNtaF;->aNtaOf;->aNtaEXP;->aNtaEsfuerzo;->aNta1;->aNta2;->aNta3;->aNta4;->aNta5;->aNta6;->aNta7;->aNta8;->aNta9;->aNta10;->aNta11;->aNta12;->aNtaStatus;->aNtaReprobada;->aNtaRegEximicion;->aNtaIDAlumno;->aNtaRecNum;->alSTR_InasistenciasPeriodo;->aRealEXRecuperatorio;->aRealNtaEX;->aRealNtaEXX;->aRealNtaF;->aNtaBX;->aBoolCondicional;->aNtaPTC_literal)
					Else 
						AT_MultiLevelSort ("<  >";->aSexoAlumnos;->aNtaOrden;->aNtaCurso;->aNtaStdNme;->aNtaP1;->aNtaP2;->aNtaP3;->aNtaP4;->aNtaP5;->aNtaPF;->aNtaEX;->aNtaEXX;->aNtaF;->aNtaOf;->aNtaEXP;->aNtaEsfuerzo;->aNta1;->aNta2;->aNta3;->aNta4;->aNta5;->aNta6;->aNta7;->aNta8;->aNta9;->aNta10;->aNta11;->aNta12;->aNtaStatus;->aNtaReprobada;->aNtaRegEximicion;->aNtaIDAlumno;->aNtaRecNum;->alSTR_InasistenciasPeriodo;->aRealEXRecuperatorio;->aRealNtaEX;->aRealNtaEXX;->aRealNtaF;->aNtaBX;->aBoolCondicional;->aNtaPTC_literal)
					End if 
				Else 
					If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
						AT_MultiLevelSort ("> >>";->aSexoAlumnos;->aNtaOrden;->aNtaCurso;->aNtaStdNme;->aNtaP1;->aNtaP2;->aNtaP3;->aNtaP4;->aNtaP5;->aNtaPF;->aNtaEX;->aNtaEXX;->aNtaF;->aNtaOf;->aNtaEXP;->aNtaEsfuerzo;->aNta1;->aNta2;->aNta3;->aNta4;->aNta5;->aNta6;->aNta7;->aNta8;->aNta9;->aNta10;->aNta11;->aNta12;->aNtaStatus;->aNtaReprobada;->aNtaRegEximicion;->aNtaIDAlumno;->aNtaRecNum;->alSTR_InasistenciasPeriodo;->aRealEXRecuperatorio;->aRealNtaEX;->aRealNtaEXX;->aRealNtaF;->aNtaBX;->aBoolCondicional;->aNtaPTC_literal)
					Else 
						AT_MultiLevelSort (">  >";->aSexoAlumnos;->aNtaOrden;->aNtaCurso;->aNtaStdNme;->aNtaP1;->aNtaP2;->aNtaP3;->aNtaP4;->aNtaP5;->aNtaPF;->aNtaEX;->aNtaEXX;->aNtaF;->aNtaOf;->aNtaEXP;->aNtaEsfuerzo;->aNta1;->aNta2;->aNta3;->aNta4;->aNta5;->aNta6;->aNta7;->aNta8;->aNta9;->aNta10;->aNta11;->aNta12;->aNtaStatus;->aNtaReprobada;->aNtaRegEximicion;->aNtaIDAlumno;->aNtaRecNum;->alSTR_InasistenciasPeriodo;->aRealEXRecuperatorio;->aRealNtaEX;->aRealNtaEXX;->aRealNtaF;->aNtaBX;->aBoolCondicional;->aNtaPTC_literal)
					End if 
				End if 
			: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					AT_MultiLevelSort ("<>";->aSexoAlumnos;->aNtaStdNme;->aNtaOrden;->aNtaCurso;->aNtaP1;->aNtaP2;->aNtaP3;->aNtaP4;->aNtaP5;->aNtaPF;->aNtaEX;->aNtaEXX;->aNtaF;->aNtaOf;->aNtaEXP;->aNtaEsfuerzo;->aNta1;->aNta2;->aNta3;->aNta4;->aNta5;->aNta6;->aNta7;->aNta8;->aNta9;->aNta10;->aNta11;->aNta12;->aNtaStatus;->aNtaReprobada;->aNtaRegEximicion;->aNtaIDAlumno;->aNtaRecNum;->alSTR_InasistenciasPeriodo;->aRealEXRecuperatorio;->aRealNtaEX;->aRealNtaEXX;->aRealNtaF;->aNtaBX;->aBoolCondicional;->aNtaPTC_literal)
				Else 
					AT_MultiLevelSort (">>";->aSexoAlumnos;->aNtaStdNme;->aNtaOrden;->aNtaCurso;->aNtaP1;->aNtaP2;->aNtaP3;->aNtaP4;->aNtaP5;->aNtaPF;->aNtaEX;->aNtaEXX;->aNtaF;->aNtaOf;->aNtaEXP;->aNtaEsfuerzo;->aNta1;->aNta2;->aNta3;->aNta4;->aNta5;->aNta6;->aNta7;->aNta8;->aNta9;->aNta10;->aNta11;->aNta12;->aNtaStatus;->aNtaReprobada;->aNtaRegEximicion;->aNtaIDAlumno;->aNtaRecNum;->alSTR_InasistenciasPeriodo;->aRealEXRecuperatorio;->aRealNtaEX;->aRealNtaEXX;->aRealNtaF;->aNtaBX;->aBoolCondicional;->aNtaPTC_literal)
				End if 
		End case 
	: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
		SORT ARRAY:C229(aNtaOrden;aNtaStdNme;aNtaCurso;aNtaP1;aNtaP2;aNtaP3;aNtaP4;aNtaP5;aNtaPF;aNtaEX;aNtaEXX;aNtaF;aNtaOf;aNtaEXP;aNtaEsfuerzo;aNta1;aNta2;aNta3;aNta4;aNta5;aNta6;aNta7;aNta8;aNta9;aNta10;aNta11;aNta12;aNtaStatus;aNtaReprobada;aNtaRegEximicion;aNtaIDAlumno;aNtaRecNum;alSTR_InasistenciasPeriodo;aRealEXRecuperatorio;aRealNtaEX;aRealNtaEXX;aRealNtaF;aNtaBX;aBoolCondicional;aNtaPTC_literal)
	: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
		If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
			AT_MultiLevelSort (" >>";->aNtaOrden;->aNtaCurso;->aNtaStdNme;->aNtaP1;->aNtaP2;->aNtaP3;->aNtaP4;->aNtaP5;->aNtaPF;->aNtaEX;->aNtaEXX;->aNtaF;->aNtaOf;->aNtaEXP;->aNtaEsfuerzo;->aNta1;->aNta2;->aNta3;->aNta4;->aNta5;->aNta6;->aNta7;->aNta8;->aNta9;->aNta10;->aNta11;->aNta12;->aNtaStatus;->aNtaReprobada;->aNtaRegEximicion;->aNtaIDAlumno;->aNtaRecNum;->alSTR_InasistenciasPeriodo;->aRealEXRecuperatorio;->aRealNtaEX;->aRealNtaEXX;->aRealNtaF;->aNtaBX;->aBoolCondicional;->aNtaPTC_literal)
		Else 
			SORT ARRAY:C229(aNtaStdNme;aNtaOrden;aNtaCurso;aNtaP1;aNtaP2;aNtaP3;aNtaP4;aNtaP5;aNtaPF;aNtaEX;aNtaEXX;aNtaF;aNtaOf;aNtaEXP;aNtaEsfuerzo;aNta1;aNta2;aNta3;aNta4;aNta5;aNta6;aNta7;aNta8;aNta9;aNta10;aNta11;aNta12;aNtaStatus;aNtaReprobada;aNtaRegEximicion;aNtaIDAlumno;aNtaRecNum;alSTR_InasistenciasPeriodo;aRealEXRecuperatorio;aRealNtaEX;aRealNtaEXX;aRealNtaF;aNtaBX;aBoolCondicional;aNtaPTC_literal)
		End if 
	: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
		SORT ARRAY:C229(aNtaStdNme;aNtaOrden;aNtaCurso;aNtaP1;aNtaP2;aNtaP3;aNtaP4;aNtaP5;aNtaPF;aNtaEX;aNtaEXX;aNtaF;aNtaOf;aNtaEXP;aNtaEsfuerzo;aNta1;aNta2;aNta3;aNta4;aNta5;aNta6;aNta7;aNta8;aNta9;aNta10;aNta11;aNta12;aNtaStatus;aNtaReprobada;aNtaRegEximicion;aNtaIDAlumno;aNtaRecNum;alSTR_InasistenciasPeriodo;aRealEXRecuperatorio;aRealNtaEX;aRealNtaEXX;aRealNtaF;aNtaBX;aBoolCondicional;aNtaPTC_literal)
End case 
  //If (<>viSTR_AgruparPorSexo=0)
  //Case of 
  //: (<>gOrdenNta=0)
  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
  //AT_MultiLevelSort (" >>";->aNtaOrden;->aNtaCurso;->aNtaStdNme;->aNtaP1;->aNtaP2;->aNtaP3;->aNtaP4;->aNtaP5;->aNtaPF;->aNtaEX;->aNtaEXX;->aNtaF;->aNtaOf;->aNtaEXP;->aNtaEsfuerzo;->aNta1;->aNta2;->aNta3;->aNta4;->aNta5;->aNta6;->aNta7;->aNta8;->aNta9;->aNta10;->aNta11;->aNta12;->aNtaStatus;->aNtaReprobada;->aNtaRegEximicion;->aNtaIDAlumno;->aNtaRecNum;->alSTR_InasistenciasPeriodo;->aRealEXRecuperatorio;->aRealNtaEX;->aRealNtaEXX;->aRealNtaF;->aNtaBX;->aBoolCondicional;->aNtaPTC_literal)
  //Else 
  //SORT ARRAY(aNtaStdNme;aNtaOrden;aNtaCurso;aNtaP1;aNtaP2;aNtaP3;aNtaP4;aNtaP5;aNtaPF;aNtaEX;aNtaEXX;aNtaF;aNtaOf;aNtaEXP;aNtaEsfuerzo;aNta1;aNta2;aNta3;aNta4;aNta5;aNta6;aNta7;aNta8;aNta9;aNta10;aNta11;aNta12;aNtaStatus;aNtaReprobada;aNtaRegEximicion;aNtaIDAlumno;aNtaRecNum;alSTR_InasistenciasPeriodo;aRealEXRecuperatorio;aRealNtaEX;aRealNtaEXX;aRealNtaF;aNtaBX;aBoolCondicional;aNtaPTC_literal)
  //End if 
  //: (<>gOrdenNta=1)
  //SORT ARRAY(aNtaOrden;aNtaStdNme;aNtaCurso;aNtaP1;aNtaP2;aNtaP3;aNtaP4;aNtaP5;aNtaPF;aNtaEX;aNtaEXX;aNtaF;aNtaOf;aNtaEXP;aNtaEsfuerzo;aNta1;aNta2;aNta3;aNta4;aNta5;aNta6;aNta7;aNta8;aNta9;aNta10;aNta11;aNta12;aNtaStatus;aNtaReprobada;aNtaRegEximicion;aNtaIDAlumno;aNtaRecNum;alSTR_InasistenciasPeriodo;aRealEXRecuperatorio;aRealNtaEX;aRealNtaEXX;aRealNtaF;aNtaBX;aBoolCondicional;aNtaPTC_literal)
  //: (<>gOrdenNta=2)
  //SORT ARRAY(aNtaStdNme;aNtaOrden;aNtaCurso;aNtaP1;aNtaP2;aNtaP3;aNtaP4;aNtaP5;aNtaPF;aNtaEX;aNtaEXX;aNtaF;aNtaOf;aNtaEXP;aNtaEsfuerzo;aNta1;aNta2;aNta3;aNta4;aNta5;aNta6;aNta7;aNta8;aNta9;aNta10;aNta11;aNta12;aNtaStatus;aNtaReprobada;aNtaRegEximicion;aNtaIDAlumno;aNtaRecNum;alSTR_InasistenciasPeriodo;aRealEXRecuperatorio;aRealNtaEX;aRealNtaEXX;aRealNtaF;aNtaBX;aBoolCondicional;aNtaPTC_literal)
  //End case 
  //Else 
  //Case of 
  //: (<>gOrdenNta=0)
  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
  //AT_MultiLevelSort ("< >>";->aSexoAlumnos;->aNtaOrden;->aNtaCurso;->aNtaStdNme;->aNtaP1;->aNtaP2;->aNtaP3;->aNtaP4;->aNtaP5;->aNtaPF;->aNtaEX;->aNtaEXX;->aNtaF;->aNtaOf;->aNtaEXP;->aNtaEsfuerzo;->aNta1;->aNta2;->aNta3;->aNta4;->aNta5;->aNta6;->aNta7;->aNta8;->aNta9;->aNta10;->aNta11;->aNta12;->aNtaStatus;->aNtaReprobada;->aNtaRegEximicion;->aNtaIDAlumno;->aNtaRecNum;->alSTR_InasistenciasPeriodo;->aRealEXRecuperatorio;->aRealNtaEX;->aRealNtaEXX;->aRealNtaF;->aNtaBX;->aBoolCondicional;->aNtaPTC_literal)
  //Else 
  //AT_MultiLevelSort ("<  >";->aSexoAlumnos;->aNtaOrden;->aNtaCurso;->aNtaStdNme;->aNtaP1;->aNtaP2;->aNtaP3;->aNtaP4;->aNtaP5;->aNtaPF;->aNtaEX;->aNtaEXX;->aNtaF;->aNtaOf;->aNtaEXP;->aNtaEsfuerzo;->aNta1;->aNta2;->aNta3;->aNta4;->aNta5;->aNta6;->aNta7;->aNta8;->aNta9;->aNta10;->aNta11;->aNta12;->aNtaStatus;->aNtaReprobada;->aNtaRegEximicion;->aNtaIDAlumno;->aNtaRecNum;->alSTR_InasistenciasPeriodo;->aRealEXRecuperatorio;->aRealNtaEX;->aRealNtaEXX;->aRealNtaF;->aNtaBX;->aBoolCondicional;->aNtaPTC_literal)
  //End if 
  //: (<>gOrdenNta=1)
  //AT_MultiLevelSort ("<>";->aSexoAlumnos;->aNtaOrden;->aNtaCurso;->aNtaStdNme;->aNtaP1;->aNtaP2;->aNtaP3;->aNtaP4;->aNtaP5;->aNtaPF;->aNtaEX;->aNtaEXX;->aNtaF;->aNtaOf;->aNtaEXP;->aNtaEsfuerzo;->aNta1;->aNta2;->aNta3;->aNta4;->aNta5;->aNta6;->aNta7;->aNta8;->aNta9;->aNta10;->aNta11;->aNta12;->aNtaStatus;->aNtaReprobada;->aNtaRegEximicion;->aNtaIDAlumno;->aNtaRecNum;->alSTR_InasistenciasPeriodo;->aRealEXRecuperatorio;->aRealNtaEX;->aRealNtaEXX;->aRealNtaF;->aNtaBX;->aBoolCondicional;->aNtaPTC_literal)
  //: (<>gOrdenNta=2)
  //AT_MultiLevelSort ("<  >";->aSexoAlumnos;->aNtaOrden;->aNtaCurso;->aNtaStdNme;->aNtaP1;->aNtaP2;->aNtaP3;->aNtaP4;->aNtaP5;->aNtaPF;->aNtaEX;->aNtaEXX;->aNtaF;->aNtaOf;->aNtaEXP;->aNtaEsfuerzo;->aNta1;->aNta2;->aNta3;->aNta4;->aNta5;->aNta6;->aNta7;->aNta8;->aNta9;->aNta10;->aNta11;->aNta12;->aNtaStatus;->aNtaReprobada;->aNtaRegEximicion;->aNtaIDAlumno;->aNtaRecNum;->alSTR_InasistenciasPeriodo;->aRealEXRecuperatorio;->aRealNtaEX;->aRealNtaEXX;->aRealNtaF;->aNtaBX;->aBoolCondicional;->aNtaPTC_literal)
  //End case 
  //End if 



If ((<>viSTR_NoModificarNotas=1) & (Not:C34(USR_checkRights ("M";->[Alumnos_Calificaciones:208]))))
	For ($l_indice;1;12)
		$y_Nta:=Get pointer:C304("aNta"+String:C10($l_indice))
		$y_parEdit:=Get pointer:C304("at_par"+String:C10($l_indice)+"_edit")
		For ($l_indice2;1;Size of array:C274($y_Nta->))
			APPEND TO ARRAY:C911($y_parEdit->;"edit")
		End for 
	End for 
Else 
	For ($l_indice;1;12)
		$y_Nta:=Get pointer:C304("aNta"+String:C10($l_indice))
		$y_parEdit:=Get pointer:C304("at_par"+String:C10($l_indice)+"_edit")
		For ($l_indice2;1;Size of array:C274($y_Nta->))
			If ($y_Nta->{$l_indice2}#"")
				APPEND TO ARRAY:C911($y_parEdit->;"no-edit")
			Else 
				APPEND TO ARRAY:C911($y_parEdit->;"edit")
			End if 
		End for 
	End for 
End if 

GET PICTURE FROM LIBRARY:C565(5006;$p_iconoNoEditable)
GET PICTURE FROM LIBRARY:C565(5005;$p_iconoEditable)
GET PICTURE FROM LIBRARY:C565(5007;$p_iconoSubAsignatura)
GET PICTURE FROM LIBRARY:C565(5008;$p_iconoConsolidante)
$t_refIconoNoEditable:="noingresable"
$t_refIconoEditable:="ingresable"
$t_refIconoSubAsignatura:="subasignatura"
$t_refIconoConsolidante:="consolidante"

$calculosSobreCompetencias:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9)

$b_calificacionesEditables:=Not:C34(<>vb_BloquearModifSituacionFinal)
$b_calificacionesEditables:=$b_calificacionesEditables & (((<>viSTR_FirmantesAutorizados=1) & ($profID=[Asignaturas:18]profesor_firmante_numero:33)) | ($profID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208];$userID)))
$b_calificacionesEditables:=$b_calificacionesEditables & ((adSTR_Periodos_Cierre{$l_periodo}>Current date:C33(*)) | (adSTR_Periodos_Cierre{$l_periodo}=!00-00-00!))
$b_calificacionesEditables:=$b_calificacionesEditables | (USR_IsGroupMember_by_GrpID (-15001;$userID) | ($userID<0))

$b_PromediosEditables:=Not:C34(<>vb_BloquearModifSituacionFinal)
$b_PromediosEditables:=$b_PromediosEditables & (((<>viSTR_FirmantesAutorizados=1) & ($profID=[Asignaturas:18]profesor_firmante_numero:33)) | ($profID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208];$userID)))
$b_PromediosEditables:=$b_PromediosEditables | ((USR_IsGroupMember_by_GrpID (-15001;$userID)))
$b_PromediosEditables:=$b_PromediosEditables & AS_PromediosSonEditables ([Asignaturas:18]Numero:1)

$b_examenesEditables:=Not:C34(<>vb_BloquearModifSituacionFinal)
$b_examenesEditables:=$b_examenesEditables & (((<>viSTR_FirmantesAutorizados=1) & ($profID=[Asignaturas:18]profesor_firmante_numero:33)) | ($profID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208];$userID)))
$b_examenesEditables:=$b_examenesEditables | (USR_IsGroupMember_by_GrpID (-15001;$userID) | ($userID<0))

$examenesIngresables:=Num:C11($b_examenesEditables)
$t_iconoPromedios:=Choose:C955($b_PromediosEditables;$t_refIconoEditable;$t_refIconoNoEditable)

If ($calculosSobreCompetencias)
	$b_CalificacionesEditables:=False:C215
End if 

$enSimbolos:=(iEvaluationMode=Simbolos)
$ob_objeto:=OB_Create 
OB_SET ($ob_objeto;->aNtaOrden;"ordenes")
APPEND TO ARRAY:C911($aEnterable;0)
APPEND TO ARRAY:C911($aIcono;"")
APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]NoDeLista:10))

OB_SET ($ob_objeto;->aNtaStdNme;"alumnos")
APPEND TO ARRAY:C911($aEnterable;0)
APPEND TO ARRAY:C911($aIcono;"")
APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos:2]))
APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos:2]apellidos_y_nombres:40))
If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
	OB_SET ($ob_objeto;->aNtaCurso;"cursos")
	APPEND TO ARRAY:C911($aEnterable;0)
	APPEND TO ARRAY:C911($aIcono;"")
	APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos:2]))
	APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos:2]curso:20))
End if 

OB_SET ($ob_objeto;->aBoolCondicional;"condicional")

If ($modoRegistroAsistencia=4)
	OB_SET ($ob_objeto;->alSTR_InasistenciasPeriodo;"inasistencia")
	If (<>vb_BloquearModifSituacionFinal)
		APPEND TO ARRAY:C911($aEnterable;0)
		APPEND TO ARRAY:C911($aIcono;$t_refIconoNoEditable)
	Else 
		APPEND TO ARRAY:C911($aEnterable;1)
		APPEND TO ARRAY:C911($aIcono;$t_refIconoEditable)
	End if 
	APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_ComplementoEvaluacion:209]))
	APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(KRL_GetFieldPointerByName ("[Alumnos_ComplementoEvaluacion]P0"+String:C10($l_periodo)+"_Inasistencias")))
End if 

OB_SET ($ob_objeto;->antap1;"p1")
APPEND TO ARRAY:C911($aEnterable;Num:C11($b_PromediosEditables))
APPEND TO ARRAY:C911($aIcono;$t_iconoPromedios)
APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P01_Final_Literal:116))

Case of 
	: (vlSTR_Periodos_Tipo=2 Semestres)
		OB_SET ($ob_objeto;->antap2;"p2")
		APPEND TO ARRAY:C911($aEnterable;Num:C11($b_PromediosEditables))
		APPEND TO ARRAY:C911($aIcono;$t_iconoPromedios)
		APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
		APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P02_Final_Literal:191))
		
	: (vlSTR_Periodos_Tipo=3 Trimestres)
		OB_SET ($ob_objeto;->antap2;"p2")
		OB_SET ($ob_objeto;->antap3;"p3")
		APPEND TO ARRAY:C911($aEnterable;Num:C11($b_PromediosEditables))
		APPEND TO ARRAY:C911($aIcono;$t_iconoPromedios)
		APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
		APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P02_Final_Literal:191))
		APPEND TO ARRAY:C911($aEnterable;Num:C11($b_PromediosEditables))
		APPEND TO ARRAY:C911($aIcono;$t_iconoPromedios)
		APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
		APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P03_Final_Literal:266))
		
	: (vlSTR_Periodos_Tipo=4 Bimestres)
		OB_SET ($ob_objeto;->antap2;"p2")
		OB_SET ($ob_objeto;->antap3;"p3")
		OB_SET ($ob_objeto;->antap4;"p4")
		APPEND TO ARRAY:C911($aEnterable;Num:C11($b_PromediosEditables))
		APPEND TO ARRAY:C911($aIcono;$t_iconoPromedios)
		APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
		APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P02_Final_Literal:191))
		APPEND TO ARRAY:C911($aEnterable;Num:C11($b_PromediosEditables))
		APPEND TO ARRAY:C911($aIcono;$t_iconoPromedios)
		APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
		APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P03_Final_Literal:266))
		APPEND TO ARRAY:C911($aEnterable;Num:C11($b_PromediosEditables))
		APPEND TO ARRAY:C911($aIcono;$t_iconoPromedios)
		APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
		APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P04_Final_Literal:341))
		
	Else 
		If (vlSTR_Periodos_Tipo#Anual)
			OB_SET ($ob_objeto;->antap2;"p2")
			OB_SET ($ob_objeto;->antap3;"p3")
			OB_SET ($ob_objeto;->antap4;"p4")
			OB_SET ($ob_objeto;->antap5;"p5")
			APPEND TO ARRAY:C911($aEnterable;Num:C11($b_PromediosEditables))
			APPEND TO ARRAY:C911($aIcono;$t_iconoPromedios)
			APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
			APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P02_Final_Literal:191))
			APPEND TO ARRAY:C911($aEnterable;Num:C11($b_PromediosEditables))
			APPEND TO ARRAY:C911($aIcono;$t_iconoPromedios)
			APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
			APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P03_Final_Literal:266))
			APPEND TO ARRAY:C911($aEnterable;Num:C11($b_PromediosEditables))
			APPEND TO ARRAY:C911($aIcono;$t_iconoPromedios)
			APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
			APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P04_Final_Literal:341))
			APPEND TO ARRAY:C911($aEnterable;Num:C11($b_PromediosEditables))
			APPEND TO ARRAY:C911($aIcono;$t_iconoPromedios)
			APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
			APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P05_Final_Literal:416))
		End if 
End case 


If (vi_UsarExamenes#0)
	OB_SET ($ob_objeto;->aNtaPF;"pf")
	APPEND TO ARRAY:C911($aEnterable;Num:C11($b_PromediosEditables))
	APPEND TO ARRAY:C911($aIcono;$t_iconoPromedios)
	APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
	APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]Anual_Literal:15))
	
	OB_SET ($ob_objeto;->aNtaEX;"ex")
	If ($enSimbolos)
		OB_SET ($ob_objeto;->aRealNtaEX;"realex")
	End if 
	APPEND TO ARRAY:C911($aEnterable;$examenesIngresables)
	If ($b_examenesEditables)
		APPEND TO ARRAY:C911($aIcono;$t_refIconoEditable)
	Else 
		APPEND TO ARRAY:C911($aIcono;$t_refIconoNoEditable)
	End if 
	APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
	APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]ExamenAnual_Literal:20))
End if 

If (vi_UsarExamenExtra#0)
	OB_SET ($ob_objeto;->aNtaEXX;"exx")
	If ($enSimbolos)
		OB_SET ($ob_objeto;->aRealNtaEXX;"realexx")
	End if 
	APPEND TO ARRAY:C911($aEnterable;$examenesIngresables)
	If ($b_examenesEditables)
		APPEND TO ARRAY:C911($aIcono;$t_refIconoEditable)
	Else 
		APPEND TO ARRAY:C911($aIcono;$t_refIconoNoEditable)
	End if 
	APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
	APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]ExamenExtra_Literal:25))
End if 

OB_SET ($ob_objeto;->aNtaF;"f")
If ($enSimbolos)
	OB_SET ($ob_objeto;->aRealNtaF;"realf")
End if 
APPEND TO ARRAY:C911($aEnterable;Num:C11($b_PromediosEditables))
APPEND TO ARRAY:C911($aIcono;$t_iconoPromedios)
APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30))
OB_SET ($ob_objeto;->aNtaOf;"of")
APPEND TO ARRAY:C911($aEnterable;0)
APPEND TO ARRAY:C911($aIcono;$t_refIconoNoEditable)
APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36))

C_BOOLEAN:C305($b_mostrarPTC)
$b_mostrarPTC:=OB Get:C1224([Asignaturas:18]Opciones:57;"mostrarPTC";Is boolean:K8:9)
If ($b_mostrarPTC)
	OB_SET ($ob_objeto;->aNtaPTC_literal;"PTE")
	APPEND TO ARRAY:C911($aEnterable;0)
	APPEND TO ARRAY:C911($aIcono;$t_refIconoNoEditable)
	APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
	APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]PTC_Literal:539))
End if 

If (vi_UsarBonificacion#0)
	OB_SET ($ob_objeto;->aNtaBX;"abx")
	If (<>vb_BloquearModifSituacionFinal)
		APPEND TO ARRAY:C911($aEnterable;0)
		APPEND TO ARRAY:C911($aIcono;$t_refIconoNoEditable)
	Else 
		If ($b_calificacionesEditables)
			APPEND TO ARRAY:C911($aEnterable;1)
			APPEND TO ARRAY:C911($aIcono;$t_refIconoEditable)
		Else 
			APPEND TO ARRAY:C911($aEnterable;0)
			APPEND TO ARRAY:C911($aIcono;$t_refIconoNoEditable)
		End if 
	End if 
	APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
	APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($l_periodo)+"_Bonificacion_Literal")))
End if 

If ([Asignaturas:18]Ingresa_Esfuerzo:40)
	OB_SET ($ob_objeto;->aNtaEsfuerzo;"esfuerzo")
	If (<>vb_BloquearModifSituacionFinal)
		APPEND TO ARRAY:C911($aEnterable;0)
		APPEND TO ARRAY:C911($aIcono;$t_refIconoNoEditable)
	Else 
		If ($b_calificacionesEditables)
			APPEND TO ARRAY:C911($aEnterable;1)
			APPEND TO ARRAY:C911($aIcono;$t_refIconoEditable)
		Else 
			APPEND TO ARRAY:C911($aEnterable;0)
			APPEND TO ARRAY:C911($aIcono;$t_refIconoNoEditable)
		End if 
	End if 
	APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_ComplementoEvaluacion:209]))
	APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(KRL_GetFieldPointerByName ("[Alumnos_ComplementoEvaluacion]P0"+String:C10($l_periodo)+"_Esfuerzo")))
End if 

If (vi_UsarControlesFinPeriodo#0)
	OB_SET ($ob_objeto;->aNtaEXP;"exp")
	If (<>vb_BloquearModifSituacionFinal)
		APPEND TO ARRAY:C911($aEnterable;0)
		APPEND TO ARRAY:C911($aIcono;$t_refIconoNoEditable)
	Else 
		If ($b_calificacionesEditables)
			APPEND TO ARRAY:C911($aEnterable;1)
			APPEND TO ARRAY:C911($aIcono;$t_refIconoEditable)
		Else 
			APPEND TO ARRAY:C911($aEnterable;0)
			APPEND TO ARRAY:C911($aIcono;$t_refIconoNoEditable)
		End if 
	End if 
	APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
	APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($l_periodo)+"_Control_Literal")))
End if 

  //20150915 ASM Ticket 149071
OB_SET ($ob_objeto;->at_Par1_edit;"par1_edit")
OB_SET ($ob_objeto;->at_Par2_edit;"par2_edit")
OB_SET ($ob_objeto;->at_Par3_edit;"par3_edit")
OB_SET ($ob_objeto;->at_Par4_edit;"par4_edit")
OB_SET ($ob_objeto;->at_Par5_edit;"par5_edit")
OB_SET ($ob_objeto;->at_Par6_edit;"par6_edit")
OB_SET ($ob_objeto;->at_Par7_edit;"par7_edit")
OB_SET ($ob_objeto;->at_Par8_edit;"par8_edit")
OB_SET ($ob_objeto;->at_Par9_edit;"par9_edit")
OB_SET ($ob_objeto;->at_Par10_edit;"par10_edit")
OB_SET ($ob_objeto;->at_Par11_edit;"par11_edit")
OB_SET ($ob_objeto;->at_Par12_edit;"par12_edit")

OB_SET ($ob_objeto;->aNta1;"par1")
OB_SET ($ob_objeto;->aNta2;"par2")
OB_SET ($ob_objeto;->aNta3;"par3")
OB_SET ($ob_objeto;->aNta4;"par4")
OB_SET ($ob_objeto;->aNta5;"par5")
OB_SET ($ob_objeto;->aNta6;"par6")
OB_SET ($ob_objeto;->aNta7;"par7")
OB_SET ($ob_objeto;->aNta8;"par8")
OB_SET ($ob_objeto;->aNta9;"par9")
OB_SET ($ob_objeto;->aNta10;"par10")
OB_SET ($ob_objeto;->aNta11;"par11")
OB_SET ($ob_objeto;->aNta12;"par12")

ARRAY TEXT:C222($aNTARecuperatorio;Size of array:C274(aRealEXRecuperatorio))
NTA_PercentArray2StrGradeArray (->aRealEXRecuperatorio;->$aNTARecuperatorio)
OB_SET ($ob_objeto;->$aNTARecuperatorio;"recuperatorio")

  //$isOpen:=((adSTR_Periodos_Cierre{$l_periodo}>Current date(*)) | (adSTR_Periodos_Cierre{$l_periodo}=!00/00/00!) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | ($userID<0))
  //If (<>vb_BloquearModifSituacionFinal)
  //$isOpen:=False
  //End if
  //$calculosSobreCompetencias:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices]ID_Matriz;->[Asignaturas]EVAPR_IdMatriz;->[MPA_AsignaturasMatrices]Convertir_a_Notas)
  //If ($calculosSobreCompetencias)
  //$isOpen:=False
  //End if

  //MONO BLOQUEO DE PARCIALES
$y_array_bloq:=Get pointer:C304("ad_BloqueoParcial_P"+String:C10($l_periodo))

For ($i;1;12)
	Case of 
		: (alAS_EvalPropSourceID{$i}>0)
			APPEND TO ARRAY:C911($aEnterable;0)
			APPEND TO ARRAY:C911($aIcono;$t_refIconoConsolidante)
		: (alAS_EvalPropSourceID{$i}<0)
			APPEND TO ARRAY:C911($aEnterable;0)
			APPEND TO ARRAY:C911($aIcono;$t_refIconoSubAsignatura)
		: (Not:C34(USR_checkRights ("L";->[Alumnos_Calificaciones:208];$userID)))
			APPEND TO ARRAY:C911($aEnterable;0)
			APPEND TO ARRAY:C911($aIcono;$t_refIconoNoEditable)
		: ($y_array_bloq->{$i}>!00-00-00!) & ($y_array_bloq->{$i}<Current date:C33(*))  //MONO BLOQUEO DE PARCIALES
			APPEND TO ARRAY:C911($aEnterable;0)
			APPEND TO ARRAY:C911($aIcono;$t_refIconoNoEditable)
		: ((aiAS_EvalPropEnterable{$i}=1) & ($b_calificacionesEditables))
			APPEND TO ARRAY:C911($aEnterable;1)
			APPEND TO ARRAY:C911($aIcono;$t_refIconoEditable)
		Else 
			APPEND TO ARRAY:C911($aEnterable;0)
			APPEND TO ARRAY:C911($aIcono;$t_refIconoNoEditable)
	End case 
	APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
	APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($l_periodo)+"_Eval"+String:C10($i;"0#")+"_Literal")))
End for 
OB_SET ($ob_objeto;->alAS_EvalPropSourceID;"evalpropid")
OB_SET ($ob_objeto;->atAS_EvalPropSourceName;"evalpropsrcname")
OB_SET ($ob_objeto;->atAS_EvalPropPrintName;"evalpropname")
OB_SET ($ob_objeto;->arAS_EvalPropCoefficient;"coeffprop")
OB_SET ($ob_objeto;->arAS_EvalPropPercent;"percprop")
OB_SET ($ob_objeto;->aNtaStatus;"status")
OB_SET ($ob_objeto;->aNtaReprobada;"reprobada";"Verdadero;Falso")
OB_SET ($ob_objeto;->aNtaRegEximicion;"regeximicion")
OB_SET ($ob_objeto;->aNtaIDAlumno;"idalumno")
OB_SET ($ob_objeto;->aNtaRecNum;"recnum")

OB_SET ($ob_objeto;->$aEnterable;"ingresable")
OB_SET ($ob_objeto;->$aIcono;"iconos")
OB_SET ($ob_objeto;->$aTableNumbers;"tablas")
OB_SET ($ob_objeto;->$aFieldNumbers;"campos")

  // creo y asigno elementos al nodo "iconosDEF"
$ob_nodoIconos:=OB_Create 
OB_SET ($ob_nodoIconos;->$p_iconoEditable;$t_refIconoEditable;".jpg")
OB_SET ($ob_nodoIconos;->$p_iconoNoEditable;$t_refIconoNoEditable;".jpg")
OB_SET ($ob_nodoIconos;->$p_iconoSubAsignatura;$t_refIconoSubAsignatura;".jpg")
OB_SET ($ob_nodoIconos;->$p_iconoConsolidante;$t_refIconoConsolidante;".jpg")
OB_SET ($ob_objeto;->$ob_nodoIconos;"iconosDEF")  // agrego el nodo "iconosDEF" a la raiz

  // creo y asigno elementos al nodo "periodos"
$ob_nodoPeriodos:=OB_Create 
OB_SET ($ob_nodoPeriodos;->atSTR_Periodos_Nombre;"nombres";"")
OB_SET ($ob_nodoPeriodos;->aiSTR_Periodos_Numero;"numeros";"###0")
OB_SET ($ob_nodoPeriodos;->adSTR_Periodos_Desde;"desde";"MM/DD/YYYY")
OB_SET ($ob_nodoPeriodos;->adSTR_Periodos_Hasta;"hasta";"MM/DD/YYYY")
OB_SET ($ob_nodoPeriodos;->adSTR_Periodos_Cierre;"cierre";"MM/DD/YYYY")
OB_SET ($ob_objeto;->$ob_nodoPeriodos;"periodos")  // agrego el nodo "periodos" a la raiz

  // creo y asigno elementos al nodo "opcionesEX"
$ob_nodoOpcionesExamenes:=OB_Create 
If (vr_MinimoExRecuperatorio>0)
	OB_SET_Text ($ob_nodoOpcionesExamenes;NTA_PercentValue2StringValue (vr_MinimoExRecuperatorio);"minexrecuperatorio")
Else 
	OB_SET_Text ($ob_nodoOpcionesExamenes;"0";"minexrecuperatorio")
End if 
If ($enSimbolos)
	OB_SET ($ob_nodoOpcionesExamenes;->vr_MinimoExRecuperatorio;"minexrecuperatorio")
End if 
OB_SET_Long ($ob_nodoOpcionesExamenes;Choose:C955(vi_UsarExamenExtra=1;vi_UsarExRecuperatorio;vi_UsarExamenExtra);"usarexrecuperatorio")
OB_SET ($ob_objeto;->$ob_nodoOpcionesExamenes;"opcionesEX")  // agrego el nodo "opcionesEX" a la raiz

viSTR_NoModificarNotas:=<>viSTR_NoModificarNotas
If (USR_IsGroupMember_by_GrpID (-15001;$userID))
	viSTR_NoModificarNotas:=0
End if 

If (vb_NotaOficialVisible=False:C215)
	For ($i;1;Size of array:C274(aNtaOf))
		If (aNtaOf{$i}#aNtaF{$i})
			vb_NotaOficialVisible:=True:C214
			$i:=Size of array:C274(aNtaOf)+1
		End if 
	End for 
End if 



  // creo y asigno elementos al nodo "parametros"
$ob_nodoParametros:=OB_Create 
OB_SET ($ob_nodoParametros;->$t_fechaBloqueo;"fechabloqueo")
OB_SET_Text ($ob_nodoParametros;String:C10(Num:C11($b_fechaBloqueo));"bloqueo")
OB_SET_Text ($ob_nodoParametros;String:C10($l_periodo);"periodo")
OB_SET_Text ($ob_nodoParametros;String:C10(Num:C11([Asignaturas:18]Resultado_no_calculado:47));"resnocalculado")
OB_SET_Text ($ob_nodoParametros;String:C10(PERIODOS_PeriodosActuales (Current date:C33(*);True:C214));"periodoactual")
OB_SET_Text ($ob_nodoParametros;String:C10(viSTR_NoModificarNotas);"nomodificarnotas")
OB_SET_Text ($ob_nodoParametros;String:C10(Num:C11([Asignaturas:18]Consolidacion_TipoPonderacion:50));"coef_porc")
OB_SET_Text ($ob_nodoParametros;String:C10(Num:C11(vb_NotaOficialVisible));"notaoficialvisible")
If ($modoRegistroAsistencia=4)
	$horas:=[Asignaturas:18]Horas_de_clases_efectivas:52
	OB_SET_Text ($ob_nodoParametros;String:C10($horas);"horasclase")
End if 
OB_SET ($ob_objeto;->$ob_nodoParametros;"parametros")  // agrego el nodo "parametros" a la raiz


  // creo y asigno elementos al nodo "estiloEV"
rMinSimbolo:=""
vt_MinEscalaNotaSim:=""
$ob_nodoEstiloEval:=OB_Create 
If ([Asignaturas:18]Ingresa_Esfuerzo:40)
	OB_SET ($ob_nodoEstiloEval;->aIndEsfuerzo;"indicadoresesfuerzo")
End if 
OB_SET ($ob_nodoEstiloEval;->iConversionTable;"bonificacion")
Case of 
	: (iEvaluationMode=Notas)
		rMinimo:=EV2_Real_a_Nota (rPctMinimum;0;iGradesDec)
		vr_MinEscalaNota:=EV2_Real_a_Nota (vrNTA_MinimoEscalaReferencia;0;iGradesDec)
		OB_SET_Text ($ob_nodoEstiloEval;"notas";"evaluationmode")
		OB_SET ($ob_nodoEstiloEval;->rGradesFrom;"desde")
		OB_SET ($ob_nodoEstiloEval;->rGradesTo;"hasta")
		OB_SET ($ob_nodoEstiloEval;->iGradesDec;"decimales")
		OB_SET ($ob_nodoEstiloEval;->rGradesInterval;"intervalo")
		OB_SET ($ob_nodoEstiloEval;->rMinimo;"minimo")
		OB_SET ($ob_nodoEstiloEval;->vr_MinEscalaNota;"minimoescala")
		If (iConversionTable=1)
			OB_SET ($ob_nodoEstiloEval;->arEVS_ConvGrades;"BON";vs_GradesFormat)
		End if 
	: (iEvaluationMode=Puntos)
		rMinimo:=EV2_Real_a_Puntos (rPctMinimum;0;iPointsDec)
		vr_MinEscalaNota:=EV2_Real_a_Puntos (vrNTA_MinimoEscalaReferencia;0;iPointsDec)
		OB_SET_Text ($ob_nodoEstiloEval;"puntos";"evaluationmode")
		OB_SET ($ob_nodoEstiloEval;->rPointsFrom;"desde")
		OB_SET ($ob_nodoEstiloEval;->rPointsTo;"hasta")
		OB_SET ($ob_nodoEstiloEval;->iPointsDec;"decimales")
		OB_SET ($ob_nodoEstiloEval;->rPointsInterval;"intervalo")
		OB_SET ($ob_nodoEstiloEval;->rMinimo;"minimo")
		OB_SET ($ob_nodoEstiloEval;->vr_MinEscalaNota;"minimoescala")
		If (iConversionTable=1)
			OB_SET ($ob_nodoEstiloEval;->arEVS_ConvPoints;"BON";vs_pointsFormat)
		End if 
	: (iEvaluationMode=Simbolos)
		rMinSimbolo:=EV2_Real_a_Simbolo (rPctMinimum)
		vt_MinEscalaNotaSim:=EV2_Real_a_Simbolo (vrNTA_MinimoEscalaReferencia)
		OB_SET_Text ($ob_nodoEstiloEval;"simbolos";"evaluationmode")
		OB_SET ($ob_nodoEstiloEval;->aSymbol;"simbolos")
		OB_SET ($ob_nodoEstiloEval;->rMinSimbolo;"minimo")
		OB_SET ($ob_nodoEstiloEval;->vt_MinEscalaNotaSim;"minimoescala")
		OB_SET ($ob_nodoEstiloEval;->rPctMinimum;"minimoreal")
		OB_SET ($ob_nodoEstiloEval;->vrNTA_MinimoEscalaReferencia;"minimoescalareal")
	: (iEvaluationMode=Porcentaje)
		rMinimo:=rPctMinimum
		vr_MinEscalaNota:=vrNTA_MinimoEscalaReferencia
		OB_SET ($ob_nodoEstiloEval;->rMinimo;"minimo")
		OB_SET ($ob_nodoEstiloEval;->vr_MinEscalaNota;"minimoescala")
		OB_SET_Text ($ob_nodoEstiloEval;"porcentaje";"evaluationmode")
End case 

OB_SET ($ob_nodoEstiloEval;-><>vs_AppDecimalSeparator;"separador")  //MONO TICKET 147334

If ([Asignaturas:18]Ingresa_Esfuerzo:40)
	OB_SET ($ob_nodoEstiloEval;->aIndEsfuerzo;"ESF_indicadores")
	OB_SET ($ob_nodoEstiloEval;->r1_EvEsfuerzoIndicadores;"ESF_usaindicadores")
	OB_SET ($ob_nodoEstiloEval;->r2_EvEsfuerzoBonificacion;"ESF_usabonificacion")
End if 
  // agrego el nodo "estiloEV" a la raiz
OB_SET ($ob_objeto;->$ob_nodoEstiloEval;"estiloEV")


  //============
  // creo y asigno elementos al nodo "estiloEVOficial"
$idEstiloOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]EvStyle_oficial:23)
EVS_ReadStyleData ($idEstiloOficial)
$ob_nodoEstiloEvalOficial:=OB_Create 
Case of 
	: (iEvaluationMode=Notas)
		$r_minimo:=EV2_Real_a_Nota (rPctMinimum;0;iGradesDec)
		$r_minimoEscala:=EV2_Real_a_Nota (vrNTA_MinimoEscalaReferencia;0;iGradesDec)
		OB_SET_Text ($ob_nodoEstiloEvalOficial;"notas";"evaluationmode")
		OB_SET ($ob_nodoEstiloEvalOficial;->$r_minimo;"minimo")
		OB_SET ($ob_nodoEstiloEvalOficial;->$r_minimoEscala;"minimoescala")
	: (iEvaluationMode=Puntos)
		$r_minimo:=EV2_Real_a_Puntos (rPctMinimum;0;iPointsDec)
		$r_minimoEscala:=EV2_Real_a_Puntos (vrNTA_MinimoEscalaReferencia;0;iPointsDec)
		OB_SET_Text ($ob_nodoEstiloEvalOficial;"puntos";"evaluationmode")
		OB_SET ($ob_nodoEstiloEvalOficial;->$r_minimo;"minimo")
		OB_SET ($ob_nodoEstiloEvalOficial;->$r_minimoEscala;"minimoescala")
	: (iEvaluationMode=Simbolos)
		$t_minimoSimbolo:=EV2_Real_a_Simbolo (rPctMinimum)
		$t_minimoEscalaSimbolos:=EV2_Real_a_Simbolo (vrNTA_MinimoEscalaReferencia)
		OB_SET_Text ($ob_nodoEstiloEvalOficial;"simbolos";"evaluationmode")
		OB_SET ($ob_nodoEstiloEvalOficial;->aSymbol;"simbolos")
		OB_SET ($ob_nodoEstiloEvalOficial;->$t_minimoSimbolo;"minimo")
		OB_SET ($ob_nodoEstiloEvalOficial;->$t_minimoEscalaSimbolos;"minimoescala")
		OB_SET ($ob_nodoEstiloEvalOficial;->rPctMinimum;"minimoreal")
		OB_SET ($ob_nodoEstiloEvalOficial;->vrNTA_MinimoEscalaReferencia;"minimoescalareal")
	: (iEvaluationMode=Porcentaje)
		OB_SET ($ob_nodoEstiloEvalOficial;->rPctMinimum;"minimo")
		OB_SET ($ob_nodoEstiloEvalOficial;->vrNTA_MinimoEscalaReferencia;"minimoescala")
		OB_SET_Text ($ob_nodoEstiloEvalOficial;"porcentaje";"evaluationmode")
End case 
  // agrego el nodo "estiloEVOficial" a la raiz
OB_SET ($ob_objeto;->$ob_nodoEstiloEvalOficial;"estiloEVOficial")

  // creo y asigno elementos al nodo "privilegios"
$ob_nodoPrivilegios:=OB_Create 
OB_SET_Long ($ob_nodoPrivilegios;Num:C11(USR_checkRights ("A";->[Alumnos_Calificaciones:208];$userID));"calificaciones_A")
OB_SET_Long ($ob_nodoPrivilegios;Num:C11(USR_checkRights ("A";->[Alumnos_Calificaciones:208];$userID));"calificaciones_A")
OB_SET_Long ($ob_nodoPrivilegios;Num:C11(USR_checkRights ("M";->[Alumnos_Calificaciones:208];$userID));"calificaciones_M")
OB_SET_Long ($ob_nodoPrivilegios;Num:C11(USR_checkRights ("D";->[Alumnos_Calificaciones:208];$userID));"calificaciones_D")
OB_SET_Long ($ob_nodoPrivilegios;Num:C11(USR_checkRights ("L";->[Alumnos_Calificaciones:208];$userID));"calificaciones_L")
OB_SET_Long ($ob_nodoPrivilegios;Num:C11(USR_checkRights ("A";->[Asignaturas:18];$userID));"asignaturas_A")
OB_SET_Long ($ob_nodoPrivilegios;Num:C11(USR_checkRights ("M";->[Asignaturas:18];$userID));"asignaturas_M")
OB_SET_Long ($ob_nodoPrivilegios;Num:C11(USR_checkRights ("D";->[Asignaturas:18];$userID));"asignaturas_D")
OB_SET_Long ($ob_nodoPrivilegios;Num:C11(USR_checkRights ("L";->[Asignaturas:18];$userID));"asignaturas_L")
OB_SET ($ob_objeto;->$ob_nodoPrivilegios;"privilegios")

  //MONO 186325
$ob_nomEvaGral:=OB_Create 
LOC_ObjNombreColumnasEval ("consultar";->$ob_nomEvaGral;[Asignaturas:18]Numero_del_Nivel:6)
OB_SET ($ob_objeto;->$ob_nomEvaGral;"nombreColumnasEvaluaciones")

$t_json:=OB_Object2Json ($ob_objeto)


$0:=$t_json

