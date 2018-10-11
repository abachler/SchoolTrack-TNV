//%attributes = {}
  // MÉTODO: EV2_ResultadosAsignatura
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 01/03/12, 12:34:29
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // EV2_ResultadosAsignatura()
  // ----------------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($i;$l_aprobados;$l_IdEstiloEvaluacionOficial;$l_recNumAsignatura)
C_REAL:C285($r_promedioOficial)
C_TEXT:C284($t_llaveAsignatura)

ARRAY BOOLEAN:C223($ab_asignaturaReprobada;0)
ARRAY REAL:C219($ar_RealEX;0)
ARRAY REAL:C219($ar_RealF;0)
ARRAY REAL:C219($ar_RealOf;0)
ARRAY REAL:C219($ar_RealP1;0)
ARRAY REAL:C219($ar_RealP2;0)
ARRAY REAL:C219($ar_RealP3;0)
ARRAY REAL:C219($ar_RealP4;0)
ARRAY REAL:C219($ar_RealP5;0)
ARRAY REAL:C219($ar_RealPF;0)
If (False:C215)
	C_LONGINT:C283(EV2_ResultadosAsignatura ;$1)
End if 




  // CODIGO PRINCIPAL
EVS_LoadStyles 

READ ONLY:C145([Alumnos_Calificaciones:208])
READ ONLY:C145([Alumnos_Calificaciones:208])

If (Count parameters:C259=1)
	$l_recNumAsignatura:=$1
	KRL_GotoRecord (->[Asignaturas:18];$l_recNumAsignatura;True:C214)
End if 

If (OK=1)
	
	EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
	EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
	If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
		
		$t_llaveAsignatura:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Asignaturas:18]Numero:1)
		$l_recNumAsignatura:=KRL_FindAndLoadRecordByIndex (->[Asignaturas_SintesisAnual:202]LLavePrimaria:5;->$t_llaveAsignatura;True:C214)
		If ($l_recNumAsignatura<0)
			CREATE RECORD:C68([Asignaturas_SintesisAnual:202])
			[Asignaturas_SintesisAnual:202]ID_Institucion:1:=<>gInstitucion
			[Asignaturas_SintesisAnual:202]Año:3:=<>gYear
			[Asignaturas_SintesisAnual:202]ID_Asignatura:2:=[Asignaturas:18]Numero:1
			SAVE RECORD:C53([Asignaturas_SintesisAnual:202])
			OK:=1
		End if 
		
		If (OK=1)
			
			  // Modificado por: Saúl Ponce - Daniel Ledezma (01-09-2016) - Ticket N° 166706 
			  // Se producían diferencias en los promedios al utilizar los promedios de período no aproximados. En el ticket mencionado, los promedios almacenados en la tabla 
			  // [Asignaturas_SintesisAnual]PromedioOficial_Real y [Asignaturas_SintesisAnual]P01_Promedio_Real, eran diferentes aún cuando no habían evaluaciones ingresadas en el segundo período.
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			  // SELECTION TO ARRAY([Alumnos_Calificaciones]Anual_Real;$ar_RealPF;[Alumnos_Calificaciones]ExamenAnual_Real;$ar_RealEX;[Alumnos_Calificaciones]EvaluacionFinal_Real;$ar_RealF;[Alumnos_Calificaciones]EvaluacionFinalOficial_Real;$ar_RealOf;[Alumnos_Calificaciones]P01_Final_RealNoAproximado;$ar_RealP1;[Alumnos_Calificaciones]P02_Final_RealNoAproximado;$ar_RealP2;[Alumnos_Calificaciones]P03_Final_RealNoAproximado;$ar_RealP3;[Alumnos_Calificaciones]P04_Final_RealNoAproximado;$ar_RealP4;[Alumnos_Calificaciones]P05_Final_RealNoAproximado;$ar_RealP5;[Alumnos_Calificaciones]Reprobada;$ab_asignaturaReprobada)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]Anual_Real:11;$ar_RealPF;[Alumnos_Calificaciones:208]ExamenAnual_Real:16;$ar_RealEX;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;$ar_RealF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;$ar_RealOf;[Alumnos_Calificaciones:208]P01_Final_Real:112;$ar_RealP1;[Alumnos_Calificaciones:208]P02_Final_Real:187;$ar_RealP2;[Alumnos_Calificaciones:208]P03_Final_Real:262;$ar_RealP3;[Alumnos_Calificaciones:208]P04_Final_Real:337;$ar_RealP4;[Alumnos_Calificaciones:208]P05_Final_Real:412;$ar_RealP5;[Alumnos_Calificaciones:208]Reprobada:9;$ab_asignaturaReprobada)
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			[Asignaturas_SintesisAnual:202]PromedioAnual_Real:10:=AS_fAverage (->$ar_RealPF)
			[Asignaturas_SintesisAnual:202]PromedioAnual_Nota:11:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]PromedioAnual_Real:10;0;4)
			[Asignaturas_SintesisAnual:202]PromedioAnual_Puntos:12:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]PromedioAnual_Real:10;0;4)
			[Asignaturas_SintesisAnual:202]PromedioAnual_Simbolo:13:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]PromedioAnual_Real:10)
			[Asignaturas_SintesisAnual:202]PromedioAnual_Literal:14:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]PromedioAnual_Real:10;iEvaluationMode;vlNTA_DecimalesPF)
			[Asignaturas_SintesisAnual:202]PromedioFinal_Real:15:=AS_fAverage (->$ar_RealF)
			[Asignaturas_SintesisAnual:202]PromedioFinal_Nota:16:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]PromedioFinal_Real:15;0;4)
			[Asignaturas_SintesisAnual:202]PromedioFinal_Puntos:17:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]PromedioFinal_Real:15;0;4)
			[Asignaturas_SintesisAnual:202]PromedioFinal_Simbolo:18:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]PromedioFinal_Real:15)
			[Asignaturas_SintesisAnual:202]PromedioFinal_Literal:19:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]PromedioFinal_Real:15;iEvaluationMode;vlNTA_DecimalesNF)
			[Asignaturas_SintesisAnual:202]P01_Promedio_Real:25:=AS_fAverage (->$ar_RealP1)
			[Asignaturas_SintesisAnual:202]P01_Promedio_Nota:26:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]P01_Promedio_Real:25;0;4)
			[Asignaturas_SintesisAnual:202]P01_Promedio_Puntos:27:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]P01_Promedio_Real:25;0;4)
			[Asignaturas_SintesisAnual:202]P01_Promedio_Simbolo:28:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]P01_Promedio_Real:25)
			[Asignaturas_SintesisAnual:202]P01_Promedio_Literal:29:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]P01_Promedio_Real:25;iEvaluationMode;vlNTA_DecimalesPP)
			[Asignaturas_SintesisAnual:202]P02_Promedio_Real:30:=AS_fAverage (->$ar_RealP2)
			[Asignaturas_SintesisAnual:202]P02_Promedio_Nota:31:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]P02_Promedio_Real:30;0;4)
			[Asignaturas_SintesisAnual:202]P02_Promedio_Puntos:32:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]P02_Promedio_Real:30;0;4)
			[Asignaturas_SintesisAnual:202]P02_Promedio_Simbolo:33:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]P02_Promedio_Real:30)
			[Asignaturas_SintesisAnual:202]P02_Promedio_Literal:34:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]P02_Promedio_Real:30;iEvaluationMode;vlNTA_DecimalesPP)
			[Asignaturas_SintesisAnual:202]P03_Promedio_Real:35:=AS_fAverage (->$ar_RealP3)
			[Asignaturas_SintesisAnual:202]P03_Promedio_Nota:36:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]P03_Promedio_Real:35;0;4)
			[Asignaturas_SintesisAnual:202]P03_Promedio_Puntos:37:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]P03_Promedio_Real:35;0;4)
			[Asignaturas_SintesisAnual:202]P03_Promedio_Simbolo:38:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]P03_Promedio_Real:35)
			[Asignaturas_SintesisAnual:202]P03_Promedio_Literal:39:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]P03_Promedio_Real:35;iEvaluationMode;vlNTA_DecimalesPP)
			[Asignaturas_SintesisAnual:202]P04_Promedio_Real:40:=AS_fAverage (->$ar_RealP4)
			[Asignaturas_SintesisAnual:202]P04_Promedio_Nota:41:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]P04_Promedio_Real:40;0;4)
			[Asignaturas_SintesisAnual:202]P04_Promedio_Puntos:42:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]P04_Promedio_Real:40;0;4)
			[Asignaturas_SintesisAnual:202]P04_Promedio_Simbolo:43:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]P04_Promedio_Real:40)
			[Asignaturas_SintesisAnual:202]P04_Promedio_Literal:44:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]P04_Promedio_Real:40;iEvaluationMode;vlNTA_DecimalesPP)
			[Asignaturas_SintesisAnual:202]P05_Promedio_Real:45:=AS_fAverage (->$ar_RealP5)
			[Asignaturas_SintesisAnual:202]P05_Promedio_Nota:46:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]P05_Promedio_Real:45;0;4)
			[Asignaturas_SintesisAnual:202]P05_Promedio_Puntos:47:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]P05_Promedio_Real:45;0;4)
			[Asignaturas_SintesisAnual:202]P05_Promedio_Simbolo:48:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]P05_Promedio_Real:45)
			[Asignaturas_SintesisAnual:202]P05_Promedio_Literal:49:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]P05_Promedio_Real:45;iEvaluationMode;vlNTA_DecimalesPP)
			[Asignaturas_SintesisAnual:202]P01_Minimo_Real:50:=AS_fMinimum (->$ar_RealP1)
			[Asignaturas_SintesisAnual:202]P02_Minimo_Real:51:=AS_fMinimum (->$ar_RealP2)
			[Asignaturas_SintesisAnual:202]P03_Minimo_Real:52:=AS_fMinimum (->$ar_RealP3)
			[Asignaturas_SintesisAnual:202]P04_Minimo_Real:53:=AS_fMinimum (->$ar_RealP4)
			[Asignaturas_SintesisAnual:202]P05_Minimo_Real:54:=AS_fMinimum (->$ar_RealP5)
			[Asignaturas_SintesisAnual:202]P01_Minimo_Nota:55:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]P01_Minimo_Real:50;0;4)
			[Asignaturas_SintesisAnual:202]P02_Minimo_Nota:56:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]P02_Minimo_Real:51;0;4)
			[Asignaturas_SintesisAnual:202]P03_Minimo_Nota:57:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]P03_Minimo_Real:52;0;4)
			[Asignaturas_SintesisAnual:202]P04_Minimo_Nota:58:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]P04_Minimo_Real:53;0;4)
			[Asignaturas_SintesisAnual:202]P05_Minimo_Nota:59:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]P05_Minimo_Real:54;0;4)
			[Asignaturas_SintesisAnual:202]P01_Minimo_Puntos:60:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]P01_Minimo_Real:50;0;4)
			[Asignaturas_SintesisAnual:202]P02_Minimo_Puntos:61:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]P02_Minimo_Real:51;0;4)
			[Asignaturas_SintesisAnual:202]P03_Minimo_Puntos:62:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]P03_Minimo_Real:52;0;4)
			[Asignaturas_SintesisAnual:202]P04_Minimo_Puntos:63:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]P04_Minimo_Real:53;0;4)
			[Asignaturas_SintesisAnual:202]P05_Minimo_Puntos:64:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]P05_Minimo_Real:54;0;4)
			[Asignaturas_SintesisAnual:202]P01_Minimo_Literal:65:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]P01_Minimo_Real:50;iEvaluationMode;vlNTA_DecimalesPP)
			[Asignaturas_SintesisAnual:202]P02_Minimo_Literal:66:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]P02_Minimo_Real:51;iEvaluationMode;vlNTA_DecimalesPP)
			[Asignaturas_SintesisAnual:202]P03_Minimo_Literal:67:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]P03_Minimo_Real:52;iEvaluationMode;vlNTA_DecimalesPP)
			[Asignaturas_SintesisAnual:202]P04_Minimo_Literal:68:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]P04_Minimo_Real:53;iEvaluationMode;vlNTA_DecimalesPP)
			[Asignaturas_SintesisAnual:202]P05_Minimo_Literal:69:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]P05_Minimo_Real:54;iEvaluationMode;vlNTA_DecimalesPP)
			[Asignaturas_SintesisAnual:202]P01_Minimo_Simbolo:70:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]P01_Minimo_Real:50)
			[Asignaturas_SintesisAnual:202]P02_Minimo_Simbolo:71:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]P02_Minimo_Real:51)
			[Asignaturas_SintesisAnual:202]P03_Minimo_Simbolo:72:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]P03_Minimo_Real:52)
			[Asignaturas_SintesisAnual:202]P04_Minimo_Simbolo:73:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]P04_Minimo_Real:53)
			[Asignaturas_SintesisAnual:202]P05_Minimo_Simbolo:74:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]P05_Minimo_Real:54)
			[Asignaturas_SintesisAnual:202]Anual_Minimo_Real:75:=AS_fMinimum (->$ar_RealPF)
			[Asignaturas_SintesisAnual:202]Anual_Minimo_Nota:76:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]Anual_Minimo_Real:75;0;4)
			[Asignaturas_SintesisAnual:202]Anual_Minimo_Puntos:77:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]Anual_Minimo_Real:75;0;4)
			[Asignaturas_SintesisAnual:202]Anual_Minimo_Simbolo:78:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]Anual_Minimo_Real:75;0;4)
			[Asignaturas_SintesisAnual:202]Anual_Minimo_Literal:79:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]Anual_Minimo_Real:75;iEvaluationMode;vlNTA_DecimalesPF)
			[Asignaturas_SintesisAnual:202]Final_Minimo_Real:80:=AS_fMinimum (->$ar_RealF)
			[Asignaturas_SintesisAnual:202]Final_Minimo_Nota:81:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]Final_Minimo_Real:80;0;4)
			[Asignaturas_SintesisAnual:202]Final_Minimo_Puntos:82:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]Final_Minimo_Real:80;0;4)
			[Asignaturas_SintesisAnual:202]Final_Minimo_Simbolo:84:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]Final_Minimo_Real:80)
			[Asignaturas_SintesisAnual:202]Final_Minimo_Literal:83:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]Final_Minimo_Real:80;iEvaluationMode;vlNTA_DecimalesNF)
			[Asignaturas_SintesisAnual:202]P01_Maximo_Real:85:=AS_fMaximum (->$ar_RealP1)
			[Asignaturas_SintesisAnual:202]P02_Maximo_Real:86:=AS_fMaximum (->$ar_RealP2)
			[Asignaturas_SintesisAnual:202]P03_Maximo_Real:87:=AS_fMaximum (->$ar_RealP3)
			[Asignaturas_SintesisAnual:202]P04_Maximo_Real:88:=AS_fMaximum (->$ar_RealP4)
			[Asignaturas_SintesisAnual:202]P05_Maximo_Real:89:=AS_fMaximum (->$ar_RealP5)
			[Asignaturas_SintesisAnual:202]P01_Maximo_Nota:90:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]P01_Maximo_Real:85;0;4)
			[Asignaturas_SintesisAnual:202]P02_Maximo_Nota:91:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]P02_Maximo_Real:86;0;4)
			[Asignaturas_SintesisAnual:202]P03_Maximo_Nota:92:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]P03_Maximo_Real:87;0;4)
			[Asignaturas_SintesisAnual:202]P04_Maximo_Nota:93:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]P04_Maximo_Real:88;0;4)
			[Asignaturas_SintesisAnual:202]P05_Maximo_Nota:94:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]P05_Maximo_Real:89;0;4)
			[Asignaturas_SintesisAnual:202]P01_Maximo_Puntos:95:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]P01_Maximo_Real:85;0;4)
			[Asignaturas_SintesisAnual:202]P02_Maximo_Puntos:96:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]P02_Maximo_Real:86;0;4)
			[Asignaturas_SintesisAnual:202]P03_Maximo_Puntos:97:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]P03_Maximo_Real:87;0;4)
			[Asignaturas_SintesisAnual:202]P04_Maximo_Puntos:98:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]P04_Maximo_Real:88;0;4)
			[Asignaturas_SintesisAnual:202]P05_Maximo_Puntos:99:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]P05_Maximo_Real:89;0;4)
			[Asignaturas_SintesisAnual:202]P01_Maximo_Simbolo:100:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]P01_Maximo_Real:85)
			[Asignaturas_SintesisAnual:202]P02_Maximo_Simbolo:101:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]P02_Maximo_Real:86)
			[Asignaturas_SintesisAnual:202]P03_Maximo_Simbolo:102:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]P03_Maximo_Real:87)
			[Asignaturas_SintesisAnual:202]P04_Maximo_Simbolo:103:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]P04_Maximo_Real:88)
			[Asignaturas_SintesisAnual:202]P05_Maximo_Simbolo:104:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]P05_Maximo_Real:89)
			[Asignaturas_SintesisAnual:202]P01_Maximo_Literal:105:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]P01_Maximo_Real:85;iEvaluationMode;vlNTA_DecimalesPP)
			[Asignaturas_SintesisAnual:202]P02_Maximo_Literal:106:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]P02_Maximo_Real:86;iEvaluationMode;vlNTA_DecimalesPP)
			[Asignaturas_SintesisAnual:202]P03_Maximo_Literal:107:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]P03_Maximo_Real:87;iEvaluationMode;vlNTA_DecimalesPP)
			[Asignaturas_SintesisAnual:202]P04_Maximo_Literal:108:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]P04_Maximo_Real:88;iEvaluationMode;vlNTA_DecimalesPP)
			[Asignaturas_SintesisAnual:202]P05_Maximo_Literal:109:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]P05_Maximo_Real:89;iEvaluationMode;vlNTA_DecimalesPP)
			[Asignaturas_SintesisAnual:202]Anual_Maximo_Real:110:=AS_fMaximum (->$ar_RealPF)
			[Asignaturas_SintesisAnual:202]Anual_Maximo_Nota:111:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]Anual_Maximo_Real:110;0;4)
			[Asignaturas_SintesisAnual:202]Anual_Maximo_Puntos:112:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]Anual_Maximo_Real:110;0;4)
			[Asignaturas_SintesisAnual:202]Anual_Maximo_Simbolo:113:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]Anual_Maximo_Real:110;0;4)
			[Asignaturas_SintesisAnual:202]Anual_Maximo_Literal:114:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]Anual_Maximo_Real:110;iEvaluationMode;vlNTA_DecimalesPF)
			[Asignaturas_SintesisAnual:202]Final_Maximo_Real:115:=AS_fMaximum (->$ar_RealF)
			[Asignaturas_SintesisAnual:202]Final_Maximo_Nota:116:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]Final_Maximo_Real:115;0;4)
			[Asignaturas_SintesisAnual:202]Final_Maximo_Puntos:117:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]Final_Maximo_Real:115;0;4)
			[Asignaturas_SintesisAnual:202]Final_Maximo_Simbolo:118:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]Final_Maximo_Real:115)
			[Asignaturas_SintesisAnual:202]Final_Maximo_Literal:119:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]Final_Maximo_Real:115;iEvaluationMode;vlNTA_DecimalesPF)
			[Asignaturas_SintesisAnual:202]PorcentajeAprobados:120:=100
			[Asignaturas_SintesisAnual:202]NumeroReprobados:121:=0
			[Asignaturas_SintesisAnual:202]Examen_Minimo_Real:122:=AS_fMinimum (->$ar_RealEX)
			[Asignaturas_SintesisAnual:202]Examen_Minimo_Nota:123:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]Examen_Minimo_Real:122;0;4)
			[Asignaturas_SintesisAnual:202]Examen_Minimo_Puntos:124:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]Examen_Minimo_Real:122;0;4)
			[Asignaturas_SintesisAnual:202]Examen_Minimo_Simbolo:125:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]Examen_Minimo_Real:122)
			[Asignaturas_SintesisAnual:202]Examen_Minimo_Literal:126:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]Examen_Minimo_Real:122;iEvaluationMode;vlNTA_DecimalesParciales)
			[Asignaturas_SintesisAnual:202]Examen_Maximo_Real:127:=AS_fMaximum (->$ar_RealEX)
			[Asignaturas_SintesisAnual:202]Examen_Maximo_Nota:128:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]Examen_Maximo_Real:127;0;4)
			[Asignaturas_SintesisAnual:202]Examen_Maximo_Puntos:129:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]Examen_Maximo_Real:127;0;4)
			[Asignaturas_SintesisAnual:202]Examen_Maximo_Simbolo:130:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]Examen_Maximo_Real:127)
			[Asignaturas_SintesisAnual:202]Examen_Maximo_Literal:131:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]Examen_Maximo_Real:127;iEvaluationMode;vlNTA_DecimalesParciales)
			[Asignaturas_SintesisAnual:202]Examen_Promedio_Real:132:=AS_fAverage (->$ar_RealEX)
			[Asignaturas_SintesisAnual:202]Examen_Promedio_Nota:133:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]Examen_Promedio_Real:132;0;4)
			[Asignaturas_SintesisAnual:202]Examen_Promedio_Puntos:134:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]Examen_Promedio_Real:132;0;4)
			[Asignaturas_SintesisAnual:202]Examen_Promedio_Simbolo:135:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]Examen_Promedio_Real:132)
			[Asignaturas_SintesisAnual:202]Examen_Promedio_Literal:136:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]Examen_Promedio_Real:132;iEvaluationMode;vlNTA_DecimalesParciales)
			
			$r_promedioOficial:=AS_fAverage (->$ar_RealOf)
			$l_IdEstiloEvaluacionOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]EvStyle_oficial:23)
			[Asignaturas_SintesisAnual:202]Oficial_Minimo_Real:137:=AS_fMinimum (->$ar_RealOF)
			[Asignaturas_SintesisAnual:202]Oficial_Minimo_Nota:138:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]Oficial_Minimo_Real:137;0;4)
			[Asignaturas_SintesisAnual:202]Oficial_Minimo_Puntos:139:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]Oficial_Minimo_Real:137;0;4)
			[Asignaturas_SintesisAnual:202]Oficial_Minimo_Simbolo:140:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]Oficial_Minimo_Real:137)
			[Asignaturas_SintesisAnual:202]Oficial_Minimo_Literal:141:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]Oficial_Minimo_Real:137;iPrintActa;vlNTA_DecimalesNO)
			[Asignaturas_SintesisAnual:202]Oficial_Maximo_Real:142:=AS_fMaximum (->$ar_RealOF)
			[Asignaturas_SintesisAnual:202]Oficial_Maximo_Nota:143:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]Oficial_Maximo_Real:142;0;4)
			[Asignaturas_SintesisAnual:202]Oficial_Maximo_Puntos:144:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]Oficial_Maximo_Real:142;0;4)
			[Asignaturas_SintesisAnual:202]Oficial_Maximo_Simbolo:145:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]Oficial_Maximo_Real:142)
			[Asignaturas_SintesisAnual:202]Oficial_Maximo_Literal:146:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]Oficial_Maximo_Real:142;iPrintActa;vlNTA_DecimalesNO)
			[Asignaturas_SintesisAnual:202]PromedioOficial_Real:20:=AS_fAverage (->$ar_RealOF)
			[Asignaturas_SintesisAnual:202]PromedioOficial_Nota:21:=EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]PromedioOficial_Real:20;0;4)
			[Asignaturas_SintesisAnual:202]PromedioOficial_Puntos:22:=EV2_Real_a_Puntos ([Asignaturas_SintesisAnual:202]PromedioOficial_Real:20;0;4)
			[Asignaturas_SintesisAnual:202]PromedioOficial_Simbolo:23:=EV2_Real_a_Simbolo ([Asignaturas_SintesisAnual:202]PromedioOficial_Real:20)
			[Asignaturas_SintesisAnual:202]PromedioOficial_Literal:24:=EV2_Real_a_Literal ([Asignaturas_SintesisAnual:202]PromedioOficial_Real:20;iPrintActa;vlNTA_DecimalesNO)
			
			$l_aprobados:=0
			For ($i;1;Size of array:C274($ab_asignaturaReprobada))
				$l_aprobados:=$l_aprobados+Num:C11(Not:C34($ab_asignaturaReprobada{$i}))
			End for 
			
			If (Size of array:C274($ab_asignaturaReprobada)>0)
				[Asignaturas_SintesisAnual:202]PorcentajeAprobados:120:=Round:C94($l_aprobados/Size of array:C274($ab_asignaturaReprobada)*100;2)
			Else 
				[Asignaturas_SintesisAnual:202]PorcentajeAprobados:120:=0
			End if 
			
			  //KRL_SaveRecord (->[Asignaturas_SintesisAnual])
			SAVE RECORD:C53([Asignaturas_SintesisAnual:202])
			KRL_ReloadAsReadOnly (->[Asignaturas_SintesisAnual:202])
			
			[Asignaturas:18]Promedio_final:20:=[Asignaturas_SintesisAnual:202]PromedioAnual_Real:10
			[Asignaturas:18]Min_PF:79:=[Asignaturas_SintesisAnual:202]Anual_Minimo_Real:75
			[Asignaturas:18]Max_PF:86:=[Asignaturas_SintesisAnual:202]Anual_Maximo_Real:110
			
			[Asignaturas:18]Min_EX:80:=[Asignaturas_SintesisAnual:202]Examen_Minimo_Real:122
			[Asignaturas:18]Max_EX:87:=[Asignaturas_SintesisAnual:202]Examen_Maximo_Real:127
			[Asignaturas:18]Examen:19:=[Asignaturas_SintesisAnual:202]Examen_Promedio_Real:132
			
			[Asignaturas:18]Min_Final:81:=[Asignaturas_SintesisAnual:202]Final_Minimo_Real:80
			[Asignaturas:18]Max_Final:88:=[Asignaturas_SintesisAnual:202]Final_Maximo_Real:115
			[Asignaturas:18]Nota_final:18:=[Asignaturas_SintesisAnual:202]PromedioFinal_Real:15
			
			[Asignaturas:18]Promedio_P1:23:=[Asignaturas_SintesisAnual:202]P01_Promedio_Real:25
			[Asignaturas:18]Min_P1:75:=[Asignaturas_SintesisAnual:202]P01_Minimo_Real:50
			[Asignaturas:18]Max_P1:82:=[Asignaturas_SintesisAnual:202]P01_Maximo_Real:85
			
			[Asignaturas:18]Promedio_P2:22:=[Asignaturas_SintesisAnual:202]P02_Promedio_Real:30
			[Asignaturas:18]Min_P2:76:=[Asignaturas_SintesisAnual:202]P02_Minimo_Real:51
			[Asignaturas:18]Max_P2:83:=[Asignaturas_SintesisAnual:202]P02_Maximo_Real:86
			
			[Asignaturas:18]Promedio_P3:21:=[Asignaturas_SintesisAnual:202]P03_Promedio_Real:35
			[Asignaturas:18]Min_P3:77:=[Asignaturas_SintesisAnual:202]P03_Minimo_Real:52
			[Asignaturas:18]Max_P3:84:=[Asignaturas_SintesisAnual:202]P03_Maximo_Real:87
			
			[Asignaturas:18]Promedio_P4:59:=[Asignaturas_SintesisAnual:202]P04_Promedio_Real:40
			[Asignaturas:18]Min_P4:78:=[Asignaturas_SintesisAnual:202]P04_Minimo_Real:53
			[Asignaturas:18]Max_P4:85:=[Asignaturas_SintesisAnual:202]P04_Maximo_Real:88
			
			If (([Asignaturas:18]Nota_final:18>=vrNTA_MinimoEscalaReferencia) & ([Asignaturas:18]Promedio_final:20=0))
				[Asignaturas:18]Promedio_final:20:=[Asignaturas:18]Nota_final:18
			End if 
			[Asignaturas:18]PromedioFinal_texto:53:=[Asignaturas_SintesisAnual:202]PromedioFinal_Literal:19
			
			[Asignaturas:18]PromedioFinalOficial_texto:67:=[Asignaturas_SintesisAnual:202]PromedioOficial_Literal:24
			
			[Asignaturas:18]PorcentajeAprobados:103:=[Asignaturas_SintesisAnual:202]PorcentajeAprobados:120
			SAVE RECORD:C53([Asignaturas:18])
			KRL_ReloadAsReadOnly (->[Asignaturas:18])
			
		End if 
	End if 
	
Else 
	$0:=BM_CreateRequest ("EV2_ResultadosAsignatura";String:C10([Asignaturas:18]Numero:1))
	
End if 