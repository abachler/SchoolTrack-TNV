Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		If (<>vtXS_CountryCode#"cl")
			OBJECT SET TITLE:C194(*;"calificaciones_enActas";__ ("Asignatura Oficial"))
		Else 
			OBJECT SET VISIBLE:C603(*;"AprobacionDiferida@";False:C215)
		End if 
		
		
		vLabelP1:=""
		vLabelP2:=""
		vLabelP3:=""
		vLabelP4:=""
		vLabelP5:=""
		Case of 
			: (viSTR_Periodos_NumeroPeriodos=2)
				vLabelP1:="1S"
				vLabelP2:="2S"
				OBJECT SET VISIBLE:C603(vLabelP1;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP2;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP3;False:C215)
				OBJECT SET VISIBLE:C603(vLabelP4;False:C215)
				OBJECT SET VISIBLE:C603(vLabelP5;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Literal:116;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Literal:191;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Literal:266;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Literal:341;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Literal:416;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Real:112;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Real:187;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Real:262;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Real:337;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Real:412;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Nota:113;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Nota:188;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Nota:263;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Nota:338;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Nota:413;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Simbolo:115;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Simbolo:190;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Simbolo:265;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Simbolo:340;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Simbolo:415;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Puntos:114;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Puntos:189;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Puntos:264;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Puntos:339;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Puntos:414;False:C215)
				
			: (viSTR_Periodos_NumeroPeriodos=3)
				vLabelP1:="1T"
				vLabelP2:="2T"
				vLabelP3:="3T"
				OBJECT SET VISIBLE:C603(vLabelP1;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP2;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP3;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP4;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Literal:116;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Literal:191;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Literal:266;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Literal:341;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Literal:416;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Real:112;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Real:187;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Real:262;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Real:337;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Real:412;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Nota:113;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Nota:188;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Nota:263;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Nota:338;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Nota:413;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Simbolo:115;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Simbolo:190;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Simbolo:265;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Simbolo:340;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Simbolo:415;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Puntos:114;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Puntos:189;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Puntos:264;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Puntos:339;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Puntos:414;False:C215)
				
			: (viSTR_Periodos_NumeroPeriodos=4)
				vLabelP1:="1B"
				vLabelP2:="2B"
				vLabelP3:="3B"
				vLabelP4:="4B"
				OBJECT SET VISIBLE:C603(vLabelP1;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP2;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP3;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP4;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Literal:116;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Literal:191;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Literal:266;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Literal:341;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Literal:416;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Real:112;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Real:187;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Real:262;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Real:337;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Real:412;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Nota:113;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Nota:188;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Nota:263;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Nota:338;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Nota:413;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Simbolo:115;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Simbolo:190;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Simbolo:265;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Simbolo:340;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Simbolo:415;False:C215)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Puntos:114;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Puntos:189;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Puntos:264;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Puntos:339;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Puntos:414;False:C215)
				
			: (viSTR_Periodos_NumeroPeriodos=5)
				vLabelP1:="1B"
				vLabelP2:="2B"
				vLabelP3:="3B"
				vLabelP4:="4B"
				vLabelP5:="5B"
				OBJECT SET VISIBLE:C603(vLabelP1;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP2;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP3;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP4;True:C214)
				OBJECT SET VISIBLE:C603(vLabelP5;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Literal:116;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Literal:191;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Literal:266;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Literal:341;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Literal:416;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Real:112;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Real:187;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Real:262;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Real:337;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Real:412;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Nota:113;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Nota:188;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Nota:263;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Nota:338;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Nota:413;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Simbolo:115;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Simbolo:190;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Simbolo:265;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Simbolo:340;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Simbolo:415;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P01_Final_Puntos:114;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P02_Final_Puntos:189;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P03_Final_Puntos:264;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P04_Final_Puntos:339;True:C214)
				OBJECT SET VISIBLE:C603([Alumnos_Calificaciones:208]P05_Final_Puntos:414;True:C214)
		End case 
		IT_SetButtonState (aNtaRecNum>1;->bFirst;->bPrev)
		IT_SetButtonState (aNtaRecNum<Size of array:C274(aNtaRecNum);->bLast;->bNext)
		
		$formatPercent:="###"+<>tXS_RS_DecimalSeparator+"##; "
		OBJECT SET FORMAT:C236(*;"Porcentajes@";$formatPercent)
		
		Case of 
			: (((<>vtXS_CountryCode="ar") | (<>vtXS_CountryCode="co")) & (([Alumnos_Calificaciones:208]Reprobada:9) | ([Alumnos_ComplementoEvaluacion:209]Historico_Recuperacion_1:52#"") | ([Alumnos_ComplementoEvaluacion:209]Historico_Recuperacion_2:53#"") | ([Alumnos_ComplementoEvaluacion:209]Historico_Recuperacion_3:54#"")))
				OBJECT SET VISIBLE:C603(*;"recuperacion@";True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*;"recuperacion@";False:C215)
		End case 
		
		OBJECT SET ENTERABLE:C238(*;"calificaciones@";Not:C34(Read only state:C362([Alumnos_Calificaciones:208])))
		OBJECT SET ENTERABLE:C238(*;"AprobacionDiferida@";Not:C34(Read only state:C362([Alumnos_ComplementoEvaluacion:209])))
		OBJECT SET ENTERABLE:C238([Alumnos_ComplementoEvaluacion:209]Historico_HistorialCambios:88;False:C215)
		OBJECT SET ENTERABLE:C238(*;"vLabel@";False:C215)
		
		If (Not:C34(Read only state:C362([Alumnos_Calificaciones:208])))
			_O_ENABLE BUTTON:C192(*;"calificaciones@")
			_O_ENABLE BUTTON:C192(bDelete)
			_O_ENABLE BUTTON:C192(hl_EstilosEvaluacion)
		Else 
			_O_DISABLE BUTTON:C193(*;"calificaciones@")
			_O_DISABLE BUTTON:C193(bDelete)
			_O_DISABLE BUTTON:C193(hl_EstilosEvaluacion)
		End if 
		
		$nombreAñoEscolar:=KRL_GetTextFieldData (->[xxSTR_DatosDeCierre:24]Year:1;->vl_Year_Historico;->[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5)
		vt_text2:=""
		QUERY:C277([xxSTR_HistoricoEstilosEval:88];[xxSTR_HistoricoEstilosEval:88]Año:2=[Alumnos_Historico:25]Año:2)
		hl_EstilosHistoricos:=New list:C375
		hl_EstilosHistoricos:=HL_Selection2List (->[xxSTR_HistoricoEstilosEval:88]NombreEstilo:5;->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3)
		
		ALL RECORDS:C47([xxSTR_EstilosEvaluacion:44])
		hl_EstilosActuales:=New list:C375
		hl_EstilosActuales:=HL_Selection2List (->[xxSTR_EstilosEvaluacion:44]Name:2;->[xxSTR_EstilosEvaluacion:44]ID:1)
		
		hl_EstilosEvaluacion:=New list:C375
		APPEND TO LIST:C376(hl_EstilosEvaluacion;"Estilos almacenados en el año "+$nombreAñoEscolar;-1;hl_EstilosHistoricos;True:C214)
		APPEND TO LIST:C376(hl_EstilosEvaluacion;"Estilos vigentes en el año actual";-2;hl_EstilosActuales;True:C214)
		vt_text2:=KRL_GetTextFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25;->[xxSTR_HistoricoEstilosEval:88]NombreEstilo:5)
		If (vt_text2="")
			[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25:=0
			SAVE RECORD:C53([Asignaturas_Historico:84])
		End if 
		
		
		C_BLOB:C604($xEvsHistData)
		$xEvsHistData:=KRL_GetBlobFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25;->[xxSTR_HistoricoEstilosEval:88]xData:6)
		EVS_LeeEstiloEvalHistorico ($xEvsHistData)
		
		
		C_POINTER:C301($vptr)
		C_TEXT:C284($vt_format;$vt_format1)
		
		  //Periodos
		For ($x;1;viSTR_Periodos_NumeroPeriodos)
			$vptr:=Field:C253(208;38+(75*$x))
			
			If ((iGradesDecPP>0) & (Dec:C9($vptr->)=0))
				$vt_format1:=""
				For ($i;1;iGradesDecPP)
					If ($i=1)
						$vt_format1:=$vt_format1+"0"
					Else 
						$vt_format1:=$vt_format1+"#"
					End if 
				End for 
				$vt_format:="##0"+<>tXS_RS_DecimalSeparator+$vt_format1+";;"
				OBJECT SET FORMAT:C236($vptr->;$vt_format)
			End if 
			
		End for 
		
		  //Anual
		If ((iGradesDecPF>0) & (Dec:C9([Alumnos_Calificaciones:208]Anual_Nota:12)=0))
			$vt_format1:=""
			For ($i;1;iGradesDecPF)
				If ($i=1)
					$vt_format1:=$vt_format1+"0"
				Else 
					$vt_format1:=$vt_format1+"#"
				End if 
			End for 
			$vt_format:="##0"+<>tXS_RS_DecimalSeparator+$vt_format1+";;"
			OBJECT SET FORMAT:C236([Alumnos_Calificaciones:208]Anual_Nota:12;$vt_format)
		End if 
		
		  //Examen
		If ((iGradesDec>0) & (Dec:C9([Alumnos_Calificaciones:208]ExamenAnual_Nota:17)=0))
			$vt_format1:=""
			For ($i;1;iGradesDec)
				If ($i=1)
					$vt_format1:=$vt_format1+"0"
				Else 
					$vt_format1:=$vt_format1+"#"
				End if 
			End for 
			$vt_format:="##0"+<>tXS_RS_DecimalSeparator+$vt_format1+";;"
			OBJECT SET FORMAT:C236([Alumnos_Calificaciones:208]ExamenAnual_Nota:17;$vt_format)
		End if 
		
		  //ExamenExtra
		If ((iGradesDec>0) & (Dec:C9([Alumnos_Calificaciones:208]ExamenExtra_Nota:22)=0))
			$vt_format1:=""
			For ($i;1;iGradesDec)
				If ($i=1)
					$vt_format1:=$vt_format1+"0"
				Else 
					$vt_format1:=$vt_format1+"#"
				End if 
			End for 
			$vt_format:="##0"+<>tXS_RS_DecimalSeparator+$vt_format1+";;"
			OBJECT SET FORMAT:C236([Alumnos_Calificaciones:208]ExamenExtra_Nota:22;$vt_format)
		End if 
		
		  //Final
		If ((iGradesDecNF>0) & (Dec:C9([Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27)=0))
			$vt_format1:=""
			For ($i;1;iGradesDecNF)
				If ($i=1)
					$vt_format1:=$vt_format1+"0"
				Else 
					$vt_format1:=$vt_format1+"#"
				End if 
			End for 
			$vt_format:="##0"+<>tXS_RS_DecimalSeparator+$vt_format1+";;"
			OBJECT SET FORMAT:C236([Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;$vt_format)
		End if 
		
		  //Oficial
		If ((iGradesDecNO>0) & (Dec:C9([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33)=0))
			$vt_format1:=""
			For ($i;1;iGradesDecNO)
				If ($i=1)
					$vt_format1:=$vt_format1+"0"
				Else 
					$vt_format1:=$vt_format1+"#"
				End if 
			End for 
			$vt_format:="##0"+<>tXS_RS_DecimalSeparator+$vt_format1+";;"
			OBJECT SET FORMAT:C236([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;$vt_format)
		End if 
		
		
	: (Form event:C388=On Clicked:K2:4)
		REDRAW:C174([Alumnos_ComplementoEvaluacion:209]Historico_HistorialCambios:88)
		If ((bFirst+bPrev+bNext+bLast)=1)
			SAVE RECORD:C53([Asignaturas_Historico:84])
			SAVE RECORD:C53([Alumnos_Calificaciones:208])
			SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
			
			Case of 
				: ((bFirst=1) & (aNtaRecNum>1))
					aNtaRecNum:=1
				: ((bPrev=1) & (aNtaRecNum>1))
					aNtaRecNum:=aNtaRecNum-1
				: ((bNext=1) & (aNtaRecNum<Size of array:C274(aNtaRecNum)))
					aNtaRecNum:=aNtaRecNum+1
				: ((bLast=1) & (aNtaRecNum<Size of array:C274(aNtaRecNum)))
					aNtaRecNum:=Size of array:C274(aNtaRecNum)
			End case 
			
			GOTO RECORD:C242([Alumnos_Calificaciones:208];aNtaRecNum{aNtaRecNum})
			RELATE ONE:C42([Alumnos_Calificaciones:208]Llave_principal:1)
			QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]ID_RegistroHistorico:1=aHId{aNtaRecNum})
			  //20130910 ASM para cargar los complementos de evaluación
			If ([Asignaturas_Historico:84]ID_AsignaturaOriginal:30#0)
				KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1;True:C214)
			Else 
				  //20130910 ASM para cargar los complementos de evaluación cuando la asignatura historico no es original
				KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_RegistroHistorico:87;->[Alumnos_Calificaciones:208]Llave_RegistroHistorico:504;True:C214)
			End if 
			SET WINDOW TITLE:C213(__ ("Info: ")+[Asignaturas_Historico:84]Asignatura:2)
			bFirst:=0
			bPrev:=0
			bNext:=0
			bLast:=0
			
			IT_SetButtonState (aNtaRecNum>1;->bFirst;->bPrev)
			IT_SetButtonState (aNtaRecNum<Size of array:C274(aNtaRecNum);->bLast;->bNext)
			vt_text2:=KRL_GetTextFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->[Asignaturas_Historico:84]ID_EstiloEvalAsignatura:25;->[xxSTR_HistoricoEstilosEval:88]NombreEstilo:5)
		End if 
		
		
		REDRAW WINDOW:C456
	: ((Form event:C388=On Data Change:K2:15))
		
		REDRAW:C174([Asignaturas_Historico:84]Historial_de_Cambios:40)
		
		If ((bFirst+bPrev+bNext+bLast)=1)
			Case of 
				: ((bFirst=1) & (aNtaRecNum>1))
					aNtaRecNum:=1
				: ((bPrev=1) & (aNtaRecNum>1))
					aNtaRecNum:=aNtaRecNum-1
				: ((bNext=1) & (aNtaRecNum<Size of array:C274(aNtaRecNum)))
					aNtaRecNum:=aNtaRecNum+1
				: ((bLast=1) & (aNtaRecNum<Size of array:C274(aNtaRecNum)))
					aNtaRecNum:=Size of array:C274(aNtaRecNum)
			End case 
			
			GOTO RECORD:C242([Alumnos_Calificaciones:208];aNtaRecNum{aNtaRecNum})
			RELATE ONE:C42([Alumnos_Calificaciones:208]Llave_principal:1)
			QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]ID_RegistroHistorico:1=aHId{aNtaRecNum})
			  //20130910 ASM para cargar los complementos de evaluación
			If ([Asignaturas_Historico:84]ID_AsignaturaOriginal:30#0)
				KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1;True:C214)
			Else 
				  //20130910 ASM para cargar los complementos de evaluación cuando la asignatura historico no es original
				QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]ID_HistoricoAsignatura:48=[Asignaturas_Historico:84]ID_RegistroHistorico:1;*)
				QUERY:C277([Alumnos_ComplementoEvaluacion:209]; & ;[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6=[Alumnos_Calificaciones:208]ID_Alumno:6)
				KRL_ReloadInReadWriteMode (->[Alumnos_ComplementoEvaluacion:209])
			End if 
			SET WINDOW TITLE:C213("Info: "+[Asignaturas_Historico:84]Asignatura:2)
			bFirst:=0
			bPrev:=0
			bNext:=0
			bLast:=0
		End if 
		
		IT_SetButtonState (aNtaRecNum>1;->bFirst;->bPrev)
		IT_SetButtonState (aNtaRecNum<Size of array:C274(aNtaRecNum);->bLast;->bNext)
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
AL_ShowHideObjectHistoricos 