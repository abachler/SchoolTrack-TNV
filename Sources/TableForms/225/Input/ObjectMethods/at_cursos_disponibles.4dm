If (Self:C308->>0)
	
	C_TEXT:C284($label_alumnos)
	ARRAY TEXT:C222(at_alumnos;0)
	ARRAY LONGINT:C221(al_ID_alumnos;0)
	ARRAY TEXT:C222(at_asignaturas_inscritas;0)
	
	$label_alumnos:=DIAP_InscribeCargaAlumnos (at_cursos_disponibles{at_cursos_disponibles};->at_alumnos;->al_ID_alumnos;->at_asignaturas_inscritas)
	OBJECT SET TITLE:C194(*;"txt_alumnosinscritos";$label_alumnos)
	OBJECT SET TITLE:C194(*;"txt_curso_seleccionado";"Curso: "+at_cursos_disponibles{at_cursos_disponibles})
	
	ARRAY INTEGER:C220(a_LB_AADIAP_orden;0)
	ARRAY TEXT:C222(a_LB_AADIAP_abrev;0)
	ARRAY TEXT:C222(a_LB_AADIAP_asignatura;0)
	ARRAY TEXT:C222(a_LB_AADIAP_tipoExamen;0)
	ARRAY TEXT:C222(a_LB_AADIAP_IdiomaMaterno;0)
	ARRAY TEXT:C222(a_inscripcion_UUID;0)
	ARRAY LONGINT:C221(a_id_asignatura;0)
	ARRAY LONGINT:C221(a_id_tipoexamen;0)
	ARRAY LONGINT:C221(a_id_lenguaMaterna;0)
	
	LB_Alumnos:=0
	ARRAY BOOLEAN:C223(LB_Alumnos;0)
	ARRAY BOOLEAN:C223(LB_Alumnos;Size of array:C274(at_alumnos))
	
	OBJECT SET ENABLED:C1123(*;"bInscribeAlu";False:C215)
	OBJECT SET ENABLED:C1123(*;"bDesinscribeAlu";False:C215)
	
	OBJECT SET ENABLED:C1123(*;"bInscribeIdioma";False:C215)
	OBJECT SET ENABLED:C1123(*;"bDesinscribeIdioma";False:C215)
	
End if 