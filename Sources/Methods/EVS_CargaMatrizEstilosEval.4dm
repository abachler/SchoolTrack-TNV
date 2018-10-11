//%attributes = {}
  //EVS_CargaMatrizEstilosEval

EVS_initialize 

ARRAY LONGINT:C221(<>alEVS_Ids;0)
ALL RECORDS:C47([xxSTR_EstilosEvaluacion:44])
SELECTION TO ARRAY:C260([xxSTR_EstilosEvaluacion:44];$aRecNums;[xxSTR_EstilosEvaluacion:44]ID:1;<>alEVS_Ids)

ARRAY LONGINT:C221(<>alEVS_EvaluationMode;Size of array:C274($aRecNums))
ARRAY LONGINT:C221(<>alEVS_PrintMode;Size of array:C274($aRecNums))
ARRAY LONGINT:C221(<>alEVS_PrintActa;Size of array:C274($aRecNums))

ARRAY LONGINT:C221(<>alEVS_iGradesDecPP;Size of array:C274($aRecNums))
ARRAY LONGINT:C221(<>alEVS_iGradesDecPF;Size of array:C274($aRecNums))
ARRAY LONGINT:C221(<>alEVS_iGradesDecNF;Size of array:C274($aRecNums))
ARRAY LONGINT:C221(<>alEVS_iGradesDecNO;Size of array:C274($aRecNums))
ARRAY REAL:C219(<>arEVS_rGradesFrom;Size of array:C274($aRecNums))

ARRAY LONGINT:C221(<>alEVS_iPointsDecPP;Size of array:C274($aRecNums))
ARRAY LONGINT:C221(<>alEVS_iPointsDecPF;Size of array:C274($aRecNums))
ARRAY LONGINT:C221(<>alEVS_iPointsDecNF;Size of array:C274($aRecNums))
ARRAY LONGINT:C221(<>alEVS_iPointsDecNO;Size of array:C274($aRecNums))
ARRAY REAL:C219(<>arEVS_rPointsFrom;Size of array:C274($aRecNums))

ARRAY REAL:C219(<>arEVS_MinimoEscalaReferencia;Size of array:C274($aRecNums))

For ($i;1;Size of array:C274($aRecNums))
	EVS_ReadStyleData (<>alEVS_Ids{$i})
	<>alEVS_EvaluationMode{$i}:=iEvaluationMode
	<>alEVS_PrintMode{$i}:=iPrintMode
	<>alEVS_PrintActa{$i}:=iPrintActa
	<>alEVS_iGradesDecPP{$i}:=iGradesDecPP
	<>alEVS_iGradesDecPF{$i}:=iGradesDecPF
	<>alEVS_iGradesDecNF{$i}:=iGradesDecNF
	<>alEVS_iGradesDecNO{$i}:=iGradesDecNO
	<>arEVS_rGradesFrom{$i}:=rGradesFrom
	
	<>alEVS_iPointsDecPP{$i}:=iPointsDecPP
	<>alEVS_iPointsDecPF{$i}:=iPointsDecPF
	<>alEVS_iPointsDecNF{$i}:=iPointsDecNF
	<>alEVS_iPointsDecNO{$i}:=iPointsDecNO
	<>arEVS_rPointsFrom{$i}:=rPointsFrom
	
	<>arEVS_MinimoEscalaReferencia{$i}:=vrNTA_MinimoEscalaReferencia
End for 

vlEVS_CurrentEvStyleID:=0
