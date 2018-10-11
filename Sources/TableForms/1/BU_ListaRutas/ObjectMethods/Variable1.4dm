ok:=CD_Dlog (0;__ ("¿Desea Ud. crear un nuevo viaje?");__ ("");__ ("Sí");__ ("No"))

If (ok=1)
	ARRAY TEXT:C222(atRuta;0)
	ARRAY LONGINT:C221(alIDRuta;0)
	ARRAY TEXT:C222(atRecorrido;0)
	ARRAY LONGINT:C221(alIDRecorrido;0)
	_O_DISABLE BUTTON:C193(atRecorrido)
	WDW_OpenFormWindow (->[BU_Viajes:109];"AddViaje";-1;4)  //Para abrir la ventana....
	FORM SET INPUT:C55([BU_Viajes:109];"AddViaje")
	ADD RECORD:C56([BU_Viajes:109];*)
	CLOSE WINDOW:C154
	
	If (ok=1)
		  //inicialiación de arreglos
		BU_InicializaArrayViajes 
		ARRAY LONGINT:C221(aRec;0)
		  //encuentra la ruta y llena los arreglos de recorridos para la ruta
		QUERY:C277([BU_Viajes:109];[BU_Viajes:109]ID:1;=;vlBU_IDViaje)
		$ruta:=[BU_Viajes:109]Numero_Ruta:3
		dViaje:=[BU_Viajes:109]Fecha:2
		QUERY:C277([BU_Viajes:109];[BU_Viajes:109]Fecha:2;=;dViaje;*)
		QUERY:C277([BU_Viajes:109]; & ;[BU_Viajes:109]Numero_Ruta:3;=;$ruta)
		AT_DistinctsFieldValues (->[BU_Viajes:109]Numero_Recorrido:4;->aRec;1)
		QRY_QueryWithArray (->[BU_Rutas_Recorridos:33]ID_Recorrido:1;->aRec)
		AT_Initialize (->aRec)
		SELECTION TO ARRAY:C260([BU_Rutas_Recorridos:33]Nombre:3;atBU_RecNombre;[BU_Rutas_Recorridos:33]Jornada:4;atBU_RecJornada;[BU_Rutas_Recorridos:33]Dia_Semana:6;atBU_RecDia;[BU_Rutas_Recorridos:33]ID_Recorrido:1;alBU_RecID;[BU_Rutas_Recorridos:33]ID_Ruta:2;alBU_RecIDRuta)
		
		  //cargar los datos del viaje
		READ WRITE:C146([BU_Viajes:109])
		QUERY:C277([BU_Viajes:109];[BU_Viajes:109]ID:1;=;vlBU_IDViaje)
		
		  //selecciona los registros de Alumnos del viaje
		ARRAY PICTURE:C279(ap_Asistencia;0)
		READ ONLY:C145([BU_Viajes_Personas:111])
		QUERY:C277([BU_Viajes_Personas:111];[BU_Viajes_Personas:111]Numero_Viaje:2;=;vlBU_IDViaje;*)
		QUERY:C277([BU_Viajes_Personas:111]; & ;[BU_Viajes_Personas:111]Numero_Alumno:3#0)
		SELECTION TO ARRAY:C260([BU_Viajes_Personas:111]Nombres_y_Apellidos:11;atBU_Nombre;[BU_Viajes_Personas:111]Asiste:5;abBU_Asiste;[BU_Viajes_Personas:111]Lugar_subida:6;atBU_LugarSalida;[BU_Viajes_Personas:111]Hora_subida:7;alBU_HoraSalida;[BU_Viajes_Personas:111]Quien_dejó:8;atBU_PersonaDeja;[BU_Viajes_Personas:111]Lugar_bajada:9;atBU_LugarLlegada;[BU_Viajes_Personas:111]Hora_bajada:12;alBU_HoraLlegada;[BU_Viajes_Personas:111]Quien_recibio:10;atBU_PersonaRecibe;[BU_Viajes_Personas:111]Numero_Alumno:3;alBU_IDAlumno;[BU_Viajes_Personas:111]Numero_Profesor:4;alBU_IDProfesor;[BU_Viajes_Personas:111]Numero_Viaje:2;alBU_IDViaje;[BU_Viajes_Personas:111]ID:1;alBU_IDRegistro)
		ARRAY PICTURE:C279(ap_Asistencia;Size of array:C274(alBU_IDAlumno))
		For ($i;1;Size of array:C274(abBU_Asiste))
			If (abBU_Asiste{$i})
				GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";ap_Asistencia{$i})
			Else 
				GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";ap_Asistencia{$i})
			End if 
		End for 
		
		WDW_OpenFormWindow (->[BU_Viajes:109];"input";-1;4)  //Para abrir la ventana....
		BWR_ModifyRecord (->[BU_Viajes:109];"Input")
		CLOSE WINDOW:C154
		KRL_UnloadReadOnly (->[BU_Viajes:109])
		AL_SetLine (xalp_Rutas;0)
		IT_SetButtonState (False:C215;->bDelRuta)
	End if 
Else 
	ARRAY DATE:C224(adBU_Fecha;0)
	ARRAY LONGINT:C221(alBU_NumeroViaje;0)
	WDW_OpenFormWindow (->[BU_Viajes:109];"ModViaje";-1;4)  //Para abrir la ventana....
	DIALOG:C40([BU_Viajes:109];"ModViaje")
	CLOSE WINDOW:C154
	AL_SetLine (xalp_Rutas;0)
	IT_SetButtonState (False:C215;->bDelRuta)
End if 

