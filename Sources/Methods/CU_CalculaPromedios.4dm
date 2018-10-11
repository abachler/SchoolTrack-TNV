//%attributes = {}
  // CU_CalculaPromedios()
  // Por: Alberto Bachler K.: 11-03-14, 17:43:00
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------




C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_LONGINT:C283($iAlumnos;$iNotas;$l_nivelDelCurso;$l_recNumCurso;$l_IdEstiloEvaluacionInterno;$l_IdEstiloEvaluacionOficial)
C_REAL:C285($r_promedioNF;$r_promedioNO;$r_promedioP1;$r_promedioP2;$r_promedioP3;$r_promedioP4;$r_promedioP5;$r_promedioPF)
C_TEXT:C284($t_llaveRegistroSintesisCurso;$t_nombreDelCurso)

ARRAY BOOLEAN:C223($ab_IncidePromedio;0)
ARRAY BOOLEAN:C223($ab_IncidePromedioOficial;0)
ARRAY LONGINT:C221($al_recnumCalificaciones;0)
ARRAY LONGINT:C221($al_recNumsSintesisAnual;0)
ARRAY REAL:C219($ar_RealNtaF;0)
ARRAY REAL:C219($ar_RealNtaOf;0)
ARRAY REAL:C219($ar_RealNtaP1;0)
ARRAY REAL:C219($ar_RealNtaP2;0)
ARRAY REAL:C219($ar_RealNtaP3;0)
ARRAY REAL:C219($ar_RealNtaP4;0)
ARRAY REAL:C219($ar_RealNtaP5;0)
ARRAY REAL:C219($ar_RealNtaPF;0)
If (False:C215)
	C_BOOLEAN:C305(CU_CalculaPromedios ;$0)
	C_LONGINT:C283(CU_CalculaPromedios ;$1)
End if 



  // CODIGO PRINCIPAL
PERIODOS_Init 
EVS_initialize 

$l_recNumCurso:=$1
READ WRITE:C146([Cursos:3])
GOTO RECORD:C242([Cursos:3];$l_recNumCurso)
$l_NoCurso:=Abs:C99([Cursos:3]Numero_del_curso:6)  //MONO 184433
$l_nivelDelCurso:=[Cursos:3]Nivel_Numero:7
$t_nombreDelCurso:=[Cursos:3]Curso:1
PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
If (Locked:C147([Cursos:3]))
	$0:=False:C215
Else 
	READ ONLY:C145([Alumnos_SintesisAnual:210])
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Curso:7=$t_nombreDelCurso)
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	QUERY SELECTION:C341([Alumnos_SintesisAnual:210]; & [Alumnos:2]Status:50#"Retirado@")
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210];$al_recNumsSintesisAnual)
	ARRAY REAL:C219($ar_Real1;Size of array:C274($al_recNumsSintesisAnual))
	ARRAY REAL:C219($ar_Real2;Size of array:C274($al_recNumsSintesisAnual))
	ARRAY REAL:C219($ar_Real3;Size of array:C274($al_recNumsSintesisAnual))
	ARRAY REAL:C219($ar_Real4;Size of array:C274($al_recNumsSintesisAnual))
	ARRAY REAL:C219($ar_Real5;Size of array:C274($al_recNumsSintesisAnual))
	ARRAY REAL:C219($ar_Real6;Size of array:C274($al_recNumsSintesisAnual))
	ARRAY REAL:C219($ar_Real7;Size of array:C274($al_recNumsSintesisAnual))
	ARRAY REAL:C219($ar_Real8;Size of array:C274($al_recNumsSintesisAnual))
	
	For ($iAlumnos;1;Size of array:C274($al_recNumsSintesisAnual))
		GOTO RECORD:C242([Alumnos_SintesisAnual:210];$al_recNumsSintesisAnual{$iAlumnos})
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6;=;[Alumnos_SintesisAnual:210]ID_Alumno:4;*)
		QUERY:C277([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]ID_institucion:2=<>gInstitucion;*)
		QUERY:C277([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]Año:3=<>gYear;*)
		QUERY:C277([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]NIvel_Numero:4=$l_nivelDelCurso)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];$al_recnumCalificaciones;[Asignaturas:18]IncideEnPromedioInterno:64;$ab_IncidePromedio;[Asignaturas:18]Incide_en_promedio:27;$ab_IncidePromedioOficial;[Alumnos_Calificaciones:208]Anual_Real:11;$ar_RealNtaPF;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;$ar_RealNtaF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;$ar_RealNtaOf;[Alumnos_Calificaciones:208]P01_Final_Real:112;$ar_RealNtaP1;[Alumnos_Calificaciones:208]P02_Final_Real:187;$ar_RealNtaP2;[Alumnos_Calificaciones:208]P03_Final_Real:262;$ar_RealNtaP3;[Alumnos_Calificaciones:208]P04_Final_Real:337;$ar_RealNtaP4;[Alumnos_Calificaciones:208]P05_Final_Real:412;$ar_RealNtaP5)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		
		For ($iNotas;Size of array:C274($al_recnumCalificaciones);1;-1)
			If ($ab_IncidePromedio{$iNotas}=False:C215)
				AT_Delete ($iNotas;1;->$ar_RealNtaP1;->$ar_RealNtaP2;->$ar_RealNtaP3;->$ar_RealNtaP4;->$ar_RealNtaPF;->$ar_RealNtaF)
			End if 
			If ($ab_IncidePromedioOficial{$iNotas}=False:C215)
				AT_Delete ($iNotas;1;->$ar_RealNtaOf)
			End if 
		End for 
		$ar_Real1{$iAlumnos}:=AT_Mean (->$ar_RealNtaP1;1)
		$ar_Real2{$iAlumnos}:=AT_Mean (->$ar_RealNtaP2;1)
		$ar_Real3{$iAlumnos}:=AT_Mean (->$ar_RealNtaP3;1)
		$ar_Real4{$iAlumnos}:=AT_Mean (->$ar_RealNtaP4;1)
		$ar_Real5{$iAlumnos}:=AT_Mean (->$ar_RealNtaP5;1)
		$ar_Real6{$iAlumnos}:=AT_Mean (->$ar_RealNtaPF;1)
		$ar_Real7{$iAlumnos}:=AT_Mean (->$ar_RealNtaF;1)
		$ar_Real8{$iAlumnos}:=AT_Mean (->$ar_RealNtaOF;1)
	End for 
	
	$l_IdEstiloEvaluacionInterno:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelDelCurso;->[xxSTR_Niveles:6]EvStyle_interno:33)
	EVS_ReadStyleData ($l_IdEstiloEvaluacionInterno)
	
	$r_promedioP1:=AT_Mean (->$ar_Real1;1)
	$r_promedioP2:=AT_Mean (->$ar_Real2;1)
	$r_promedioP3:=AT_Mean (->$ar_Real3;1)
	$r_promedioP4:=AT_Mean (->$ar_Real4;1)
	$r_promedioP5:=AT_Mean (->$ar_Real5;1)
	$r_promedioPF:=AT_Mean (->$ar_Real6;1)
	$r_promedioNF:=AT_Mean (->$ar_Real7;1)
	$r_promedioNO:=AT_Mean (->$ar_Real8;1)
	
	$t_llaveRegistroSintesisCurso:=KRL_MakeStringAccesKey (-><>gInstitucion;-><>gYear;->$l_nivelDelCurso;->$t_nombreDelCurso;->$l_NoCurso)  //MONO 184433
	$l_recNumCurso:=KRL_FindAndLoadRecordByIndex (->[Cursos_SintesisAnual:63]LLavePrimaria:6;->$t_llaveRegistroSintesisCurso;True:C214)
	If ($l_recNumCurso<0)
		CREATE RECORD:C68([Cursos_SintesisAnual:63])
		[Cursos_SintesisAnual:63]ID_Institucion:1:=<>gInstitucion
		[Cursos_SintesisAnual:63]NumeroNivel:3:=[Cursos:3]Nivel_Numero:7
		[Cursos_SintesisAnual:63]Año:2:=<>gYear
		[Cursos_SintesisAnual:63]ID_Curso:52:=[Cursos:3]Numero_del_curso:6
		[Cursos_SintesisAnual:63]Curso:5:=[Cursos:3]Curso:1
		[Cursos_SintesisAnual:63]NombreOficialCurso:7:=[Cursos:3]Nombre_Oficial_Curso:15
		[Cursos_SintesisAnual:63]cl_CodigoEspecialidadTP:54:=[Cursos:3]cl_CodigoEspecialidadTP:29
		[Cursos_SintesisAnual:63]cl_EspecialidadTP:55:=[Cursos:3]cl_EspecialidadTP:28
		[Cursos_SintesisAnual:63]cl_SectorEconomicoTP:56:=[Cursos:3]cl_SectorEconomicoTP:27
		SAVE RECORD:C53([Cursos_SintesisAnual:63])
	End if 
	If ($r_promedioP1>=vrNTA_MinimoEscalaReferencia)
		EVS_ReadStyleData ($l_IdEstiloEvaluacionInterno)
		[Cursos_SintesisAnual:63]P01_Promedio_Real:27:=$r_promedioP1
		[Cursos_SintesisAnual:63]P01_Promedio_Nota:28:=EV2_Real_a_Nota ($r_promedioP1;0;iGradesDecPP)
		[Cursos_SintesisAnual:63]P01_Promedio_Puntos:29:=EV2_Real_a_Puntos ($r_promedioP1;0;iPointsDecPP)
		[Cursos_SintesisAnual:63]P01_Promedio_Simbolo:30:=EV2_Real_a_Simbolo ($r_promedioP1)
		[Cursos_SintesisAnual:63]P01_Promedio_Literal:31:=EV2_Real_a_Literal ($r_promedioP1;iEvaluationMode;vlNTA_DecimalesParciales)
	Else 
		[Cursos_SintesisAnual:63]P01_Promedio_Real:27:=-10
		[Cursos_SintesisAnual:63]P01_Promedio_Nota:28:=-10
		[Cursos_SintesisAnual:63]P01_Promedio_Puntos:29:=-10
		[Cursos_SintesisAnual:63]P01_Promedio_Simbolo:30:=""
		[Cursos_SintesisAnual:63]P01_Promedio_Literal:31:=""
	End if 
	
	If ($r_promedioP2>=vrNTA_MinimoEscalaReferencia)
		[Cursos_SintesisAnual:63]P02_Promedio_Real:32:=$r_promedioP2
		[Cursos_SintesisAnual:63]P02_Promedio_Nota:33:=EV2_Real_a_Nota ($r_promedioP2;0;iGradesDecPP)
		[Cursos_SintesisAnual:63]P02_Promedio_Puntos:34:=EV2_Real_a_Puntos ($r_promedioP2;0;iPointsDecPP)
		[Cursos_SintesisAnual:63]P02_Promedio_Simbolo:35:=EV2_Real_a_Simbolo ($r_promedioP2)
		[Cursos_SintesisAnual:63]P02_Promedio_Literal:36:=EV2_Real_a_Literal ($r_promedioP2;iEvaluationMode;vlNTA_DecimalesParciales)
	Else 
		[Cursos_SintesisAnual:63]P02_Promedio_Real:32:=-10
		[Cursos_SintesisAnual:63]P02_Promedio_Nota:33:=-10
		[Cursos_SintesisAnual:63]P02_Promedio_Puntos:34:=-10
		[Cursos_SintesisAnual:63]P02_Promedio_Simbolo:35:=""
		[Cursos_SintesisAnual:63]P02_Promedio_Literal:36:=""
	End if 
	
	If ($r_promedioP3>=vrNTA_MinimoEscalaReferencia)
		EVS_ReadStyleData ($l_IdEstiloEvaluacionInterno)
		[Cursos_SintesisAnual:63]P03_Promedio_Real:37:=$r_promedioP3
		[Cursos_SintesisAnual:63]P03_Promedio_Nota:38:=EV2_Real_a_Nota ($r_promedioP3;0;iGradesDecPP)
		[Cursos_SintesisAnual:63]P03_Promedio_Puntos:39:=EV2_Real_a_Puntos ($r_promedioP3;0;iPointsDecPP)
		[Cursos_SintesisAnual:63]P03_Promedio_Simbolo:40:=EV2_Real_a_Simbolo ($r_promedioP3)
		[Cursos_SintesisAnual:63]P03_Promedio_Literal:41:=EV2_Real_a_Literal ($r_promedioP3;iEvaluationMode;vlNTA_DecimalesParciales)
	Else 
		[Cursos_SintesisAnual:63]P03_Promedio_Real:37:=-10
		[Cursos_SintesisAnual:63]P03_Promedio_Nota:38:=-10
		[Cursos_SintesisAnual:63]P03_Promedio_Puntos:39:=-10
		[Cursos_SintesisAnual:63]P03_Promedio_Simbolo:40:=""
		[Cursos_SintesisAnual:63]P03_Promedio_Literal:41:=""
	End if 
	
	If ($r_promedioP4>=vrNTA_MinimoEscalaReferencia)
		EVS_ReadStyleData ($l_IdEstiloEvaluacionInterno)
		[Cursos_SintesisAnual:63]P04_Promedio_Real:42:=$r_promedioP4
		[Cursos_SintesisAnual:63]P04_Promedio_Nota:43:=EV2_Real_a_Nota ($r_promedioP4;0;iGradesDecPP)
		[Cursos_SintesisAnual:63]P04_Promedio_Puntos:44:=EV2_Real_a_Puntos ($r_promedioP4;0;iPointsDecPP)
		[Cursos_SintesisAnual:63]P04_Promedio_Simbolo:45:=EV2_Real_a_Simbolo ($r_promedioP4)
		[Cursos_SintesisAnual:63]P04_Promedio_Literal:46:=EV2_Real_a_Literal ($r_promedioP4;iEvaluationMode;vlNTA_DecimalesParciales)
	Else 
		[Cursos_SintesisAnual:63]P04_Promedio_Real:42:=-10
		[Cursos_SintesisAnual:63]P04_Promedio_Nota:43:=-10
		[Cursos_SintesisAnual:63]P04_Promedio_Puntos:44:=-10
		[Cursos_SintesisAnual:63]P04_Promedio_Simbolo:45:=""
		[Cursos_SintesisAnual:63]P04_Promedio_Literal:46:=""
	End if 
	
	If ($r_promedioP5>=vrNTA_MinimoEscalaReferencia)
		EVS_ReadStyleData ($l_IdEstiloEvaluacionInterno)
		[Cursos_SintesisAnual:63]P05_Promedio_Real:47:=$r_promedioP5
		[Cursos_SintesisAnual:63]P05_Promedio_Nota:48:=EV2_Real_a_Nota ($r_promedioP5;0;iGradesDecPP)
		[Cursos_SintesisAnual:63]P05_Promedio_Puntos:49:=EV2_Real_a_Puntos ($r_promedioP5;0;iPointsDecPP)
		[Cursos_SintesisAnual:63]P05_Promedio_Simbolo:50:=EV2_Real_a_Simbolo ($r_promedioP5)
		[Cursos_SintesisAnual:63]P05_Promedio_Literal:51:=EV2_Real_a_Literal ($r_promedioP5;iEvaluationMode;vlNTA_DecimalesParciales)
	Else 
		[Cursos_SintesisAnual:63]P05_Promedio_Real:47:=-10
		[Cursos_SintesisAnual:63]P05_Promedio_Nota:48:=-10
		[Cursos_SintesisAnual:63]P05_Promedio_Puntos:49:=-10
		[Cursos_SintesisAnual:63]P05_Promedio_Simbolo:50:=""
		[Cursos_SintesisAnual:63]P05_Promedio_Literal:51:=""
	End if 
	
	If ($r_promedioPF>=vrNTA_MinimoEscalaReferencia)
		EVS_ReadStyleData ($l_IdEstiloEvaluacionInterno)
		[Cursos_SintesisAnual:63]PromedioAnual_Real:12:=$r_promedioPF
		[Cursos_SintesisAnual:63]PromedioAnual_Nota:13:=EV2_Real_a_Nota ($r_promedioPF;0;iGradesDecPF)
		[Cursos_SintesisAnual:63]PromedioAnual_Puntos:14:=EV2_Real_a_Puntos ($r_promedioPF;0;iPointsDecPF)
		[Cursos_SintesisAnual:63]PromedioAnual_Simbolo:15:=EV2_Real_a_Simbolo ($r_promedioPF)
		[Cursos_SintesisAnual:63]PromedioAnual_Literal:16:=EV2_Real_a_Literal ($r_promedioPF;iEvaluationMode;vlNTA_DecimalesPF)
	Else 
		[Cursos_SintesisAnual:63]PromedioAnual_Real:12:=-10
		[Cursos_SintesisAnual:63]PromedioAnual_Nota:13:=-10
		[Cursos_SintesisAnual:63]PromedioAnual_Puntos:14:=-10
		[Cursos_SintesisAnual:63]PromedioAnual_Simbolo:15:=""
		[Cursos_SintesisAnual:63]PromedioAnual_Literal:16:=""
	End if 
	
	If ($r_promedioNF>=vrNTA_MinimoEscalaReferencia)
		EVS_ReadStyleData ($l_IdEstiloEvaluacionInterno)
		[Cursos_SintesisAnual:63]PromedioFinal_Real:17:=$r_promedioNF
		[Cursos_SintesisAnual:63]PromedioFinal_Nota:18:=EV2_Real_a_Nota ($r_promedioNF;0;iGradesDecNF)
		[Cursos_SintesisAnual:63]PromedioFinal_Puntos:19:=EV2_Real_a_Puntos ($r_promedioNF;0;iPointsDecNF)
		[Cursos_SintesisAnual:63]PromedioFinal_Simbolo:20:=EV2_Real_a_Simbolo ($r_promedioNF)
		[Cursos_SintesisAnual:63]PromedioFinal_Literal:21:=EV2_Real_a_Literal ($r_promedioNF;iEvaluationMode;vlNTA_DecimalesNF)
	Else 
		[Cursos_SintesisAnual:63]PromedioFinal_Real:17:=-10
		[Cursos_SintesisAnual:63]PromedioFinal_Nota:18:=-10
		[Cursos_SintesisAnual:63]PromedioFinal_Puntos:19:=-10
		[Cursos_SintesisAnual:63]PromedioFinal_Simbolo:20:=""
		[Cursos_SintesisAnual:63]PromedioFinal_Literal:21:=""
	End if 
	
	If ($r_promedioNO>=vrNTA_MinimoEscalaReferencia)
		$l_IdEstiloEvaluacionOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]EvStyle_oficial:23)
		EVS_ReadStyleData ($l_IdEstiloEvaluacionOficial)
		[Cursos_SintesisAnual:63]PromedioOficial_Real:22:=$r_promedioNO
		[Cursos_SintesisAnual:63]PromedioOficial_Nota:23:=EV2_Real_a_Nota ($r_promedioNO;0;iGradesDecNO)
		[Cursos_SintesisAnual:63]PromedioOficial_Puntos:24:=EV2_Real_a_Puntos ($r_promedioNO;0;iPointsDecNO)
		[Cursos_SintesisAnual:63]PromedioOficial_Simbolo:25:=EV2_Real_a_Simbolo ($r_promedioNO)
		[Cursos_SintesisAnual:63]PromedioOficial_Literal:26:=EV2_Real_a_Literal ($r_promedioNO;iEvaluationMode;vlNTA_DecimalesNO)
	Else 
		[Cursos_SintesisAnual:63]PromedioOficial_Real:22:=-10
		[Cursos_SintesisAnual:63]PromedioOficial_Nota:23:=-10
		[Cursos_SintesisAnual:63]PromedioOficial_Puntos:24:=-10
		[Cursos_SintesisAnual:63]PromedioOficial_Simbolo:25:=""
		[Cursos_SintesisAnual:63]PromedioOficial_Literal:26:=""
	End if 
	
	SAVE RECORD:C53([Cursos_SintesisAnual:63])
	UNLOAD RECORD:C212([Cursos_SintesisAnual:63])
	READ ONLY:C145([Cursos_SintesisAnual:63])
	
	$0:=True:C214
End if 

