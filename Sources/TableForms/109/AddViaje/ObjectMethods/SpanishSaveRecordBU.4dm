[BU_Viajes:109]Fecha:2:=dFrom
$Recorrido:=[BU_Viajes:109]Numero_Recorrido:4
$Ruta:=[BU_Viajes:109]Numero_Ruta:3
$IDViaje:=[BU_Viajes:109]ID:1
SAVE RECORD:C53([BU_Viajes:109])
READ ONLY:C145([BU_Viajes:109])

  //Generación de Registros de Alumnos y Funcionarios para un viaje

ARRAY TEXT:C222($atBU_NombreAlumno;0)
ARRAY LONGINT:C221($alBU_NumeroAlumno;0)
ARRAY TEXT:C222($atBU_AcompañadoPor;0)
ARRAY TEXT:C222($atBU_LugarBajada;0)

ARRAY TEXT:C222($atBU_NombreFunc;0)
ARRAY LONGINT:C221($alBU_NumeroFunc;0)


  //0 .- Busca los datos del Recorrido
READ ONLY:C145([BU_Rutas_Recorridos:33])
QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Recorrido:1;=;$Recorrido)
$CalleDesde:=[BU_Rutas_Recorridos:33]Calle_Desde:8
$HoraInicio:=[BU_Rutas_Recorridos:33]Hora:5
$Sentido:=[BU_Rutas_Recorridos:33]Ida_o_vuelta:7
  //1.- Genera los registros de Alumnos para el viaje

READ ONLY:C145([BU_Rutas_Inscripciones:35])
QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Recorrido:4=$Recorrido;*)
QUERY:C277([BU_Rutas_Inscripciones:35]; & ;[BU_Rutas_Inscripciones:35]Numero_Alumno:2#0)
SELECTION TO ARRAY:C260([BU_Rutas_Inscripciones:35]Numero_Alumno:2;$alBU_NumeroAlumno;[BU_Rutas_Inscripciones:35]Nombre_y_Apellidos:9;$atBU_NombreAlumno;[BU_Rutas_Inscripciones:35]Acompañado_por:7;$atBU_AcompañadoPor;[BU_Rutas_Inscripciones:35]Tipo_Servicio:6;$atBU_LugarBajada)

If (Size of array:C274($alBU_NumeroAlumno)>0)
	READ WRITE:C146([BU_Viajes_Personas:111])
	For ($i;1;Size of array:C274($alBU_NumeroAlumno))
		CREATE RECORD:C68([BU_Viajes_Personas:111])
		[BU_Viajes_Personas:111]ID:1:=SQ_SeqNumber (->[BU_Viajes_Personas:111]ID:1)
		[BU_Viajes_Personas:111]Asiste:5:=True:C214
		[BU_Viajes_Personas:111]Numero_Alumno:3:=$alBU_NumeroAlumno{$i}
		[BU_Viajes_Personas:111]Numero_Viaje:2:=$IDViaje
		[BU_Viajes_Personas:111]Nombres_y_Apellidos:11:=$atBU_NombreAlumno{$i}
		If ($Sentido=True:C214)
			[BU_Viajes_Personas:111]Quien_dejó:8:=$atBU_AcompañadoPor{$i}
			[BU_Viajes_Personas:111]Hora_subida:7:=$HoraInicio
			If ($atBU_LugarBajada{$i}="Puerta a Puerta")
				[BU_Viajes_Personas:111]Lugar_subida:6:="Domicilio"
			Else 
				[BU_Viajes_Personas:111]Lugar_subida:6:=$atBU_LugarBajada{$i}
			End if 
			[BU_Viajes_Personas:111]Lugar_bajada:9:=$CalleDesde
			[BU_Viajes_Personas:111]Quien_recibio:10:="Funcionario Colegio"
			
		Else 
			[BU_Viajes_Personas:111]Quien_dejó:8:="Funcionario Colegio"
			[BU_Viajes_Personas:111]Hora_subida:7:=$HoraInicio
			If ($atBU_LugarBajada{$i}="Puerta a Puerta")
				[BU_Viajes_Personas:111]Lugar_bajada:9:="Domicilio"
			Else 
				[BU_Viajes_Personas:111]Lugar_bajada:9:=$atBU_LugarBajada{$i}
			End if 
			[BU_Viajes_Personas:111]Lugar_subida:6:=$CalleDesde
			[BU_Viajes_Personas:111]Quien_recibio:10:=$atBU_AcompañadoPor{$i}
			
		End if 
		
		SAVE RECORD:C53([BU_Viajes_Personas:111])
	End for 
	UNLOAD RECORD:C212([BU_Viajes_Personas:111])
	READ ONLY:C145([BU_Viajes_Personas:111])
End if 

  //2.- Genera los registros de Funcionarios para el viaje

READ ONLY:C145([BU_Rutas_Inscripciones:35])
QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Recorrido:4=$Recorrido;*)
QUERY:C277([BU_Rutas_Inscripciones:35]; & ;[BU_Rutas_Inscripciones:35]Numero_Profesor:3#0)
SELECTION TO ARRAY:C260([BU_Rutas_Inscripciones:35]Numero_Profesor:3;$alBU_NumeroFunc;[BU_Rutas_Inscripciones:35]Nombre_y_Apellidos:9;$atBU_NombreFunc)

If (Size of array:C274($alBU_NumeroFunc)>0)
	READ WRITE:C146([BU_Viajes_Personas:111])
	For ($i;1;Size of array:C274($alBU_NumeroFunc))
		CREATE RECORD:C68([BU_Viajes_Personas:111])
		[BU_Viajes_Personas:111]ID:1:=SQ_SeqNumber (->[BU_Viajes_Personas:111]ID:1)
		[BU_Viajes_Personas:111]Numero_Profesor:4:=$alBU_NumeroFunc{$i}
		[BU_Viajes_Personas:111]Asiste:5:=True:C214
		[BU_Viajes_Personas:111]Numero_Viaje:2:=$IDViaje
		[BU_Viajes_Personas:111]Nombres_y_Apellidos:11:=$atBU_NombreFunc{$i}
		[BU_Viajes_Personas:111]Hora_subida:7:=$HoraInicio
		SAVE RECORD:C53([BU_Viajes_Personas:111])
	End for 
	UNLOAD RECORD:C212([BU_Viajes_Personas:111])
	READ ONLY:C145([BU_Viajes_Personas:111])
End if 

ARRAY TEXT:C222($atBU_NombreAlumno;0)
ARRAY LONGINT:C221($alBU_NumeroAlumno;0)
ARRAY TEXT:C222($atBU_AcompañadoPor;0)
ARRAY TEXT:C222($atBU_LugarBajada;0)

ARRAY TEXT:C222($atBU_NombreFunc;0)
ARRAY LONGINT:C221($alBU_NumeroFunc;0)




