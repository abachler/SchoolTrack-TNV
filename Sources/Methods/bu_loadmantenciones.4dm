//%attributes = {}
  //bu_loadmantenciones

READ WRITE:C146([BU_Buses_Documentos:38])
For ($i;1;Size of array:C274(alBU_DocID))
	QUERY:C277([BU_Buses_Documentos:38];[BU_Buses_Documentos:38]ID:6=alBU_DocID{$i})
	[BU_Buses_Documentos:38]Numero:1:=alBU_NumDoc{$i}
	[BU_Buses_Documentos:38]Fecha:2:=adBU_FechaDoc{$i}
	[BU_Buses_Documentos:38]Descripcion:3:=atBU_Descrip{$i}
	SAVE RECORD:C53([BU_Buses_Documentos:38])
End for 
UNLOAD RECORD:C212([BU_Buses_Documentos:38])
READ ONLY:C145([BU_Buses_Documentos:38])
ARRAY LONGINT:C221(alBU_NumDoc;0)
ARRAY LONGINT:C221(alBU_NumMant;0)
ARRAY DATE:C224(adBU_FechaDoc;0)
ARRAY TEXT:C222(atBU_Descrip;0)
ARRAY TEXT:C222(atBU_PatBus;0)
ARRAY LONGINT:C221(alBU_DocID;0)
$line:=AL_GetLine (xapl_Mantenciones)
QUERY:C277([BU_Buses_Documentos:38];[BU_Buses_Documentos:38]Numero_Mantencion:4;=;alBU_Mantencion{$line})
SELECTION TO ARRAY:C260([BU_Buses_Documentos:38]Numero:1;alBU_NumDoc;[BU_Buses_Documentos:38]Numero_Mantencion:4;alBU_NumMant;[BU_Buses_Documentos:38]Fecha:2;adBU_FechaDoc;[BU_Buses_Documentos:38]Descripcion:3;atBU_Descrip;[BU_Buses_Documentos:38]Patente_Bus:5;atBU_PatBus;[BU_Buses_Documentos:38]ID:6;alBU_DocID)
