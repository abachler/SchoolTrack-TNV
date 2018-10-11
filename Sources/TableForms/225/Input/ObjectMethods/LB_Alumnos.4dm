C_LONGINT:C283($line;$col)
LISTBOX GET CELL POSITION:C971(LB_Alumnos;$col;$line)
Case of 
	: ((Form event:C388=On Clicked:K2:4) & (($line>0) & ($line<=Size of array:C274(at_alumnos))))
		ARRAY INTEGER:C220(a_LB_AADIAP_orden;0)
		ARRAY TEXT:C222(a_LB_AADIAP_abrev;0)
		ARRAY TEXT:C222(a_LB_AADIAP_asignatura;0)
		ARRAY TEXT:C222(a_LB_AADIAP_tipoExamen;0)
		ARRAY TEXT:C222(a_LB_AADIAP_IdiomaMaterno;0)
		ARRAY TEXT:C222(a_inscripcion_UUID;0)
		ARRAY LONGINT:C221(a_id_asignatura;0)
		ARRAY LONGINT:C221(a_id_tipoexamen;0)
		ARRAY LONGINT:C221(a_id_lenguaMaterna;0)
		
		DIAP_InscribeCargaAluAsig (al_ID_alumnos{$line};->a_LB_AADIAP_orden;->a_LB_AADIAP_abrev;->a_id_asignatura;->a_LB_AADIAP_asignatura;->a_id_tipoexamen;->a_LB_AADIAP_tipoExamen;->a_id_lenguaMaterna;->a_LB_AADIAP_IdiomaMaterno;->a_inscripcion_UUID)
		
		READ ONLY:C145([DIAP_AlumnosIdiomas:218])
		QUERY:C277([DIAP_AlumnosIdiomas:218];[DIAP_AlumnosIdiomas:218]ID_alumno:2=al_ID_alumnos{al_ID_alumnos};*)
		QUERY:C277([DIAP_AlumnosIdiomas:218]; & ;[DIAP_AlumnosIdiomas:218]Año:9=<>gyear)
		ORDER BY:C49([DIAP_AlumnosIdiomas:218];[DIAP_AlumnosIdiomas:218]Orden:8;>)
		SELECTION TO ARRAY:C260([DIAP_AlumnosIdiomas:218]Auto_UUID:1;a_LB_Aidioma_UUID;*)
		SELECTION TO ARRAY:C260([DIAP_AlumnosIdiomas:218]Orden:8;a_LB_Aidioma_orden;*)
		SELECTION TO ARRAY:C260([DIAP_AlumnosIdiomas:218]Codigo:3;a_LB_Aidioma_Codigo;*)
		SELECTION TO ARRAY:C260([DIAP_AlumnosIdiomas:218]Descripcion_Aleman:4;a_LB_Aidioma_DesAleman;*)
		SELECTION TO ARRAY:C260([DIAP_AlumnosIdiomas:218]Descripcion_Español:5;a_LB_Aidioma_DesEspañol;*)
		SELECTION TO ARRAY:C260([DIAP_AlumnosIdiomas:218]NumeroNivel_Desde:6;a_LB_Aidioma_NivelDesde;*)
		SELECTION TO ARRAY:C260([DIAP_AlumnosIdiomas:218]NumeroNivel_Hasta:7;a_LB_Aidioma_NivelHasta;*)
		SELECTION TO ARRAY:C260
		
		OBJECT SET ENABLED:C1123(*;"bInscribeAlu";(Size of array:C274(a_LB_AADIAP_asignatura)<5))
		OBJECT SET ENABLED:C1123(*;"bDesinscribeAlu";(Size of array:C274(a_LB_AADIAP_asignatura)>1))
		
		OBJECT SET ENABLED:C1123(*;"bInscribeIdioma";True:C214)
		OBJECT SET ENABLED:C1123(*;"bDesinscribeIdioma";(Size of array:C274(a_LB_Aidioma_UUID)>0))
		
End case 
