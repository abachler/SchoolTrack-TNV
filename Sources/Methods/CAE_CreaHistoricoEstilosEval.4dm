//%attributes = {}
  //CAE_CreaHistoricoEstilosEval

ALL RECORDS:C47([xxSTR_EstilosEvaluacion:44])
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([xxSTR_EstilosEvaluacion:44];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([xxSTR_EstilosEvaluacion:44])
	GOTO RECORD:C242([xxSTR_EstilosEvaluacion:44];$aRecNums{$i})
	QUERY:C277([xxSTR_HistoricoEstilosEval:88];[xxSTR_HistoricoEstilosEval:88]ID_EstiloOriginal:4=[xxSTR_EstilosEvaluacion:44]ID:1;*)
	QUERY:C277([xxSTR_HistoricoEstilosEval:88]; & ;[xxSTR_HistoricoEstilosEval:88]Año:2=vl_UltimoAño)
	If (Records in selection:C76([xxSTR_HistoricoEstilosEval:88])=0)
		CREATE RECORD:C68([xxSTR_HistoricoEstilosEval:88])
		[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3:=SQ_SeqNumber (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3)
		[xxSTR_HistoricoEstilosEval:88]ID_EstiloOriginal:4:=[xxSTR_EstilosEvaluacion:44]ID:1
		[xxSTR_HistoricoEstilosEval:88]Año:2:=vl_UltimoAño
		[xxSTR_HistoricoEstilosEval:88]NombreEstilo:5:=[xxSTR_EstilosEvaluacion:44]Name:2
		[xxSTR_HistoricoEstilosEval:88]xData:6:=[xxSTR_EstilosEvaluacion:44]OT_Data:7
		SAVE RECORD:C53([xxSTR_HistoricoEstilosEval:88])
	End if 
End for 
