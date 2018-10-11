//%attributes = {}
  //EVS_LoadStyles

EVS_initialize 

ARRAY TEXT:C222(aEvStyleName;0)
ARRAY LONGINT:C221(aEvStyleRecNo;0)
ARRAY LONGINT:C221(aEvStyleId;0)

READ ONLY:C145([xxSTR_EstilosEvaluacion:44])
ALL RECORDS:C47([xxSTR_EstilosEvaluacion:44])
SELECTION TO ARRAY:C260([xxSTR_EstilosEvaluacion:44];aEvStyleRecNo;[xxSTR_EstilosEvaluacion:44]ID:1;aEvStyleId;[xxSTR_EstilosEvaluacion:44]Name:2;aEvStyleName)

SORT ARRAY:C229(aEvStyleId;aEvStyleName;aEvStyleRecNo;>)

UNLOAD RECORD:C212([xxSTR_EstilosEvaluacion:44])
READ ONLY:C145([xxSTR_EstilosEvaluacion:44])

