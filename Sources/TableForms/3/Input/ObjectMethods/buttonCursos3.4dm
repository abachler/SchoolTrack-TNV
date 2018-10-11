AL_UpdateArrays (xALP_StdList;0)
READ WRITE:C146([Alumnos:2])
AL_AsignaNoLista 
UNLOAD RECORD:C212([Alumnos:2])
READ ONLY:C145([Alumnos:2])

QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)  // ASM 20150119 Ticket 140842 Para no mostrar a los alumnos ocultos de nominas
SELECTION TO ARRAY:C260([Alumnos:2]numero:1;<>aStdId;[Alumnos:2]apellidos_y_nombres:40;<>aStdWhNme;[Alumnos:2]no_de_lista:53;<>aStdNo)
AL_UpdateArrays (xALP_StdList;Size of array:C274(<>aStdID))
AL_SetSort (xALP_StdList;1)