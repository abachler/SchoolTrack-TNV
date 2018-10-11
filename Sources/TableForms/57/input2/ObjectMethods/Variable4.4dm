$line:=AL_GetLine (xapl_Mantenciones)

If ($line>0)
	
	READ WRITE:C146([BU_Buses_Documentos:38])
	QUERY:C277([BU_Buses_Documentos:38];[BU_Buses_Documentos:38]Numero_Mantencion:4;=;alBU_Mantencion{$line})
	DELETE SELECTION:C66([BU_Buses_Documentos:38])
	READ ONLY:C145([BU_Buses_Documentos:38])
	READ WRITE:C146([BU_Buses_Mantencion:32])
	QUERY:C277([BU_Buses_Mantencion:32];[BU_Buses_Mantencion:32]Numero:1;=;alBU_Mantencion{$line})
	DELETE RECORD:C58([BU_Buses_Mantencion:32])
	
	AL_UpdateArrays (xapl_Mantenciones;0)
	BU_RefreshMantenciones 
	AL_UpdateArrays (xapl_Mantenciones;-2)
	AL_UpdateArrays (xalp_Documentos;0)
	AT_Initialize (->alBU_NumDoc;->alBU_NumMant;->adBU_FechaDoc;->atBU_Descrip;->atBU_PatBus;->alBU_DocID)
	AL_UpdateArrays (xalp_Documentos;-2)
	
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

If (Size of array:C274(alBU_DocID)>0)
	_O_ENABLE BUTTON:C192(bDelDoc)
Else 
	_O_DISABLE BUTTON:C193(bDelDoc)
End if 