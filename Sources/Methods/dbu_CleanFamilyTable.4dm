//%attributes = {}
  //dbu_CleanFamilyTable

ALL RECORDS:C47([Familia:78])
READ WRITE:C146([Familia:78])
APPLY TO SELECTION:C70([Familia:78];[Familia:78]Nombre_de_la_familia:3:=ST_GetCleanString (Replace string:C233([Familia:78]Nombre_de_la_familia:3;"/";" ")))


ALL RECORDS:C47([Alumnos:2])
READ WRITE:C146([Alumnos:2])
APPLY TO SELECTION:C70([Alumnos:2];[Alumnos:2]Apellido_paterno:3:=ST_GetCleanString ([Alumnos:2]Apellido_paterno:3))
APPLY TO SELECTION:C70([Alumnos:2];[Alumnos:2]Apellido_materno:4:=ST_GetCleanString ([Alumnos:2]Apellido_materno:4))


QUERY:C277([Familia:78];[Familia:78]Nombre_de_la_familia:3="*@")  // se buscan las familias cuyos nombres comienzan con un arterisco 
KRL_RelateSelection (->[Alumnos:2]Familia_Número:24;->[Familia:78]Numero:1)  //se obtiene a selección a los alumnos de esas familias


READ WRITE:C146([Alumnos:2])
FIRST RECORD:C50([Alumnos:2])
While (Not:C34(End selection:C36([Alumnos:2])))
	QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
	If ([Familia:78]Nombre_de_la_familia:3="*@")
		QUERY:C277([Familia:78];[Familia:78]Nombre_de_la_familia:3=([Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4))
		If (Records in selection:C76([Familia:78])=1)
			[Alumnos:2]Familia_Número:24:=[Familia:78]Numero:1  //se cambia al alumno a la familia del mismo nombre sin arterisco
			SAVE RECORD:C53([Alumnos:2])
		End if 
	End if 
	NEXT RECORD:C51([Alumnos:2])
End while 

  //se buscan nuevamente las familias con arteriscos
CREATE EMPTY SET:C140([Familia:78];"Familias")
QUERY:C277([Familia:78];[Familia:78]Nombre_de_la_familia:3="*@")
While (Not:C34(End selection:C36([Familia:78])))
	QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1)
	If (Records in selection:C76([Alumnos:2])=0)  //si la familia no tiene ningún alumno se agrega al conjunto de las familias a eliminar
		ADD TO SET:C119([Familia:78];"Familias")
	End if 
	NEXT RECORD:C51([Familia:78])
End while 

USE SET:C118("Familias")
KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Familia:78]Numero:1)  //se buscan las relaciones familiares de las familias a eliminar
KRL_DeleteSelection (->[Familia_RelacionesFamiliares:77])  //se eliminan las relaciones familiares
KRL_DeleteSelection (->[Familia:78])  //se eliminan las familias sin alumnos y cuyo nombre comienza con arterisco 

KRL_SelectOrphanRecords (->[Alumnos:2]Familia_Número:24;->[Familia:78]Numero:1)  //se buscan las familias que no tienen ningún alumno (o exalumno) relacionado
KRL_DeleteSelection (->[Familia:78])  //se eliminan las familias sin alumnos 

dbu_CountFamilyStudents   //reconteo del numero de alumnos por familia

  //busqueda y de personas no relacionadas a ninguna familia ni ningun alumno.
CREATE EMPTY SET:C140([Personas:7];"personas")
ALL RECORDS:C47([Personas:7])
While (Not:C34(End selection:C36([Personas:7])))
	QUERY:C277([Familia:78];[Familia:78]Padre_Número:5=[Personas:7]No:1;*)
	QUERY:C277([Familia:78]; | [Familia:78]Madre_Número:6=[Personas:7]No:1)
	If (Records in selection:C76([Familia:78])=0)
		QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_académico_Número:27=[Personas:7]No:1;*)
		QUERY:C277([Alumnos:2]; | [Alumnos:2]Apoderado_Cuentas_Número:28=[Personas:7]No:1)
		If (Records in selection:C76([Alumnos:2])=0)
			ADD TO SET:C119([Personas:7];"personas")
		End if 
	End if 
	NEXT RECORD:C51([Personas:7])
End while 
USE SET:C118("personas")
KRL_DeleteSelection (->[Personas:7])  //eliminacion de personas no relacionadas a ninguna familia ni ningun alumno