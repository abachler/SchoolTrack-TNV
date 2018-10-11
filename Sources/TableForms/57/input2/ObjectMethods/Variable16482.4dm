$line:=AL_GetLine (xalp_Documentos)
If ($line>0)
	READ WRITE:C146([BU_Buses_Documentos:38])
	QUERY:C277([BU_Buses_Documentos:38];[BU_Buses_Documentos:38]ID:6=alBU_DocID{$line})
	DELETE RECORD:C58([BU_Buses_Documentos:38])
	AL_UpdateArrays (xalp_Documentos;0)
	bu_loadmantenciones 
	AL_UpdateArrays (xalp_Documentos;-2)
End if 
If (Size of array:C274(alBU_DocID)>0)
	_O_ENABLE BUTTON:C192(bDelDoc)
Else 
	_O_DISABLE BUTTON:C193(bDelDoc)
End if 