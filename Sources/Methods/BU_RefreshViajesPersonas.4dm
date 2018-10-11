//%attributes = {}
  //BU_RefreshViajesPersonas

  //BU_InicializaArrayViajes 
  //READ ONLY([BU_Viajes_Personas])
  //QUERY([BU_Viajes_Personas];[BU_Viajes_Personas]Numero_Viaje;=;$1)
  //SELECTION TO ARRAY([BU_Viajes_Personas]Nombres_y_Apellidos;atBU_Nombre;[BU_Viajes_Personas]Asiste;abBU_Asiste;[BU_Viajes_Personas]Lugar_subida;atBU_LugarSalida;[BU_Viajes_Personas]Hora_subida;alBU_HoraSalida;[BU_Viajes_Personas]Quien_dejó;atBU_PersonaDeja;[BU_Viajes_Personas]Lugar_bajada;atBU_LugarLlegada;[BU_Viajes_Personas]Hora_bajada;alBU_HoraLlegada;[BU_Viajes_Personas]Quien_recibio;atBU_PersonaRecibe;[BU_Viajes_Personas]Numero_Alumno;alBU_IDAlumno;[BU_Viajes_Personas]Numero_Profesor;alBU_IDProfesor;[BU_Viajes_Personas]Numero_Viaje;alBU_IDViaje;[BU_Viajes_Personas]ID;alBU_IDRegistro)