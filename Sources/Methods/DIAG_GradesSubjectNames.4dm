//%attributes = {}
  //DIAG_GradesSubjectNames


$pID:=IT_UThermometer (1;0;__ ("Verificando y reparando registros de notas con problemas…"))
READ WRITE:C146([Alumnos_Calificaciones:208])
QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=<>gYear)
QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]NombreInternoAsignatura:8="";*)
QUERY SELECTION:C341([Alumnos_Calificaciones:208]; | ;[Alumnos_Calificaciones:208]NombreOficialAsignatura:7="")
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
APPLY TO SELECTION:C70([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]NombreInternoAsignatura:8:=[Asignaturas:18]denominacion_interna:16)
APPLY TO SELECTION:C70([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]NombreOficialAsignatura:7:=[Asignaturas:18]Asignatura:3)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
UNLOAD RECORD:C212([Alumnos_Calificaciones:208])
READ ONLY:C145([Alumnos_Calificaciones:208])
IT_UThermometer (-2;$pID)