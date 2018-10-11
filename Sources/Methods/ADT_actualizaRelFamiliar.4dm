//%attributes = {}

C_LONGINT:C283($1;$l_idAlumno)  //`ID DEL ALUMNO

  //ASM 20130729 ASM para cuando no se pase un parametro, no vuelva a cargar al alumno.
If (Count parameters:C259=1)
	$l_idAlumno:=$1
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$l_idAlumno)
Else 
	$l_idAlumno:=[Alumnos:2]numero:1
End if 
  //`buscar la familia
QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)



  //`BUSCO EL PADRE EN RELACIONES FAMILIARES
READ WRITE:C146([Familia_RelacionesFamiliares:77])
QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Familia:78]Padre_Número:5;*)
QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)

If (Records in selection:C76([Familia_RelacionesFamiliares:77])=0)
	  //se crea el registro del padre en relaciones familiares
	CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
	[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Familia:78]Padre_Número:5
	[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
	[Familia_RelacionesFamiliares:77]ID_Alumno:1:=$l_idAlumno
	[Familia_RelacionesFamiliares:77]Parentesco:6:="Padre"
	[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=2
	SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
Else 
	  //`actualizo la relacion familiar en caso de que no esten correctos los datos
	[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Familia:78]Padre_Número:5
	[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
	[Familia_RelacionesFamiliares:77]ID_Alumno:1:=$l_idAlumno
	[Familia_RelacionesFamiliares:77]Parentesco:6:="Padre"
	[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=2
	SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
End if 


  //`BUSCO LA MADRE EN RELACIONES FAMILIARES
READ WRITE:C146([Familia_RelacionesFamiliares:77])
QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Familia:78]Madre_Número:6;*)
QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)

If (Records in selection:C76([Familia_RelacionesFamiliares:77])=0)
	  //se crea el registro de la madre en relaciones familiares
	CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
	[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Familia:78]Madre_Número:6
	[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
	[Familia_RelacionesFamiliares:77]ID_Alumno:1:=$l_idAlumno
	[Familia_RelacionesFamiliares:77]Parentesco:6:="Madre"
	[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=1
	SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
Else 
	  //`actualizo la relacion familiar en caso de que no esten correctos los datos
	[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Familia:78]Madre_Número:6
	[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
	[Familia_RelacionesFamiliares:77]ID_Alumno:1:=$l_idAlumno
	[Familia_RelacionesFamiliares:77]Parentesco:6:="Madre"
	[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=1
	SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
End if 

KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares:77])
KRL_UnloadReadOnlyOnServer (->[Familia_RelacionesFamiliares:77])