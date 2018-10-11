CREATE RECORD:C68([BU_Buses_Documentos:38])
[BU_Buses_Documentos:38]ID:6:=SQ_SeqNumber (->[BU_Buses_Documentos:38]ID:6)
$lineBuses:=AL_GetLine (xalp_Buses)
[BU_Buses_Documentos:38]Patente_Bus:5:=atBU_BUSPatente{$lineBuses}
$lineMant:=AL_GetLine (xapl_Mantenciones)
[BU_Buses_Documentos:38]Numero_Mantencion:4:=alBU_Mantencion{$lineMant}
SAVE RECORD:C53([BU_Buses_Documentos:38])
AL_UpdateArrays (xalp_Documentos;0)
bu_loadmantenciones 
AL_UpdateArrays (xalp_Documentos;-2)

If (Size of array:C274(alBU_DocID)>0)
	_O_ENABLE BUTTON:C192(bDelDoc)
Else 
	_O_DISABLE BUTTON:C193(bDelDoc)
End if 