//%attributes = {}
  // MÉTODO: EV2_CreaRegistrosEvaluacion
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/12/11, 17:12:47
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // EV2_CreaRegistrosEvaluacion()
  // ----------------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($b_crearCalificaciones;$b_opcEvaEsp)
C_LONGINT:C283($i;$l_idAlumno;$l_idAsignatura;$l_recNumCalificaciones;$l_sexo;$l_recNumEvalEspecial)
C_TEXT:C284($t_llaveRegistroCalificaciones)

ARRAY LONGINT:C221($al_IDAsignaturasHijas;0)
If (False:C215)
	C_LONGINT:C283(EV2_CreaRegistrosEvaluacion ;$1)
	C_LONGINT:C283(EV2_CreaRegistrosEvaluacion ;$2)
End if 





  // CODIGO PRINCIPAL
$l_idAsignatura:=$1
$l_idAlumno:=$2

  //busco las asignaturas hijas de la asignatura de origen ocultas en explorador
QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;=;$l_idAsignatura)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Asignaturas_Consolidantes:231]ID_ParentRecord:5;$al_IDAsignaturasHijas)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

If (Size of array:C274($al_IDAsignaturasHijas)>0)
	SORT ARRAY:C229($al_IDAsignaturasHijas;>)
	For ($i;1;Size of array:C274($al_IDAsignaturasHijas))
		EV2_CreaRegistrosEvaluacion ($al_IDAsignaturasHijas{$i};$l_idAlumno)
	End for 
End if 

  //que siempre lea nuevamente la asignatura por la cual fue llamada originalmente
  //ya que por ejemplo cuando la asignatura tiene hijas, queda cargada la info de la ultima hija cuando se vuelve al llamado original
KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_idAsignatura)
KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$l_idAlumno)
Case of 
	: ([Alumnos:2]Sexo:49="")
		$l_sexo:=1
	: ([Alumnos:2]Sexo:49="F")
		$l_sexo:=2
	: ([Alumnos:2]Sexo:49="M")
		$l_sexo:=3
End case 


  // ASM 20150122 ticket 141071  (evitar que alumnos de cursos distintos a los cursos de las asignaturas se puedan inscribir)
$b_crearCalificaciones:=True:C214
$t_cursoAlumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_idAlumno;->[Alumnos:2]curso:20)
If (Not:C34([Asignaturas:18]Seleccion:17))
	If ([Asignaturas:18]Curso:5#$t_cursoAlumno)
		$b_crearCalificaciones:=False:C215
	End if 
End if 

If (($l_sexo=[Asignaturas:18]Seleccion_por_sexo:24) | ([Asignaturas:18]Seleccion_por_sexo:24=1))
	$t_llaveRegistroCalificaciones:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Asignaturas:18]Numero_del_Nivel:6)+"."+String:C10($l_idAsignatura)+"."+String:C10($l_idAlumno)
	$l_recNumCalificaciones:=KRL_FindAndLoadRecordByIndex (->[Alumnos_Calificaciones:208]Llave_principal:1;->$t_llaveRegistroCalificaciones)
	
	If ($l_recNumCalificaciones<0) & ($b_crearCalificaciones)
		CREATE RECORD:C68([Alumnos_Calificaciones:208])
		[Alumnos_Calificaciones:208]ID_institucion:2:=<>gInstitucion
		[Alumnos_Calificaciones:208]Año:3:=<>gYear
		[Alumnos_Calificaciones:208]ID_Alumno:6:=$l_idAlumno
		[Alumnos_Calificaciones:208]ID_Asignatura:5:=$l_idAsignatura
		[Alumnos_Calificaciones:208]NombreOficialAsignatura:7:=[Asignaturas:18]Asignatura:3
		[Alumnos_Calificaciones:208]NombreInternoAsignatura:8:=[Asignaturas:18]denominacion_interna:16
		[Alumnos_Calificaciones:208]NIvel_Numero:4:=[Asignaturas:18]Numero_del_Nivel:6
		SAVE RECORD:C53([Alumnos_Calificaciones:208])
		  //UNLOAD RECORD([Alumnos_Calificaciones])//20170520 RCH Si se tenían que crear evaluaciones especiales, había problema
	End if 
	
	  //Mono Ticket 172577 Evaluacion Especial
	OB_GET ([Asignaturas:18]Opciones:57;->$b_opcEvaEsp;"usaEvaluacionesEspeciales")
	$l_recNumEvalEspecial:=KRL_FindAndLoadRecordByIndex (->[Alumnos_EvaluacionesEspeciales:211]Llave_principal:8;->[Alumnos_Calificaciones:208]Llave_principal:1)
	If (($l_recNumEvalEspecial<0) & ($b_crearCalificaciones) & ($b_opcEvaEsp))
		CREATE RECORD:C68([Alumnos_EvaluacionesEspeciales:211])
		[Alumnos_EvaluacionesEspeciales:211]ID_Institucion:2:=[Alumnos_Calificaciones:208]ID_institucion:2
		[Alumnos_EvaluacionesEspeciales:211]Año:3:=[Alumnos_Calificaciones:208]Año:3
		[Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4:=[Alumnos_Calificaciones:208]ID_Alumno:6
		[Alumnos_EvaluacionesEspeciales:211]ID_Asignatura:5:=[Alumnos_Calificaciones:208]ID_Asignatura:5
		[Alumnos_EvaluacionesEspeciales:211]ID_HistoricoAsignatura:6:=[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493
		[Alumnos_EvaluacionesEspeciales:211]Nivel_Numero:7:=[Alumnos_Calificaciones:208]NIvel_Numero:4
		SAVE RECORD:C53([Alumnos_EvaluacionesEspeciales:211])
		KRL_ReloadAsReadOnly (->[Alumnos_EvaluacionesEspeciales:211])
	End if 
	
	
	UNLOAD RECORD:C212([Alumnos_Calificaciones:208])
	READ ONLY:C145([Alumnos_Calificaciones:208])
	UNLOAD RECORD:C212([Alumnos_ComplementoEvaluacion:209])
	READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])
End if 