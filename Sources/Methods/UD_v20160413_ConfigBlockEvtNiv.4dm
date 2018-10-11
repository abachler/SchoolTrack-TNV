//%attributes = {}
  //157382
  //UD_v20160413_ConfigBlockEvtNiv
C_LONGINT:C283($i;$l_idTermometro)
ARRAY LONGINT:C221($al_rnNiveles;0)

$l_idTermometro:=IT_Progress (1;0;0;"Configuración de bloqueo de eventos por calendario ...")

READ ONLY:C145([xxSTR_Niveles:6])
ALL RECORDS:C47([xxSTR_Niveles:6])
LONGINT ARRAY FROM SELECTION:C647([xxSTR_Niveles:6];$al_rnNiveles;"")

ARRAY TEXT:C222(at_EvtCalTipo;0)
ARRAY LONGINT:C221(al_EvtCalMaxDay;0)
ARRAY LONGINT:C221(al_EvtCalMaxWeek;0)
COPY ARRAY:C226(<>at_EventosAsignatura;at_EvtCalTipo)
ARRAY LONGINT:C221(al_EvtCalMaxDay;Size of array:C274(at_EvtCalTipo))
ARRAY LONGINT:C221(al_EvtCalMaxWeek;Size of array:C274(at_EvtCalTipo))

For ($i;1;Size of array:C274($al_rnNiveles))
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($al_rnNiveles))
	READ WRITE:C146([xxSTR_Niveles:6])
	GOTO RECORD:C242([xxSTR_Niveles:6];$al_rnNiveles{$i})
	BLOB_Variables2Blob (->[xxSTR_Niveles:6]xEventoCalendario:53;0;->at_EvtCalTipo;->al_EvtCalMaxDay;->al_EvtCalMaxWeek)
	SAVE RECORD:C53([xxSTR_Niveles:6])
	KRL_UnloadReadOnly (->[xxSTR_Niveles:6])
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro)