$line:=AL_GetLine (xalp_Buses)

If ($line>0)
	  //Valida si existen rutas con el bus asignado
	QUERY:C277([BU_Rutas:26];[BU_Rutas:26]Patente_Bus:11;=;atBU_BUSPatente{$line})
	If (Records in selection:C76([BU_Rutas:26])>0)
		ok:=CD_Dlog (1;__ ("El Bus no se puede eliminar esta siendo usado en  registros de Rutas");__ ("");__ ("OK"))
	Else 
		  //Valida si existen alumnos con el bus asignado
		QUERY:C277([Alumnos:2];[Alumnos:2]Patente_bus_escolar:37;=;atBU_BUSPatente{$line})
		If (Records in selection:C76([Alumnos:2])>0)
			ok:=CD_Dlog (1;__ ("El Bus no se puede eliminar esta siendo usado en  registros de Alumnos");__ ("");__ ("OK"))
		Else 
			READ WRITE:C146([BU_Buses_Documentos:38])
			QUERY:C277([BU_Buses_Documentos:38];[BU_Buses_Documentos:38]Patente_Bus:5;=;atBU_BUSPatente{$line})
			DELETE SELECTION:C66([BU_Buses_Documentos:38])
			READ ONLY:C145([BU_Buses_Documentos:38])
			READ WRITE:C146([BU_Buses_Mantencion:32])
			QUERY:C277([BU_Buses_Mantencion:32];[BU_Buses_Mantencion:32]Patente_Bus:2;=;atBU_BUSPatente{$line})
			DELETE SELECTION:C66([BU_Buses_Mantencion:32])
			READ ONLY:C145([BU_Buses_Mantencion:32])
			READ WRITE:C146([Buses_escolares:57])
			QUERY:C277([Buses_escolares:57];[Buses_escolares:57]Patente:1;=;atBU_BUSPatente{$line})
			DELETE RECORD:C58([Buses_escolares:57])
			READ ONLY:C145([Buses_escolares:57])
			
			AL_UpdateArrays (xalp_Documentos;0)
			AT_Initialize (->alBU_NumDoc;->alBU_NumMant;->adBU_FechaDoc;->atBU_Descrip;->atBU_PatBus;->alBU_DocID)
			AL_UpdateArrays (xalp_Documentos;-2)
			
			AL_UpdateArrays (xapl_Mantenciones;0)
			BU_RefreshMantenciones 
			AL_UpdateArrays (xapl_Mantenciones;-2)
			
			AL_UpdateArrays (xalp_Buses;0)
			BU_RefreshBuses 
			AL_UpdateArrays (xalp_Buses;-2)
		End if 
		
	End if 
	
End if 
If (Size of array:C274(atBU_BUSPatente)>0)
	_O_ENABLE BUTTON:C192(bDelBus)
	_O_ENABLE BUTTON:C192(bAddMantencion)
Else 
	_O_DISABLE BUTTON:C193(bDelBus)
	_O_DISABLE BUTTON:C193(bAddMantencion)
End if 
If (Size of array:C274(alBU_Mantencion)>0)
	_O_ENABLE BUTTON:C192(bDelMantencion)
	_O_ENABLE BUTTON:C192(bDelDoc)
	_O_ENABLE BUTTON:C192(bAddDoc)
Else 
	_O_DISABLE BUTTON:C193(bDelMantencion)
	_O_DISABLE BUTTON:C193(bDelDoc)
	_O_DISABLE BUTTON:C193(bAddDoc)
End if 