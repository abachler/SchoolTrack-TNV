
DIAP_InscribeAlumnosIdiomas (al_ID_alumnos{al_ID_alumnos})

ARRAY TEXT:C222(a_LB_Aidioma_UUID;0)
ARRAY INTEGER:C220(a_LB_Aidioma_orden;0)
ARRAY TEXT:C222(a_LB_Aidioma_Codigo;0)
ARRAY TEXT:C222(a_LB_Aidioma_DesAleman;0)
ARRAY TEXT:C222(a_LB_Aidioma_DesEspañol;0)
ARRAY INTEGER:C220(a_LB_Aidioma_NivelDesde;0)
ARRAY INTEGER:C220(a_LB_Aidioma_NivelHasta;0)

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

OBJECT SET ENABLED:C1123(*;"bDesinscribeIdioma";(Size of array:C274(a_LB_Aidioma_UUID)>0))