BU_SaveViajesPersonas 
AL_UpdateArrays (xALP_BUAsistentes;0)
QUERY:C277([BU_Viajes_Personas:111];[BU_Viajes_Personas:111]Numero_Viaje:2;=;[BU_Viajes:109]ID:1;*)
QUERY:C277([BU_Viajes_Personas:111]; & ;[BU_Viajes_Personas:111]Numero_Alumno:3#0)
SELECTION TO ARRAY:C260([BU_Viajes_Personas:111]Nombres_y_Apellidos:11;atBU_Nombre;[BU_Viajes_Personas:111]Asiste:5;abBU_Asiste;[BU_Viajes_Personas:111]Lugar_subida:6;atBU_LugarSalida;[BU_Viajes_Personas:111]Hora_subida:7;alBU_HoraSalida;[BU_Viajes_Personas:111]Quien_dejó:8;atBU_PersonaDeja;[BU_Viajes_Personas:111]Lugar_bajada:9;atBU_LugarLlegada;[BU_Viajes_Personas:111]Hora_bajada:12;alBU_HoraLlegada;[BU_Viajes_Personas:111]Quien_recibio:10;atBU_PersonaRecibe;[BU_Viajes_Personas:111]Numero_Alumno:3;alBU_IDAlumno;[BU_Viajes_Personas:111]Numero_Profesor:4;alBU_IDProfesor;[BU_Viajes_Personas:111]Numero_Viaje:2;alBU_IDViaje;[BU_Viajes_Personas:111]ID:1;alBU_IDRegistro)
AT_RedimArrays (Size of array:C274(atBU_Nombre);->ap_Asistencia)
For ($i;1;Size of array:C274(abBU_Asiste))
	If (abBU_Asiste{$i})
		GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";ap_Asistencia{$i})
	Else 
		GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";ap_Asistencia{$i})
	End if 
End for 
AL_UpdateArrays (xALP_BUAsistentes;-2)
