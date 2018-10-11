//%attributes = {}
  //DIAG_VerificaAsignaturasAlumnos

READ ONLY:C145([Alumnos:2])
QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;<>al_NumeroNivelesActivos)
SELECTION TO ARRAY:C260([Alumnos:2];$aRecNum)


$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando inscripciones de alumnos en asignaturas..."))
For ($i;1;Size of array:C274($aRecNum))
	GOTO RECORD:C242([Alumnos:2];$aRecNum{$i})
	QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=[Alumnos:2]numero:1;*)
	QUERY:C277([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]Año:3=<>gYear)
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas:18]Asignatura:3;>;[Asignaturas:18]Numero_del_Nivel:6;>)
	SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];$aDummy;[Asignaturas:18]Asignatura:3;$aSubjectName;[Asignaturas:18]Incluida_en_Actas:44;$aEnActas;[Asignaturas:18]Curso:5;$aCurso;[Asignaturas:18]Numero_del_Nivel:6;$aNoNivel)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	
	For ($j;1;Size of array:C274($aSubjectName)-1)
		If (($aSubjectName{$j}=$aSubjectName{$j+1}) & ($aEnActas{$j}) & ($aEnActas{$j+1}) & ($aNoNivel{$j}=$aNoNivel{$j+1}))
			If (Find in array:C230(aDiagnosticErrors;20)=-1)
				INSERT IN ARRAY:C227(aDiagnosticErrors;Size of array:C274(aDiagnosticErrors)+1;1)
				aDiagnosticErrors{Size of array:C274(aDiagnosticErrors)}:=20
			End if 
			$text:=[Alumnos:2]apellidos_y_nombres:40+" inscrito en dos o más asignaturas con el mismo nombre"+" ("+$aSubjectName{$j}+", "+$aCurso{$j}+")"+" [20]"+"\r"
			IO_SendPacket (vhDIAG_docRef;$text)
		End if 
	End for 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNum);__ ("Verificando inscripciones de alumnos en asignaturas..."))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
