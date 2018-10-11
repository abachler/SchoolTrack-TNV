$line:=AL_GetLine (xalp_Viajes)

If ($line>0)
	
	READ WRITE:C146([BU_Viajes_Personas:111])
	QUERY:C277([BU_Viajes_Personas:111];[BU_Viajes_Personas:111]Numero_Viaje:2;=;alBU_NumeroViaje{$line})
	DELETE RECORD:C58([BU_Viajes_Personas:111])
	READ ONLY:C145([BU_Viajes_Personas:111])
	
	READ WRITE:C146([BU_Viajes:109])
	QUERY:C277([BU_Viajes:109];[BU_Viajes:109]ID:1;=;alBU_NumeroViaje{$line})
	DELETE RECORD:C58([BU_Viajes:109])
	READ ONLY:C145([BU_Viajes:109])
	
	$idxRec:=Find in array:C230(atRecorrido;vtNombreRec;1)
	AL_UpdateArrays (xALP_Viajes;0)
	READ ONLY:C145([BU_Viajes:109])
	QUERY:C277([BU_Viajes:109];[BU_Viajes:109]Numero_Recorrido:4;=;alIDRecorrido{$idxRec})
	SELECTION TO ARRAY:C260([BU_Viajes:109]Fecha:2;adBU_Fecha;[BU_Viajes:109]ID:1;alBU_NumeroViaje)
	AL_UpdateArrays (xALP_Viajes;-2)
End if 

