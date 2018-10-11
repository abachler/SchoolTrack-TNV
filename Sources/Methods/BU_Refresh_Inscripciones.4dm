//%attributes = {}
  //BU_Refresh_Inscripciones

  //EMA --> Transporte Escolar
  //Método creado para actualizar el xalp_Inscripciones de BU_Rutas_Input
  //0= Llamado desde Formulario  BU_Listas_Rutas, inicialiación del Area List
  //1= Llamado desde otros métodos

If ($1=0)
	ARRAY TEXT:C222(atBU_ALProf;0)
	ARRAY LONGINT:C221(alBU_IdRec;0)  //Oculto
	ARRAY LONGINT:C221(alBU_IdAlumno;0)  //Oculto
	ARRAY LONGINT:C221(alBU_IdProfesor;0)  //Oculto
	If (Size of array:C274(alBU_IdRecorrido)>0)
		QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Recorrido:4;=;alBU_IdRecorrido{1})
		SELECTION TO ARRAY:C260([BU_Rutas_Inscripciones:35]Alumno_o_Profesor:8;atBU_ALProf;[BU_Rutas_Inscripciones:35]Numero_Recorrido:4;alBU_IdRec;[BU_Rutas_Inscripciones:35]Numero_Alumno:2;alBU_IdAlumno;[BU_Rutas_Inscripciones:35]Numero_Profesor:3;alBU_IdProfesor)
	End if 
	ARRAY TEXT:C222(atBU_Curso;0)
	ARRAY TEXT:C222(atBU_Nombre;0)
	ARRAY TEXT:C222(atBU_Nombre;Size of array:C274(alBU_IdAlumno))
	ARRAY TEXT:C222(atBU_Curso;Size of array:C274(alBU_IdAlumno))
	
	For ($i;1;Size of array:C274(atBU_Nombre))
		If (alBU_IdAlumno{$i}>0)
			READ ONLY:C145([Alumnos:2])
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=alBU_IdAlumno{$i})
			atBU_Nombre{$i}:=[Alumnos:2]apellidos_y_nombres:40
			atBU_Curso{$i}:=[Alumnos:2]curso:20
		Else 
			READ ONLY:C145([Profesores:4])
			QUERY:C277([Profesores:4];[Profesores:4]Numero:1=alBU_IdProfesor{$i})
			atBU_Nombre{$i}:=[Profesores:4]Apellidos_y_nombres:28
			atBU_Curso{$i}:=""
		End if 
	End for 
	ARRAY TEXT:C222(atBU_NomRec;0)
	ARRAY TEXT:C222(atBU_NomRec;Size of array:C274(alBU_IdRec))
	For ($i;1;Size of array:C274(atBU_NomRec))
		READ ONLY:C145([BU_Rutas_Recorridos:33])
		QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Recorrido:1=alBU_IdRec{$i})
		atBU_NomRec{$i}:=[BU_Rutas_Recorridos:33]Nombre:3
	End for 
	
Else 
	AL_UpdateArrays (xalp_Inscripciones;0)
	ARRAY TEXT:C222(atBU_ALProf;0)
	ARRAY LONGINT:C221(alBU_IdRec;0)  //Oculto
	ARRAY LONGINT:C221(alBU_IdAlumno;0)  //Oculto
	ARRAY LONGINT:C221(alBU_IdProfesor;0)  //Oculto
	READ ONLY:C145([BU_Rutas_Recorridos:33])
	If (Count parameters:C259=2)
		QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Recorrido:4;=;$2)
		SELECTION TO ARRAY:C260([BU_Rutas_Inscripciones:35]Alumno_o_Profesor:8;atBU_ALProf;[BU_Rutas_Inscripciones:35]Numero_Recorrido:4;alBU_IdRec;[BU_Rutas_Inscripciones:35]Numero_Alumno:2;alBU_IdAlumno;[BU_Rutas_Inscripciones:35]Numero_Profesor:3;alBU_IdProfesor)
	End if 
	ARRAY TEXT:C222(atBU_Curso;0)
	ARRAY TEXT:C222(atBU_Nombre;0)
	ARRAY TEXT:C222(atBU_Nombre;Size of array:C274(alBU_IdAlumno))
	ARRAY TEXT:C222(atBU_Curso;Size of array:C274(alBU_IdAlumno))
	
	For ($i;1;Size of array:C274(atBU_Nombre))
		If (alBU_IdAlumno{$i}>0)
			READ ONLY:C145([Alumnos:2])
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=alBU_IdAlumno{$i})
			atBU_Nombre{$i}:=[Alumnos:2]apellidos_y_nombres:40
			atBU_Curso{$i}:=[Alumnos:2]curso:20
		Else 
			READ ONLY:C145([Profesores:4])
			QUERY:C277([Profesores:4];[Profesores:4]Numero:1=alBU_IdProfesor{$i})
			atBU_Nombre{$i}:=[Profesores:4]Apellidos_y_nombres:28
			atBU_Curso{$i}:=""
		End if 
	End for 
	ARRAY TEXT:C222(atBU_NomRec;0)
	ARRAY TEXT:C222(atBU_NomRec;Size of array:C274(alBU_IdRec))
	For ($i;1;Size of array:C274(atBU_NomRec))
		READ ONLY:C145([BU_Rutas_Recorridos:33])
		QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Recorrido:1=alBU_IdRec{$i})
		atBU_NomRec{$i}:=[BU_Rutas_Recorridos:33]Nombre:3
	End for 
	AL_UpdateArrays (xalp_Inscripciones;-2)
End if 
