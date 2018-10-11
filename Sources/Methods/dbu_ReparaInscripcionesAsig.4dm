//%attributes = {}
  // dbu_ReparaInscripcionesAsig()
  // Por: Alberto Bachler: 22/03/13, 09:30:12
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_IdAsignatura;$l_numeroNivel)
C_TEXT:C284($t_mensaje)

ARRAY LONGINT:C221($al_recNumAlumnos;0)
ARRAY LONGINT:C221($al_RecNumAsignaturas;0)

MESSAGES OFF:C175
PERIODOS_Init 
EVS_LoadStyles 
READ WRITE:C146([Asignaturas:18])
QUERY:C277([Asignaturas:18];[Asignaturas:18]Seleccion:17=False:C215;*)
QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Electiva:11=False:C215)
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_RecNumAsignaturas;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Incribiendo alumnos en asignaturas..."))
For ($i;1;Size of array:C274($al_RecNumAsignaturas))
	GOTO RECORD:C242([Asignaturas:18];$al_RecNumAsignaturas{$i})
	$l_IdAsignatura:=[Asignaturas:18]Numero:1
	QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Asignaturas:18]Curso:5)
	$t_mensaje:="Inscribiendo a todos los alumnos de "+[Asignaturas:18]Curso:5+" en "+[Asignaturas:18]denominacion_interna:16
	Case of 
		: ([Asignaturas:18]Seleccion_por_sexo:24=2)
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="F")
			$t_mensaje:="Inscribiendo a todas las alumnas de "+[Asignaturas:18]Curso:5+" en "+[Asignaturas:18]denominacion_interna:16
		: ([Asignaturas:18]Seleccion_por_sexo:24=3)
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="M")
			$t_mensaje:="Inscribiendo a todos los alumnos varones de "+[Asignaturas:18]Curso:5+" en "+[Asignaturas:18]denominacion_interna:16
	End case 
	QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Asignaturas:18]Curso:5)
	ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$al_recNumAlumnos;"")
	For ($i_alumnos;1;Size of array:C274($al_recNumAlumnos))
		GOTO RECORD:C242([Alumnos:2];$al_recNumAlumnos{$i_alumnos})
		AS_CreaRegistrosEvaluacion ([Alumnos:2]numero:1;$l_IdAsignatura)
	End for 
	
	  //InscriptOK:=True
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_RecNumAsignaturas);__ ("Incribiendo alumnos en ")+[Asignaturas:18]denominacion_interna:16+__ (", ")+[Asignaturas:18]Curso:5+__ ("..."))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

QRY_QueryWithArray (->[Alumnos:2]Nivel_Nombre:34;-><>at_NombreNivelesActivos)

LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$al_recNumAlumnos;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Regularizando inscripciones en asignaturas..."))
For ($i;1;Size of array:C274($al_recNumAlumnos))
	GOTO RECORD:C242([Alumnos:2];$al_recNumAlumnos{$i})
	EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29;<>gYear)
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	$l_numeroNivel:=[Alumnos:2]nivel_numero:29
	QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Numero_del_Nivel:6#$l_numeroNivel)
	KRL_RelateSelection (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1)
	GOTO RECORD:C242([Alumnos:2];$al_recNumAlumnos{$i})
	If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
		KRL_DeleteSelection (->[Alumnos_ComplementoEvaluacion:209])
		KRL_DeleteSelection (->[Alumnos_Calificaciones:208])
	End if 
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recNumAlumnos))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

dbu_CountSubjectStudents 

