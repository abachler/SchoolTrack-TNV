  // [xxSTR_Materias].Input.lb_observaciones()
  //
  //
  // creado por: Alberto Bachler Klein: 02-12-15, 17:08:47
  // -----------------------------------------------------------
C_LONGINT:C283($l_elemento;$l_elementos;$l_proceso;$l_registros)
C_POINTER:C301($y_asignadas_Categoria;$y_asignadas_observacion;$y_asignadas_recNum;$y_listaCategorias;$y_observaciones;$y_observacionesEditables;$y_Origen)
C_TEXT:C284($t_Categoria;$t_llave;$t_observacion)

ARRAY LONGINT:C221($al_elementos;0)

$y_listaCategorias:=OBJECT Get pointer:C1124(Object named:K67:5;"listaCategorias")
$y_observaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"observacion")
$y_asignadas_Categoria:=OBJECT Get pointer:C1124(Object named:K67:5;"asignadas_categoria")
$y_asignadas_observacion:=OBJECT Get pointer:C1124(Object named:K67:5;"asignadas_Observacion")
$y_asignadas_recNum:=OBJECT Get pointer:C1124(Object named:K67:5;"asignadas_recNum")

Case of 
	: (Form event:C388=On Drag Over:K2:13)
		$y_observacionesEditables:=OBJECT Get pointer:C1124(Object named:K67:5;"observaciones.editables")
		If ($y_observacionesEditables->=0)
			$0:=-1
		End if 
		
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($y_Origen;$l_elemento;$l_proceso)
		$t_Categoria:=$y_listaCategorias->{$y_listaCategorias->}
		$t_observacion:=$y_observaciones->{$l_elemento}
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
		$t_llave:=KRL_MakeStringAccesKey (->[Alumnos:2]numero:1;->[Asignaturas:18]Numero:1;->vlSTR_PeriodoObservaciones)
		QUERY:C277([Alumnos_ObservacionesEvaluacion:30];[Alumnos_ObservacionesEvaluacion:30]Key:9=$t_llave;*)
		QUERY:C277([Alumnos_ObservacionesEvaluacion:30]; & ;[Alumnos_ObservacionesEvaluacion:30]Categoría:4;=;$t_Categoria;*)
		QUERY:C277([Alumnos_ObservacionesEvaluacion:30]; & ;[Alumnos_ObservacionesEvaluacion:30]Observacion:5;=;$t_observacion)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($l_registros=0)
			CREATE RECORD:C68([Alumnos_ObservacionesEvaluacion:30])
			[Alumnos_ObservacionesEvaluacion:30]ID_Asignatura:2:=[Asignaturas:18]Numero:1
			[Alumnos_ObservacionesEvaluacion:30]ID_Alumno:1:=[Alumnos:2]numero:1
			[Alumnos_ObservacionesEvaluacion:30]Periodo:3:=vlSTR_PeriodoObservaciones
			[Alumnos_ObservacionesEvaluacion:30]RegistradaPor:8:=<>tUSR_CurrentUser
			[Alumnos_ObservacionesEvaluacion:30]Categoría:4:=$t_Categoria
			[Alumnos_ObservacionesEvaluacion:30]Observacion:5:=$t_observacion
			SAVE RECORD:C53([Alumnos_ObservacionesEvaluacion:30])
			
			QUERY:C277([Alumnos_ObservacionesEvaluacion:30];[Alumnos_ObservacionesEvaluacion:30]Key:9=$t_llave)
			ORDER BY:C49([Alumnos_ObservacionesEvaluacion:30];[Alumnos_ObservacionesEvaluacion:30]Categoría:4;>;[Alumnos_ObservacionesEvaluacion:30]Observacion:5;>)
			SELECTION TO ARRAY:C260([Alumnos_ObservacionesEvaluacion:30];$y_asignadas_recNum->;[Alumnos_ObservacionesEvaluacion:30]Categoría:4;$y_asignadas_Categoria->;[Alumnos_ObservacionesEvaluacion:30]Observacion:5;$y_asignadas_observacion->)
		End if 
End case 


