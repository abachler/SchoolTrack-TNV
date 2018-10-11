Case of 
	: (alProEvt=AL Single click event)
		AL_UpdateArrays (xalp_Documentos;0)
		bu_loadmantenciones 
		AL_UpdateArrays (xalp_Documentos;-2)
		
	: (alProEvt=AL Double click event)
		$line:=AL_GetLine (Self:C308->)
		READ ONLY:C145([BU_Buses_Mantencion:32])
		QUERY:C277([BU_Buses_Mantencion:32];[BU_Buses_Mantencion:32]Numero:1;=;alBU_Mantencion{$line})
		WDW_OpenFormWindow (->[BU_Buses_Mantencion:32];"input";-1;4)
		KRL_ModifyRecord (->[BU_Buses_Mantencion:32];"input")
		CLOSE WINDOW:C154
End case 
