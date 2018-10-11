//%attributes = {}
  //BU_SaveViajesPersonas

READ WRITE:C146([BU_Viajes_Personas:111])
For ($i;1;Size of array:C274(alBU_IDRegistro))
	QUERY:C277([BU_Viajes_Personas:111];[BU_Viajes_Personas:111]ID:1;=;alBU_IDRegistro{$i})
	[BU_Viajes_Personas:111]Asiste:5:=abBU_Asiste{$i}
	[BU_Viajes_Personas:111]Lugar_subida:6:=atBU_LugarSalida{$i}
	[BU_Viajes_Personas:111]Hora_subida:7:=alBU_HoraSalida{$i}
	[BU_Viajes_Personas:111]Quien_dejó:8:=atBU_PersonaDeja{$i}
	[BU_Viajes_Personas:111]Lugar_bajada:9:=atBU_LugarLlegada{$i}
	[BU_Viajes_Personas:111]Hora_bajada:12:=alBU_HoraLlegada{$i}
	[BU_Viajes_Personas:111]Quien_recibio:10:=atBU_PersonaRecibe{$i}
	SAVE RECORD:C53([BU_Viajes_Personas:111])
End for 
