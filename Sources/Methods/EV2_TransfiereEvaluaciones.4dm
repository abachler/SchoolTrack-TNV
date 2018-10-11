//%attributes = {}
  // EV2_TransfiereEvaluaciones()
  //
  //
  // creado por: Alberto Bachler Klein: 30-11-16, 11:31:00
  // -----------------------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_POINTER:C301($3)

C_LONGINT:C283($i;$i_hijas;$l_hijasIdenticas;$l_id;$l_idAsignaturaDestino;$l_idAsignaturaOrigen;$l_IdMatrizAprendizaje_DESTINO;$l_IdMatrizAprendizaje_ORIGEN;$l_recNumAlumno;$l_recNumAsignaturaOrigen)
C_TEXT:C284($t_nombreInterAsignaturaDestino;$t_nombreInterAsignaturaOrigen;$t_nombreOfAsignaturaDestino)

ARRAY LONGINT:C221($al_IdAlumnos;0)
ARRAY LONGINT:C221($al_IDAsignaturasHijas_Destino;0)
ARRAY LONGINT:C221($al_IdAsignaturasHijas_Origen;0)
ARRAY TEXT:C222($at_NombreAsigHijas_Destino;0)
ARRAY TEXT:C222($at_NombreAsigHijas_Origen;0)


If (False:C215)
	C_LONGINT:C283(EV2_TransfiereEvaluaciones ;$1)
	C_LONGINT:C283(EV2_TransfiereEvaluaciones ;$2)
	C_POINTER:C301(EV2_TransfiereEvaluaciones ;$3)
End if 

  // CODIGO PRINCIPAL
$l_idAsignaturaOrigen:=$1
$l_idAsignaturaDestino:=$2
COPY ARRAY:C226($3->;$al_IdAlumnos)


  //cargo el registro de la asignatura de ORIGEN y almaceno el valor de algunos campos en variables (el registro corriente cambiará al buscar las asignaturas hijas)
KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_idAsignaturaOrigen)
$l_recNumAsignaturaOrigen:=Record number:C243([Asignaturas:18])
$l_IdMatrizAprendizaje_ORIGEN:=[Asignaturas:18]EVAPR_IdMatriz:91
$t_nombreInterAsignaturaOrigen:=[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5

If ([Asignaturas:18]Asignatura:3="ingles")
	
	
End if 

PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)

QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1=$l_idAsignaturaOrigen)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Asignaturas_Consolidantes:231]ID_ParentRecord:5;$al_IdAsignaturasHijas_Origen;[Asignaturas:18]Asignatura:3;$at_NombreAsigHijas_Origen)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
AT_DistinctsArrayValues (->$al_IdAsignaturasHijas_Origen)
AT_ResizeArrays (->$at_NombreAsigHijas_Origen;Size of array:C274($al_IdAsignaturasHijas_Origen))
For ($i_hijas;1;Size of array:C274($al_IdAsignaturasHijas_Origen))
	$l_id:=$al_IdAsignaturasHijas_Origen{$i_hijas}
	$at_NombreAsigHijas_Origen{$i_hijas}:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_id;->[Asignaturas:18]Asignatura:3)
End for 
SORT ARRAY:C229($at_NombreAsigHijas_Origen;$al_IdAsignaturasHijas_Origen;>)

  //cargo el registro de la asignatura de DESTINO y almaceno el valor de algunos campos en variables (el registro corriente cambiará al buscar las asignaturas hijas)
KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_idAsignaturaDestino)
$l_IdMatrizAprendizaje_DESTINO:=[Asignaturas:18]EVAPR_IdMatriz:91
$t_nombreInterAsignaturaDestino:=[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5
$t_nombreOfAsignaturaDestino:=[Asignaturas:18]Asignatura:3

QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1=$l_idAsignaturaDestino)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Asignaturas_Consolidantes:231]ID_ParentRecord:5;$al_IDAsignaturasHijas_Destino;[Asignaturas:18]Asignatura:3;$at_NombreAsigHijas_Destino)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
AT_DistinctsArrayValues (->$al_IDAsignaturasHijas_Destino)
AT_ResizeArrays (->$at_NombreAsigHijas_Destino;Size of array:C274($al_IDAsignaturasHijas_Destino))
For ($i_hijas;1;Size of array:C274($al_IDAsignaturasHijas_Destino))
	$l_id:=$al_IDAsignaturasHijas_Destino{$i_hijas}
	$at_NombreAsigHijas_Destino{$i_hijas}:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_id;->[Asignaturas:18]Asignatura:3)
End for 
SORT ARRAY:C229($at_NombreAsigHijas_Destino;$al_IDAsignaturasHijas_Destino;>)

  //verifico que las asignaturas de origen y destino tengan la misma configuración de asignaturas hijas
$l_hijasIdenticas:=AT_IsEqual (->$at_NombreAsigHijas_Origen;->$at_NombreAsigHijas_Destino)

Case of 
	: ((Size of array:C274($at_NombreAsigHijas_Origen)=0) & (Size of array:C274($at_NombreAsigHijas_Destino)=0))
		  //continuamos, no hay asignturas hijas
	: ($l_hijasIdenticas=1)  //hay asignaturas hijas y la configuración es la misma
		For ($i;1;Size of array:C274($al_IdAsignaturasHijas_Origen))
			OK:=EV2_TransfiereEvaluaciones ($al_IdAsignaturasHijas_Origen{$i};$al_IDAsignaturasHijas_Destino{$i};->$al_IdAlumnos)
		End for 
	Else   //la configuración es distinta
		  //no se transfieren las evaluaciones de aprendizaje ya que las matrices asignadas a las asignaturas de destino y origen son diferentes
		CD_Dlog (0;__ ("La configuración de asignaturas consolidables es distinta en la asignatura de origen y la asignatura de destino.\rLa transferencia de evaluaciones no es posible."))
		OK:=-1
End case 
  //End for


  //TRANSFERENCIA DE EVALUACION DE APRENDIZAJES
If (OK=1)
	READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
	QRY_QueryWithArray (->[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;->$al_IdAlumnos)
	QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$l_idAsignaturaOrigen)
	If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
		If ($l_IdMatrizAprendizaje_ORIGEN#0)  //si existe una matriz de aprendizaje en la asignatura de origenpuede haber evaluaciones registradas
			Case of 
				: ($l_IdMatrizAprendizaje_DESTINO=0)  //la asignatura de destino no tiene matriz de aprendizaje asignada
					OK:=CD_Dlog (0;__ ("En la asignatura de origen hay registros de evaluación de aprendizajes pero la asignatura de destino no tiene asignada ninguna matriz de evaluación.\r\rLos alumnos pueden ser transferidos pero SIN las evaluaciones de aprendizajes .\r\r¿Desea continuar"+" la transferencia?");__ ("");__ ("No");__ ("Si"))
					If (OK=2)
						READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
						QRY_QueryWithArray (->[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;->$al_IdAlumnos)
						QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$l_idAsignaturaOrigen)
						ok:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
					Else 
						OK:=0
					End if 
					
				: ($l_IdMatrizAprendizaje_DESTINO#$l_IdMatrizAprendizaje_ORIGEN)  //las matrices de origen y destino no son las mismas, las evaluaciones de aprendizajes no pueden ser transferidas
					OK:=CD_Dlog (0;__ ("Las matrices de evaluación de aprendizajes de la asignatura de origen y destino son diferentes.\r\rLos alumnos pueden ser transferidos pero SIN las evaluaciones de aprendizajes .\r\r¿Desea continuar con la transferencia?");__ ("");__ ("No");__ ("Si"))
					If (OK=2)
						READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
						QRY_QueryWithArray (->[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;->$al_IdAlumnos)
						QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$l_idAsignaturaOrigen)
						ok:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
					Else 
						OK:=0
					End if 
					
				: ($l_IdMatrizAprendizaje_DESTINO=$l_IdMatrizAprendizaje_ORIGEN)  //las matrices de origen y destino son las mismas, las evaluaciones de aprendizajes pueden ser transferidas
					ARRAY LONGINT:C221($aIdDestino;Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]))
					AT_Populate (->$aIdDestino;->$l_idAsignaturaDestino)
					ok:=KRL_Array2Selection (->$aIdDestino;->[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)
			End case 
		End if 
	End if 
End if 

  //TRANFERENCIA DE REGISTROS DE EVALUACION A LA ASIGNATURA DE DESTINO (por cambio de id de asignatura)
If (ok=1)  // eliminando registros de notas de los alumnos seleccionados que ya pudieran existir en la asignatura de destino
	QRY_QueryWithArray (->[Alumnos_Calificaciones:208]ID_Alumno:6;->$al_IdAlumnos)
	QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$l_idAsignaturaDestino;*)
	QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]Año:3=<>gYear)
	ok:=KRL_DeleteSelection (->[Alumnos_Calificaciones:208])
End if 

If (ok=1)
	QRY_QueryWithArray (->[Alumnos_Calificaciones:208]ID_Alumno:6;->$al_IdAlumnos)
	QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$l_idAsignaturaOrigen;*)
	QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]Año:3=<>gYear)
	If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
		ARRAY LONGINT:C221($al_IdAsignatura;Records in selection:C76([Alumnos_Calificaciones:208]))
		ARRAY TEXT:C222($at_NombreAsignaturaDestino;Records in selection:C76([Alumnos_Calificaciones:208]))
		AT_Populate (->$al_IdAsignatura;->$l_idAsignaturaDestino)
		AT_Populate (->$at_NombreAsignaturaDestino;->$t_nombreOfAsignaturaDestino)
		OK:=KRL_Array2Selection (->$al_IdAsignatura;->[Alumnos_Calificaciones:208]ID_Asignatura:5;->$at_NombreAsignaturaDestino;->[Alumnos_Calificaciones:208]NombreInternoAsignatura:8)
		
		QRY_QueryWithArray (->[Alumnos_Calificaciones:208]ID_Alumno:6;->$al_IdAlumnos)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$l_idAsignaturaDestino;*)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]Año:3=<>gYear)
		
	End if 
	QRY_QueryWithArray (->[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6;->$al_IdAlumnos)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5=$l_idAsignaturaOrigen;*)
	QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; & [Alumnos_ComplementoEvaluacion:209]Año:3=<>gYear)
	If (Records in selection:C76([Alumnos_ComplementoEvaluacion:209])>0)
		ARRAY LONGINT:C221($al_IdAsignatura;Records in selection:C76([Alumnos_ComplementoEvaluacion:209]))
		ARRAY TEXT:C222($at_NombreAsignaturaDestino;Records in selection:C76([Alumnos_ComplementoEvaluacion:209]))
		AT_Populate (->$al_IdAsignatura;->$l_idAsignaturaDestino)
		OK:=KRL_Array2Selection (->$al_IdAsignatura;->[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5)
	End if 
End if 

  //REGISTRO EN EL LOG
If (OK=1)
	READ ONLY:C145([Alumnos:2])
	For ($i;1;Size of array:C274($al_IdAlumnos))
		$l_recNumAlumno:=Find in field:C653([Alumnos:2]numero:1;$al_IdAlumnos{$i})
		If ($l_recNumAlumno>=0)
			GOTO RECORD:C242([Alumnos:2];$l_recNumAlumno)
			LOG_RegisterEvt ([Alumnos:2]apellidos_y_nombres:40+" ("+[Alumnos:2]curso:20+") transferido de "+$t_nombreInterAsignaturaOrigen+" a "+$t_nombreInterAsignaturaDestino+", con sus evaluaciones.")
		End if 
	End for 
	OK:=1
End if 

$0:=OK

UNLOAD RECORD:C212([Alumnos_Calificaciones:208])
READ ONLY:C145([Alumnos_Calificaciones:208])

