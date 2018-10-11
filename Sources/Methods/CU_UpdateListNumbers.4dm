//%attributes = {}
  //CU_UpdateListNumbers

MESSAGES OFF:C175
$pID:=IT_UThermometer (1;0;__ ("Actualizando números de lista…"))
QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=[Cursos:3]Curso:1)
KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=<>gYear)
READ WRITE:C146([Alumnos_Calificaciones:208])
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
APPLY TO SELECTION:C70([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]NoDeLista:10:=[Alumnos:2]no_de_lista:53)
While (Records in set:C195("LockedSet")>0)
	USE SET:C118("LockedSet")
	APPLY TO SELECTION:C70([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]NoDeLista:10:=[Alumnos:2]no_de_lista:53)
End while 
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
UNLOAD RECORD:C212([Alumnos_Calificaciones:208])
READ ONLY:C145([Alumnos_Calificaciones:208])

IT_UThermometer (-2;$pID)