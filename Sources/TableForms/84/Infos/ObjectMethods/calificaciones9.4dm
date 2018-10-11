  //ALh_EdicionNotasHistoricas (Self)

Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vl_EstiloHistoricoEnMemoria:=0
		KRL_FindAndLoadRecordByIndex (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_SintesisAnual:210]NumeroNivel:6)
		$key:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6)+"."+String:C10([Alumnos_SintesisAnual:210]Año:2)
		$recNum:=KRL_FindAndLoadRecordByIndex (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$key)
		If (($recNum<0) | ([xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9=0))
			$r:=CD_Dlog (0;__ ("No se han definido las propiedades del registro histórico para el nivel ")+[xxSTR_Niveles:6]Nivel:1+__ (" en el año ")+String:C10([Alumnos_SintesisAnual:210]Año:2)+__ ("\r\r¿Desea hacerlo ahora?");__ ("");__ ("Si");__ ("No"))
			If ($r=1)
				vl_SelectedYear:=[Alumnos_SintesisAnual:210]Año:2
				QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]NumeroNivel:3;=;[Alumnos_SintesisAnual:210]NumeroNivel:6;*)
				QUERY:C277([xxSTR_HistoricoNiveles:191]; & [xxSTR_HistoricoNiveles:191]ID_Institucion:1;=;<>gInstitucion)
				ORDER BY:C49([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]Año:2;<)
				WDW_OpenFormWindow (->[xxSTR_HistoricoNiveles:191];"Propiedades";-5;8;__ ("Años anteriores: ")+[xxSTR_Niveles:6]Nivel:1)
				KRL_ModifyRecord (->[xxSTR_HistoricoNiveles:191];"Propiedades")
				CLOSE WINDOW:C154
				$recNum:=KRL_FindAndLoadRecordByIndex (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$key)
			End if 
			If ([xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9>0)
				
			Else 
				$r:=CD_Dlog (0;__ ("No es posible editar la nota oficial mientras no defina el estilo de evaluación oficial del nivel o grado académico."))
				GOTO OBJECT:C206([Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46)
			End if 
		End if 
		
		$recNumEstilo:=KRL_FindAndLoadRecordByIndex (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9)
		If ($recNumEstilo>=0)
			
		Else 
			$r:=CD_Dlog (0;__ ("No se encontró el estilo de evaluación definido en las propiedades del registro histórico para el nivel ")+[xxSTR_Niveles:6]Nivel:1+__ (" en el año ")+String:C10([Alumnos_SintesisAnual:210]Año:2)+__ ("\r\r¿Desea corregir esta situación ahora?");__ ("");__ ("Si");__ ("No"))
			If ($r=1)
				vl_SelectedYear:=[Alumnos_SintesisAnual:210]Año:2
				QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]NumeroNivel:3;=;[Alumnos_SintesisAnual:210]NumeroNivel:6;*)
				QUERY:C277([xxSTR_HistoricoNiveles:191]; & [xxSTR_HistoricoNiveles:191]ID_Institucion:1;=;<>gInstitucion)
				ORDER BY:C49([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]Año:2;<)
				WDW_OpenFormWindow (->[xxSTR_HistoricoNiveles:191];"Propiedades";-5;8;__ ("Años anteriores: ")+[xxSTR_Niveles:6]Nivel:1)
				KRL_ModifyRecord (->[xxSTR_HistoricoNiveles:191];"Propiedades")
				CLOSE WINDOW:C154
				$recNum:=KRL_FindAndLoadRecordByIndex (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$key)
			End if 
			$recNumEstilo:=KRL_FindAndLoadRecordByIndex (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9)
			If ($recNumEstilo<0)
				$r:=CD_Dlog (0;__ ("No es posible editar la nota oficial mientras no defina el estilo de evaluación oficial del nivel o grado académico."))
				GOTO OBJECT:C206([Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46)
			End if 
		End if 
		
	: (Form event:C388=On Data Change:K2:15)
		EVS_LeeEstiloEvalHist_byID ([Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25)
		
		If ((Self:C308->#"X") & (Self:C308->#"EX"))
			$notaReal:=EV2_ValidaIngreso (Self:C308->)
			$iPrintActa:=iPrintActa
			
			If (iEvaluationMode>0)
				$fieldName:="[Alumnos_Calificaciones]"+Field name:C257(Self:C308)
				$realPointer:=KRL_GetFieldPointerByName (Replace string:C233($fieldName;"_literal";"_Real"))
				$notaPointer:=KRL_GetFieldPointerByName (Replace string:C233($fieldName;"_literal";"_Nota"))
				$puntosPointer:=KRL_GetFieldPointerByName (Replace string:C233($fieldName;"_literal";"_Puntos"))
				$simboloPointer:=KRL_GetFieldPointerByName (Replace string:C233($fieldName;"_literal";"_Simbolo"))
				
				$realPointer->:=$notaReal
				If ($realPointer->>=vrNTA_MinimoEscalaReferencia)
					$notaPointer->:=EV2_Real_a_Nota ($realPointer->;0;iGradesDecNO)
					$puntosPointer->:=EV2_Real_a_Puntos ($realPointer->;0;iPointsDecNO)
					$simboloPointer->:=EV2_Real_a_Simbolo ($realPointer->)
					Self:C308->:=EV2_Real_a_Literal ($realPointer->;iEvaluationMode;iGradesDecNO)
				Else 
					  //20111103 AS. Agrego else.
					Self:C308->:=""
					$notaPointer->:=-10
					$puntosPointer->:=-10
					$simboloPointer->:=""
				End if 
			End if 
		Else 
			[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36:=Uppercase:C13([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36)
			$realPointer->:=-3
			$notaPointer->:=-3
			$puntosPointer->:=-3
			$simboloPointer->:=""
		End if 
		
		
		[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492:=NTA_Grade2LongText ([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36)
		
		
		[Alumnos_ComplementoEvaluacion:209]Historico_HistorialCambios:88:=String:C10(Year of:C25(Current date:C33(*));"0000")+" "+String:C10(Month of:C24(Current date:C33(*));"00")+" "+String:C10(Day of:C23(Current date:C33(*));"00")+" - "+<>tUSR_CurrentUser+" - "+API Get Virtual Field Name (Table:C252(Self:C308);Field:C253(Self:C308))+": "+Old:C35(Self:C308->)+" -> "+Self:C308->+"\r"+[Alumnos_ComplementoEvaluacion:209]Historico_HistorialCambios:88
		LOG_RegisterEvt ("Modificación en el campo "+API Get Virtual Field Name (Table:C252(Self:C308);Field:C253(Self:C308))+", del registro histórico del alumno "+[Alumnos:2]apellidos_y_nombres:40+".")
		
		SAVE RECORD:C53([Alumnos_Calificaciones:208])
		SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
		vl_EstiloHistoricoEnMemoria:=0
		
		If ((iGradesDecNO>0) & (Dec:C9([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33)=0))
			C_TEXT:C284($vt_format;$vt_format1)
			$vt_format1:=""
			For ($i;1;iGradesDecNO)
				If ($i=1)
					$vt_format1:=$vt_format1+"0"
				Else 
					$vt_format1:=$vt_format1+"#"
				End if 
			End for 
			$vt_format:="##0"+<>tXS_RS_DecimalSeparator+$vt_format1
			OBJECT SET FORMAT:C236(*;"notasHistoricas(7)47";$vt_format)
		End if 
		AL_ShowHideObjectHistoricos 
End case 