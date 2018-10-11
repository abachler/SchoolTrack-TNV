Case of 
	: (alProEvt=AL Single click event)
		AL_UpdateArrays (xapl_Mantenciones;0)
		BU_RefreshMantenciones 
		AL_UpdateArrays (xapl_Mantenciones;-2)
		
		AL_UpdateArrays (xalp_Documentos;0)
		bu_loadmantenciones 
		AL_UpdateArrays (xalp_Documentos;-2)
		If (Size of array:C274(alBU_Mantencion)>0)
			_O_ENABLE BUTTON:C192(bDelMantencion)
			_O_ENABLE BUTTON:C192(bDelDoc)
			_O_ENABLE BUTTON:C192(bAddDoc)
		Else 
			_O_DISABLE BUTTON:C193(bDelMantencion)
			_O_DISABLE BUTTON:C193(bDelDoc)
			_O_DISABLE BUTTON:C193(bAddDoc)
		End if 
		
		If (Size of array:C274(alBU_DocID)>0)
			_O_ENABLE BUTTON:C192(bDelDoc)
		Else 
			_O_DISABLE BUTTON:C193(bDelDoc)
		End if 
		
	: (alProEvt=AL Double click event)
		$line:=AL_GetLine (Self:C308->)
		READ ONLY:C145([Buses_escolares:57])
		QUERY:C277([Buses_escolares:57];[Buses_escolares:57]Patente:1;=;atBU_BUSPatente{$line})
		WDW_OpenFormWindow (->[Buses_escolares:57];"AddModBus";-1;4)  //Para abrir la ventana....
		KRL_ModifyRecord (->[Buses_escolares:57];"AddModBus")  //Para abrir el formulario.....
		CLOSE WINDOW:C154
End case 

