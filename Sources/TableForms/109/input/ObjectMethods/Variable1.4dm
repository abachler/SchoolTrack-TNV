If (Self:C308->>0)
	vtNombreRutaV:=Self:C308->{Self:C308->}
	AL_UpdateArrays (xALP_BURecorridos;0)
	AL_UpdateArrays (xALP_BUAsistentes;0)
	BU_InicializaArrayViajes 
	AL_UpdateArrays (xALP_BURecorridos;-2)
	AL_UpdateArrays (xALP_BUAsistentes;-2)
	ARRAY LONGINT:C221(aRec;0)
	AL_UpdateArrays (xALP_BURecorridos;0)
	QUERY:C277([BU_Viajes:109];[BU_Viajes:109]Fecha:2;=;dViaje;*)
	QUERY:C277([BU_Viajes:109]; & ;[BU_Viajes:109]Numero_Ruta:3;=;alIDRuta{Self:C308->})
	AT_DistinctsFieldValues (->[BU_Viajes:109]Numero_Recorrido:4;->aRec;1)
	QRY_QueryWithArray (->[BU_Rutas_Recorridos:33]ID_Recorrido:1;->aRec)
	AT_Initialize (->aRec)
	SELECTION TO ARRAY:C260([BU_Rutas_Recorridos:33]Nombre:3;atBU_RecNombre;[BU_Rutas_Recorridos:33]Jornada:4;atBU_RecJornada;[BU_Rutas_Recorridos:33]Dia_Semana:6;atBU_RecDia;[BU_Rutas_Recorridos:33]ID_Recorrido:1;alBU_RecID;[BU_Rutas_Recorridos:33]ID_Ruta:2;alBU_RecIDRuta)
	AL_UpdateArrays (xALP_BURecorridos;-2)
End if 
