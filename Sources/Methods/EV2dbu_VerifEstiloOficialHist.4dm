//%attributes = {}
  //Método: EV2dbu_VerifEstiloOficialHist


IN_LoadEvaluationStyles 

Case of 
	: (<>vtXS_CountryCode="cl")
		QUERY:C277([xxSTR_EstilosEvaluacion:44];[xxSTR_EstilosEvaluacion:44]ID:1;=;-5)
		$blobOficial:=[xxSTR_EstilosEvaluacion:44]OT_Data:7
End case 

$reasignarEstilo:=False:C215
ALL RECORDS:C47([xxSTR_HistoricoNiveles:191])
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([xxSTR_HistoricoNiveles:191];$aRecNums;"")

For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([xxSTR_HistoricoNiveles:191])
	GOTO RECORD:C242([xxSTR_HistoricoNiveles:191];$aRecNums{$i})
	$recNum:=KRL_FindAndLoadRecordByIndex (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9)
	If ($recNum>=0)
		$blob:=KRL_GetBlobFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9;->[xxSTR_HistoricoEstilosEval:88]xData:6)
		If (BLOB size:C605($blob)=0)
			$reasignarEstilo:=True:C214
			KRL_DeleteRecord (->[xxSTR_HistoricoEstilosEval:88])
		End if 
	Else 
		$reasignarEstilo:=True:C214
	End if 
	
	
	If ($reasignarEstilo)
		Case of 
			: (<>vtXS_CountryCode="cl")
				CREATE RECORD:C68([xxSTR_HistoricoEstilosEval:88])
				[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3:=SQ_SeqNumber (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3)
				[xxSTR_HistoricoEstilosEval:88]ID_EstiloOriginal:4:=[xxSTR_EstilosEvaluacion:44]ID:1
				[xxSTR_HistoricoEstilosEval:88]Año:2:=[xxSTR_HistoricoNiveles:191]Año:2
				[xxSTR_HistoricoEstilosEval:88]NombreEstilo:5:=[xxSTR_EstilosEvaluacion:44]Name:2
				[xxSTR_HistoricoEstilosEval:88]xData:6:=$blobOficial
				SAVE RECORD:C53([xxSTR_HistoricoEstilosEval:88])
				[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9:=[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3
				SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
		End case 
	End if 
	
End for 
UNLOAD RECORD:C212([xxSTR_HistoricoNiveles:191])
UNLOAD RECORD:C212([xxSTR_HistoricoEstilosEval:88])