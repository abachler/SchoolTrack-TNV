If ((USR_IsGroupMember_by_GrpID (-15001;USR_GetUserID )) & (KRL_RegistroFueModificado (->[xxSTR_HistoricoNiveles:191])))
	SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
End if 
HL_ClearList (hl_EstilosEvaluacion;hl_EstilosActuales;hl_EstilosHistoricos)

If (Selected list items:C379(hl_AñosNiveles)>0)
	GET LIST ITEM:C378(hl_AñosNiveles;Selected list items:C379(hl_AñosNiveles);$recNum;$nombreAño)
	
	If ($recNum>=0)
		If (USR_IsGroupMember_by_GrpID (-15001;USR_GetUserID ))
			KRL_GotoRecord (->[xxSTR_HistoricoNiveles:191];$recNum)
			PERIODOS_Init 
			PERIODOS_LeeDatosHistoricos ([xxSTR_HistoricoNiveles:191]NumeroNivel:3;[xxSTR_HistoricoNiveles:191]Año:2)
			KRL_GotoRecord (->[xxSTR_HistoricoNiveles:191];$recNum;True:C214)
			If (([xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16=0) | (BLOB size:C605([xxSTR_HistoricoNiveles:191]xConfiguracionPeriodos:7)>32))
				[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16:=viSTR_Periodos_NumeroPeriodos
				[xxSTR_HistoricoNiveles:191]InicioAgnoEscolar:17:=vdSTR_Periodos_InicioEjercicio
				[xxSTR_HistoricoNiveles:191]TerminoAgnoEscolar:18:=vdSTR_Periodos_FinEjercicio
				SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
			Else 
				KRL_GotoRecord (->[xxSTR_HistoricoNiveles:191];$recNum;True:C214)
			End if 
			OBJECT SET VISIBLE:C603(*;"hl_estilosEvaluacion@";True:C214)
			OBJECT SET VISIBLE:C603(*;"Texto2";True:C214)
			OBJECT SET ENTERABLE:C238(*;"editables@";True:C214)
			OBJECT SET VISIBLE:C603(*;"seccion@";True:C214)
			OBJECT SET ENTERABLE:C238(*;"editablesPeriodo@";True:C214)
			
		Else 
			KRL_GotoRecord (->[xxSTR_HistoricoNiveles:191];$recNum)
			PERIODOS_Init 
			PERIODOS_LeeDatosHistoricos ([xxSTR_HistoricoNiveles:191]NumeroNivel:3;[xxSTR_HistoricoNiveles:191]Año:2)
			KRL_GotoRecord (->[xxSTR_HistoricoNiveles:191];$recNum;True:C214)
			If (([xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16=0) | (BLOB size:C605([xxSTR_HistoricoNiveles:191]xConfiguracionPeriodos:7)>32))
				[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16:=viSTR_Periodos_NumeroPeriodos
				[xxSTR_HistoricoNiveles:191]InicioAgnoEscolar:17:=vdSTR_Periodos_InicioEjercicio
				[xxSTR_HistoricoNiveles:191]TerminoAgnoEscolar:18:=vdSTR_Periodos_FinEjercicio
				SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
			End if 
			KRL_GotoRecord (->[xxSTR_HistoricoNiveles:191];$recNum;False:C215)
			OBJECT SET VISIBLE:C603(*;"hl_estilosEvaluacion@";False:C215)
			OBJECT SET VISIBLE:C603(*;"Texto2";False:C215)
			OBJECT SET ENTERABLE:C238(*;"editables@";False:C215)
			OBJECT SET VISIBLE:C603(*;"seccion@";False:C215)
			OBJECT SET ENTERABLE:C238(*;"editablesPeriodo@";False:C215)
		End if 
		
		
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
		
		vt_text1:=KRL_GetTextFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9;->[xxSTR_HistoricoEstilosEval:88]NombreEstilo:5)
		vt_text2:=KRL_GetTextFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8;->[xxSTR_HistoricoEstilosEval:88]NombreEstilo:5)
		
		
	Else 
		OBJECT SET VISIBLE:C603(*;"hl_estilosEvaluacion@";False:C215)
		OBJECT SET VISIBLE:C603(*;"Texto2";False:C215)
		OBJECT SET ENTERABLE:C238(*;"editables@";False:C215)
		OBJECT SET VISIBLE:C603(*;"seccion@";False:C215)
	End if 
	
Else 
	REDUCE SELECTION:C351([xxSTR_HistoricoNiveles:191];0)
	OBJECT SET VISIBLE:C603(*;"hl_estilosEvaluacion@";False:C215)
	OBJECT SET VISIBLE:C603(*;"Texto2";False:C215)
	OBJECT SET ENTERABLE:C238(*;"editables@";False:C215)
	OBJECT SET VISIBLE:C603(*;"seccion@";False:C215)
End if 