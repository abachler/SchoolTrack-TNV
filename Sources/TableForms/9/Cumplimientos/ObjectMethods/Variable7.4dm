
$uTherProcessID:=IT_UThermometer (1;0;__ ("Cargando castigos incumplidos..."))
Case of 
	: (<>aCursos>0)
		QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=<>aCursos{<>aCursos})
		KRL_RelateSelection (->[Alumnos_Castigos:9]Alumno_Numero:8;->[Alumnos:2]numero:1)
		QUERY SELECTION:C341([Alumnos_Castigos:9];[Alumnos_Castigos:9]Castigo_cumplido:4=(bOk=1))
	: (<>at_NombreNivelesActivos>0)
		QUERY:C277([Alumnos:2];[Alumnos:2]Nivel_Nombre:34=<>at_NombreNivelesActivos{<>at_NombreNivelesActivos})
		KRL_RelateSelection (->[Alumnos_Castigos:9]Alumno_Numero:8;->[Alumnos:2]numero:1)
		QUERY SELECTION:C341([Alumnos_Castigos:9];[Alumnos_Castigos:9]Castigo_cumplido:4=(bOk=1))
	: (<>aListSect>0)
		QUERY:C277([Alumnos:2];[Alumnos:2]Sección:26=<>aListSect{<>aListSect})
		KRL_RelateSelection (->[Alumnos_Castigos:9]Alumno_Numero:8;->[Alumnos:2]numero:1)
		QUERY SELECTION:C341([Alumnos_Castigos:9];[Alumnos_Castigos:9]Castigo_cumplido:4=(bOk=1))
	Else 
		QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Castigo_cumplido:4=(bOk=1))
End case 
CREATE SET:C116([Alumnos_Castigos:9];"Castigos")
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Alumnos_Castigos:9];alCastigos_RecNums;[Alumnos_Castigos:9]Castigo_cumplido:4;abCastigo_Cumplimiento;[Alumnos_Castigos:9]Fecha:9;adCastigo_Fecha;[Alumnos:2]curso:20;atCastigos_curso;[Alumnos:2]nivel_numero:29;alCastigos_NoNivel;[Alumnos:2]no_de_lista:53;aiCastigos_NumeroLista;[Alumnos:2]apellidos_y_nombres:40;atCastigos_NombreAlumno)

SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
AL_UpdateArrays (xALP_Det;Size of array:C274(alCastigos_RecNums))
AL_SetLine (xALP_Det;0)
CLOSE WINDOW:C154
IT_UThermometer (-2;$uTherProcessID)