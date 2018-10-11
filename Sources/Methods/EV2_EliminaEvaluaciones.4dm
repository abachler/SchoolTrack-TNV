//%attributes = {}
  // MÉTODO: EV2_EliminaEvaluaciones
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/12/11, 17:22:27
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // EV2_EliminaEvaluaciones()
  // ----------------------------------------------------
C_LONGINT:C283($1)
C_POINTER:C301($2)

C_LONGINT:C283($i;$l_idAsignatura;$l_recNumAlumno;$l_recNumAsignatura)
C_TEXT:C284($t_nombreAsignatura)

ARRAY LONGINT:C221($al_IdAlumnos;0)
ARRAY LONGINT:C221($al_IdAsignaturasHijas;0)
If (False:C215)
	C_LONGINT:C283(EV2_EliminaEvaluaciones ;$1)
	C_POINTER:C301(EV2_EliminaEvaluaciones ;$2)
End if 





  // CODIGO PRINCIPAL
$l_idAsignatura:=$1
COPY ARRAY:C226($2->;$al_IdAlumnos)

KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_idAsignatura)
$t_nombreAsignatura:=[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5
$l_recNumAsignatura:=Record number:C243([Asignaturas:18])

  //busco las asignaturas hijas de la asignatura de origen ocultas en explorador
QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1=$l_idAsignatura)
SELECTION TO ARRAY:C260([Asignaturas_Consolidantes:231]ID_ParentRecord:5;$al_IdAsignaturasHijas)
SORT ARRAY:C229($al_IdAsignaturasHijas;>)
For ($i;1;Size of array:C274($al_IdAsignaturasHijas))
	OK:=EV2_EliminaEvaluaciones ($al_IdAsignaturasHijas{$i};->$al_IdAlumnos)
End for 

QRY_QueryWithArray (->[Alumnos_Calificaciones:208]ID_Alumno:6;->$al_IdAlumnos)
QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$l_idAsignatura;*)
QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]Año:3=<>gYear)
KRL_UnloadReadOnly (->[Alumnos_ComplementoEvaluacion:209])  //me aseguro que si hay un registro de [Alumnos_ComplementoEvaluacion] no quede tomado para que pueda se eliminado en el trigger de [Alumnos_Calificaciones]
ok:=KRL_DeleteSelection (->[Alumnos_Calificaciones:208])

  //retiro alumnos de subasignaturas
If (OK=1)
	ASsev_RetiraAlumno ($l_recNumAsignatura;->$al_IdAlumnos)
	OK:=1
End if 

If (OK=1)  // eliminando registros de evaluacion por aprendizajes existentes
	READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
	QRY_QueryWithArray (->[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;->$al_IdAlumnos)
	QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$l_idAsignatura)
	OK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
End if 

  //registro retiros en el log
If (OK=1)
	READ ONLY:C145([Alumnos:2])
	For ($i;1;Size of array:C274($al_IdAlumnos))
		$l_recNumAlumno:=Find in field:C653([Alumnos:2]numero:1;$al_IdAlumnos{$i})
		If ($l_recNumAlumno>=0)
			GOTO RECORD:C242([Alumnos:2];$l_recNumAlumno)
			LOG_RegisterEvt ([Alumnos:2]apellidos_y_nombres:40+" ("+[Alumnos:2]curso:20+") retirado de "+$t_nombreAsignatura)
		End if 
	End for 
	OK:=1
End if 

KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_idAsignatura;True:C214)
EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
ORDER BY:C49([Alumnos_Calificaciones:208]NoDeLista:10;>)
LAST RECORD:C200([Alumnos_Calificaciones:208])
[Asignaturas:18]Numero_de_alumnos:49:=Records in selection:C76([Alumnos_Calificaciones:208])
[Asignaturas:18]LastNumber:54:=[Alumnos_Calificaciones:208]NoDeLista:10
SAVE RECORD:C53([Asignaturas:18])


$0:=OK