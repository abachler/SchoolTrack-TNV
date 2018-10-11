$selected:=Selected list items:C379(Self:C308->)
If ($selected>0)
	GET LIST ITEM:C378(hl_AñosNiveles;Selected list items:C379(hl_AñosNiveles);$recNum;$nombreAño)
	
	GET LIST ITEM:C378(Self:C308->;$selected;$idEstilo;$nombreEstilo)
	$parentItem:=List item parent:C633(Self:C308->;$idEstilo)
	
	
	Case of 
		: ($parentItem=-1)
			GET LIST ITEM:C378(Self:C308->;$selected;$idEstilo;$nombreEstilo)
			[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8:=$idEstilo
			
		: ($parentItem=-2)
			KRL_FindAndLoadRecordByIndex (->[xxSTR_EstilosEvaluacion:44]ID:1;->$idEstilo)
			QUERY:C277([xxSTR_HistoricoEstilosEval:88];[xxSTR_HistoricoEstilosEval:88]ID_EstiloOriginal:4=[xxSTR_EstilosEvaluacion:44]ID:1;*)
			QUERY:C277([xxSTR_HistoricoEstilosEval:88]; & ;[xxSTR_HistoricoEstilosEval:88]Año:2=[xxSTR_HistoricoNiveles:191]Año:2)
			If (Records in selection:C76([xxSTR_HistoricoEstilosEval:88])=0)
				CREATE RECORD:C68([xxSTR_HistoricoEstilosEval:88])
				[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3:=SQ_SeqNumber (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3)
				[xxSTR_HistoricoEstilosEval:88]ID_EstiloOriginal:4:=[xxSTR_EstilosEvaluacion:44]ID:1
				[xxSTR_HistoricoEstilosEval:88]Año:2:=[xxSTR_HistoricoNiveles:191]Año:2
				[xxSTR_HistoricoEstilosEval:88]NombreEstilo:5:=[xxSTR_EstilosEvaluacion:44]Name:2
				[xxSTR_HistoricoEstilosEval:88]xData:6:=[xxSTR_EstilosEvaluacion:44]OT_Data:7
				SAVE RECORD:C53([xxSTR_HistoricoEstilosEval:88])
			End if 
			[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8:=[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3
			SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
			UNLOAD RECORD:C212([xxSTR_HistoricoEstilosEval:88])
			
			
			QUERY:C277([xxSTR_HistoricoEstilosEval:88];[xxSTR_HistoricoEstilosEval:88]Año:2=[xxSTR_HistoricoNiveles:191]Año:2)
			hl_EstilosHistoricos:=New list:C375
			hl_EstilosHistoricos:=HL_Selection2List (->[xxSTR_HistoricoEstilosEval:88]NombreEstilo:5;->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3)
			
			ALL RECORDS:C47([xxSTR_EstilosEvaluacion:44])
			hl_EstilosActuales:=New list:C375
			hl_EstilosActuales:=HL_Selection2List (->[xxSTR_EstilosEvaluacion:44]Name:2;->[xxSTR_EstilosEvaluacion:44]ID:1)
			
			hl_EstilosEvaluacion:=New list:C375
			APPEND TO LIST:C376(hl_EstilosEvaluacion;"Estilos almacenados en el año "+$nombreAño;-1;hl_EstilosHistoricos;True:C214)
			APPEND TO LIST:C376(hl_EstilosEvaluacion;"Estilos vigentes en el año actual";-2;hl_EstilosActuales;True:C214)
			
			hl_EstilosEvaluacionInt:=Copy list:C626(hl_EstilosEvaluacion)
			
	End case 
	
	vt_text1:=KRL_GetTextFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9;->[xxSTR_HistoricoEstilosEval:88]NombreEstilo:5)
	vt_text2:=KRL_GetTextFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8;->[xxSTR_HistoricoEstilosEval:88]NombreEstilo:5)
	
	LOG_RegisterEvt ("Cambio de estilo de evaluación interno en registro histórico del nivel "+[xxSTR_HistoricoNiveles:191]NombreInterno:5+" para el año "+String:C10([xxSTR_HistoricoNiveles:191]Año:2))
	
End if 