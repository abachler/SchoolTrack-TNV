//%attributes = {}
  //CU_LoadSubjectsAndStudents


ARRAY TEXT:C222(at_OrdenAsignaturas;0)
ARRAY TEXT:C222(aSubjectName;0)
ARRAY TEXT:C222(aSubjectTeacher;0)
If (BLOB size:C605([Cursos:3]Orden_Subsectores:17)>32)
	BLOB_Blob2Vars (->[Cursos:3]Orden_Subsectores:17;0;->at_OrdenAsignaturas;->aSubjectName)
	ARRAY TEXT:C222(aSubjectTeacher;Size of array:C274(at_OrdenAsignaturas))
End if 


RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)
vs_profesorJefe:=[Profesores:4]Nombre_comun:21
READ ONLY:C145([Alumnos:2])
QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Curso:7=[Cursos:3]Curso:1;*)
QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]Año:2=<>gYear;*)
QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6=[Cursos:3]Nivel_Numero:7)

KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_SintesisAnual:210]ID_Alumno:4;"")
If (Not:C34(Macintosh option down:C545 | Windows Alt down:C563))
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)
End if 
SELECTION TO ARRAY:C260([Alumnos:2]numero:1;<>aStdId;[Alumnos:2]apellidos_y_nombres:40;<>aStdWhNme;[Alumnos:2]no_de_lista:53;<>aStdNo)
ARRAY LONGINT:C221(aLong3;0)

READ ONLY:C145([Personas:7])
KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Alumnos:2]Familia_Número:24;"")
KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;at_CuApoderados;[Personas:7];al_CURecNumApoderados)
SORT ARRAY:C229(at_CuApoderados;al_CURecNumApoderados;>)

READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Alumnos_Calificaciones:208])
KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
	QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=<>gYear;*)
	QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]NIvel_Numero:4=[Cursos:3]Nivel_Numero:7)
	KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
Else 
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=[Cursos:3]Curso:1)
End if 

CREATE SET:C116([Asignaturas:18];"Asignaturas del curso")
SELECTION TO ARRAY:C260([Asignaturas:18]denominacion_interna:16;aSubjectName;[Asignaturas:18]profesor_nombre:13;aSubjectTeacher;[Asignaturas:18]ordenGeneral:105;at_OrdenAsignaturas)
SORT ARRAY:C229(at_OrdenAsignaturas;aSubjectName;aSubjectTeacher;>)



REDUCE SELECTION:C351([Alumnos:2];0)
REDUCE SELECTION:C351([Asignaturas:18];0)
REDUCE SELECTION:C351([Profesores:4];0)


AL_UpdateArrays (xALP_StdList;-2)

Case of 
	: (<>gOrdenNta=0)
		AL_SetSort (xALP_StdList;2)  //nombre y surso
	: (<>gOrdenNta=1)
		AL_SetSort (xALP_StdList;1)  //no lista
	: (<>gOrdenNta=2)
		AL_SetSort (xALP_StdList;2)  //nombre
End case 


ALP_SetAlternateLigneColor (xALP_StdList;Size of array:C274(<>aStdWhNme))
ALP_SetAlternateLigneColor (xALP_Asignaturas;Size of array:C274(aSubjectName))

AL_UpdateArrays (xALP_Asignaturas;-2)
For ($i;1;Size of array:C274(aSubjectName))
	$nivelJerarquico:=ST_CountWords (at_OrdenAsignaturas{$i};0;".")
	If ($nivelJerarquico>1)
		aSubjectName{$i}:=(" "*$nivelJerarquico)+aSubjectName{$i}
		AL_SetRowStyle (xALP_Asignaturas;$i;2)
	Else 
		AL_SetRowStyle (xALP_Asignaturas;$i;0)
	End if 
End for 