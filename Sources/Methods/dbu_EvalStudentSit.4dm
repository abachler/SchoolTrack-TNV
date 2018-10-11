//%attributes = {}
  //dbu_EvalStudentSit`

BRING TO FRONT:C326(Current process:C322)
EVS_LoadStyles 
PERIODOS_Init 
$NoBatchProcessor:=<>NoBatchProcessor
<>NoBatchProcessor:=True:C214
READ ONLY:C145([Asignaturas:18])

READ ONLY:C145([xxSTR_Niveles:6])
READ ONLY:C145([xxSTR_EstilosEvaluacion:44])
QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;<>al_NumeroNivelesActivos)
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNums)
BLOB_Variables2Blob (->$xRecNums;0;->$aRecNums)

AL_RecalcFinalSituation ($xRecNums)

