C_LONGINT:C283($idEstilo)
C_TEXT:C284($nombreEstilo)



$selected:=Selected list items:C379(Self:C308->)
If ($selected>0)
	$nombreAñoEscolar:=KRL_GetTextFieldData (->[xxSTR_DatosDeCierre:24]Year:1;->vl_Year_Historico;->[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5)
	
	
	GET LIST ITEM:C378(Self:C308->;$selected;$idEstilo;$nombreEstilo)
	$parentItem:=List item parent:C633(Self:C308->;$idEstilo)
	
	
	Case of 
		: ($parentItem=-1)
			GET LIST ITEM:C378(Self:C308->;$selected;$idEstilo;$nombreEstilo)
			[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25:=$idEstilo
			
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
			[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25:=[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3
			UNLOAD RECORD:C212([xxSTR_HistoricoEstilosEval:88])
			
			QUERY:C277([xxSTR_HistoricoEstilosEval:88];[xxSTR_HistoricoEstilosEval:88]Año:2=[Alumnos_SintesisAnual:210]Año:2)
			hl_EstilosHistoricos:=New list:C375
			hl_EstilosHistoricos:=HL_Selection2List (->[xxSTR_HistoricoEstilosEval:88]NombreEstilo:5;->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3)
			
			ALL RECORDS:C47([xxSTR_EstilosEvaluacion:44])
			hl_EstilosActuales:=New list:C375
			hl_EstilosActuales:=HL_Selection2List (->[xxSTR_EstilosEvaluacion:44]Name:2;->[xxSTR_EstilosEvaluacion:44]ID:1)
			
			hl_EstilosEvaluacion:=New list:C375
			APPEND TO LIST:C376(hl_EstilosEvaluacion;"Estilos almacenados en el año "+$nombreAñoEscolar;-1;hl_EstilosHistoricos;True:C214)
			APPEND TO LIST:C376(hl_EstilosEvaluacion;"Estilos vigentes en el año actual";-2;hl_EstilosActuales;True:C214)
			
			
	End case 
	
	vt_text2:=KRL_GetTextFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25;->[xxSTR_HistoricoEstilosEval:88]NombreEstilo:5)
	EVS_LeeEstiloEvalHist_byID ([Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25)
	
	LOG_RegisterEvt ("Cambio de estilo de evaluación interno en registro histórico de calificacione, ID"+" Asignatura: "+String:C10([Asignaturas_Historico:84]ID_RegistroHistorico:1)+" para el año "+$nombreAñoEscolar)
	
	CD_Dlog (0;__ ("El cambio de estilo de evaluación no tendrá ninhgún efecto mientras no se editen las calificaciones."))
	
End if 