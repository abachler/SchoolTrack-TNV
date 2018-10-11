If (Size of array:C274(a_LB_AADIAP_asignatura)<5)
	DIAP_InscribeAsignatura (al_ID_alumnos{al_ID_alumnos};0;1;1)
	
	ARRAY INTEGER:C220(a_LB_AADIAP_orden;0)
	ARRAY TEXT:C222(a_LB_AADIAP_abrev;0)
	ARRAY TEXT:C222(a_LB_AADIAP_asignatura;0)
	ARRAY TEXT:C222(a_LB_AADIAP_tipoExamen;0)
	ARRAY TEXT:C222(a_LB_AADIAP_IdiomaMaterno;0)
	ARRAY TEXT:C222(a_inscripcion_UUID;0)
	ARRAY LONGINT:C221(a_id_asignatura;0)
	ARRAY LONGINT:C221(a_id_tipoexamen;0)
	ARRAY LONGINT:C221(a_id_lenguaMaterna;0)
	
	DIAP_InscribeCargaAluAsig (al_ID_alumnos{al_ID_alumnos};->a_LB_AADIAP_orden;->a_LB_AADIAP_abrev;->a_id_asignatura;->a_LB_AADIAP_asignatura;->a_id_tipoexamen;->a_LB_AADIAP_tipoExamen;->a_id_lenguaMaterna;->a_LB_AADIAP_IdiomaMaterno;->a_inscripcion_UUID)
	
End if 