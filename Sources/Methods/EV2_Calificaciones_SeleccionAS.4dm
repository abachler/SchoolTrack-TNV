//%attributes = {}
  //EV2_Calificaciones_SeleccionAS

KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_institucion:2=<>gInstitucion;*)
QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]Año:3=<>gYear)