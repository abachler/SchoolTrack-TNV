Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		
		C_LONGINT:C283(hl_AñosNiveles;hl_EstilosEvaluacion;hl_EstilosActuales;hl_EstilosHistoricos;hl_EstilosEvaluacionInt;vl_SelectedYear)
		hl_AñosNiveles:=New list:C375
		
		READ ONLY:C145([xxSTR_DatosDeCierre:24])
		ALL RECORDS:C47([xxSTR_DatosDeCierre:24])
		SELECTION TO ARRAY:C260([xxSTR_DatosDeCierre:24]Year:1;$al_YearNumbers;[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5;$at_yearNames)
		
		READ ONLY:C145([xxSTR_HistoricoEstilosEval:88])
		READ ONLY:C145([xxSTR_HistoricoNiveles:191])
		QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]NumeroNivel:3;=;[xxSTR_Niveles:6]NoNivel:5;*)
		QUERY:C277([xxSTR_HistoricoNiveles:191]; & [xxSTR_HistoricoNiveles:191]ID_Institucion:1;=;<>gInstitucion)
		ORDER BY:C49([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]Año:2;<)
		ARRAY LONGINT:C221($aRecNums;0)
		LONGINT ARRAY FROM SELECTION:C647([xxSTR_HistoricoNiveles:191];$aRecNums;"")
		For ($i;1;Size of array:C274($aRecNums))
			GOTO RECORD:C242([xxSTR_HistoricoNiveles:191];$aRecNums{$i})
			$el:=Find in array:C230($al_YearNumbers;[xxSTR_HistoricoNiveles:191]Año:2)
			If ($el>0)
				$yearName:=$at_yearNames{$el}
			Else 
				CREATE RECORD:C68([xxSTR_DatosDeCierre:24])
				[xxSTR_DatosDeCierre:24]Year:1:=[xxSTR_HistoricoNiveles:191]Año:2
				[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5:=String:C10([xxSTR_HistoricoNiveles:191]Año:2)
				SAVE RECORD:C53([xxSTR_DatosDeCierre:24])
				$yearName:=[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5
			End if 
			APPEND TO LIST:C376(hl_AñosNiveles;$yearName;$aRecNums{$i})
		End for 
		
		
		If (Count list items:C380(hl_AñosNiveles)>0)
			If (vl_SelectedYear>0)
				$position:=HL_FindElement (hl_AñosNiveles;String:C10(vl_SelectedYear))
				SELECT LIST ITEMS BY POSITION:C381(hl_AñosNiveles;$position)
				GET LIST ITEM:C378(hl_AñosNiveles;Selected list items:C379(hl_AñosNiveles);$recNum;$nombreAño)
			Else 
				SELECT LIST ITEMS BY POSITION:C381(hl_AñosNiveles;1)
				GET LIST ITEM:C378(hl_AñosNiveles;Selected list items:C379(hl_AñosNiveles);$recNum;$nombreAño)
				KRL_GotoRecord (->[xxSTR_HistoricoNiveles:191];$recNum)
				vl_SelectedYear:=[xxSTR_HistoricoNiveles:191]Año:2
			End if 
			HL_ClearList (hl_EstilosEvaluacion;hl_EstilosActuales;hl_EstilosHistoricos)
			GET LIST ITEM:C378(hl_AñosNiveles;Selected list items:C379(hl_AñosNiveles);$recNum;$nombreAño)
			
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
			
			hl_EstilosEvaluacionInt:=Copy list:C626(hl_EstilosEvaluacion)  //MONO TICKET
			
			vt_text1:=KRL_GetTextFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9;->[xxSTR_HistoricoEstilosEval:88]NombreEstilo:5)
			vt_text2:=KRL_GetTextFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8;->[xxSTR_HistoricoEstilosEval:88]NombreEstilo:5)
		Else 
			OBJECT SET VISIBLE:C603(*;"hl_estilosEvaluacion@";False:C215)
			OBJECT SET VISIBLE:C603(*;"Texto2";False:C215)
			OBJECT SET ENTERABLE:C238(*;"editables@";False:C215)
			OBJECT SET VISIBLE:C603(*;"seccion@";False:C215)
		End if 
		
		SET LIST PROPERTIES:C387(hl_AñosNiveles;1;0;20)
		
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		If (Count list items:C380(hl_AñosNiveles)=0)
			_O_DISABLE BUTTON:C193(bDelAño)
		Else 
			If (Selected list items:C379(hl_AñosNiveles)=0)
				_O_DISABLE BUTTON:C193(bDelAño)
			Else 
				_O_ENABLE BUTTON:C192(bDelAño)
			End if 
		End if 
		
		
	: (Form event:C388=On Close Box:K2:21)
		If ((USR_IsGroupMember_by_GrpID (-15001;USR_GetUserID )) & (KRL_RegistroFueModificado (->[xxSTR_HistoricoNiveles:191])))
			SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
		End if 
		CANCEL:C270
		
		
	: (Form event:C388=On Unload:K2:2)
		HL_ClearList (hl_AñosNiveles;hl_EstilosEvaluacion;hl_EstilosEvaluacionInt;hl_EstilosActuales;hl_EstilosHistoricos)
		PERIODOS_Init 
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case   //
