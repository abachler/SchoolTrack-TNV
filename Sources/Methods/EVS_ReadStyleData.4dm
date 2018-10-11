//%attributes = {}
  //EVS_ReadStyleData


C_BLOB:C604($blob)
C_LONGINT:C283(vlEVS_CurrentEvStyleID;$0;$result;$otRef;$styleID;$1)
C_BOOLEAN:C305(vb_EstilosInicializados)
$result:=1

If (Not:C34(vb_EstilosInicializados))
	EVS_initialize 
End if 

If (Not:C34(Read only state:C362([xxSTR_EstilosEvaluacion:44])))
	KRL_ReloadAsReadOnly (->[xxSTR_EstilosEvaluacion:44])
End if 


$OTRef:=0
If (Count parameters:C259=1)
	$StyleID:=$1
	If ($styleID=0)
		$result:=0
	Else 
		If ($StyleID#vlEVS_CurrentEvStyleID)
			$recNum:=KRL_FindAndLoadRecordByIndex (->[xxSTR_EstilosEvaluacion:44]ID:1;->$styleID)
			If ($recNum>=0)
				$blob:=[xxSTR_EstilosEvaluacion:44]OT_Data:7
				$OTref:=OT BLOBToObject ($blob)
			Else 
				$result:=0
				EVS_initialize 
			End if 
		End if 
	End if 
Else 
	If ([xxSTR_EstilosEvaluacion:44]ID:1#0)
		$styleID:=[xxSTR_EstilosEvaluacion:44]ID:1
		If ([xxSTR_EstilosEvaluacion:44]ID:1#vlEVS_CurrentEvStyleID)
			$blob:=[xxSTR_EstilosEvaluacion:44]OT_Data:7
			$OTref:=OT BLOBToObject ($blob)
		End if 
	Else 
		$result:=0
		EVS_initialize 
	End if 
End if 

If ($result>0)
	
	If ($StyleID#vlEVS_CurrentEvStyleID)
		ARRAY TEXT:C222(aSymbol;0)
		ARRAY TEXT:C222(aSymbDesc;0)
		ARRAY REAL:C219(aSymbFrom;0)
		ARRAY REAL:C219(aSymbTo;0)
		ARRAY REAL:C219(aSymbGradeFrom;0)
		ARRAY REAL:C219(aSymbGradeTo;0)
		ARRAY REAL:C219(aSymbPointsFrom;0)
		ARRAY REAL:C219(aSymbPointsTo;0)
		ARRAY REAL:C219(aSymbPctFrom;0)
		ARRAY REAL:C219(aSymbPctTo;0)
		ARRAY REAL:C219(aSymbPctEqu;0)
		ARRAY REAL:C219(aSymbGradesEqu;0)
		ARRAY REAL:C219(aSymbPointsEqu;0)
		ARRAY REAL:C219(arEVS_ConvGradesOfficial;0)
		ARRAY REAL:C219(arEVS_ConvGrades;0)
		ARRAY REAL:C219(arEVS_ConvPoints;0)
		ARRAY REAL:C219(arEVS_ConvPointsPercent;0)
		ARRAY REAL:C219(arEVS_ConvGradesPercent;0)
		vtEVS_comments:=[xxSTR_EstilosEvaluacion:44]Observaciones:10
		vlEVS_CurrentEvStyleID:=[xxSTR_EstilosEvaluacion:44]ID:1
		rGradesFrom:=OT GetReal ($OTref;"rGradesFrom")
		rGradesTo:=OT GetReal ($OTref;"rGradesTo")
		rGradesMinimum:=OT GetReal ($OTref;"rGradesMinimum")
		rPointsFrom:=OT GetReal ($OTref;"rPointsFrom")
		rPointsTo:=OT GetReal ($OTref;"rPointsTo")
		rPointsMinimum:=OT GetReal ($OTref;"rPointsMinimum")
		rPctMinimum:=OT GetReal ($OTref;"rPctMinimum")
		rPointsInterval:=OT GetReal ($OTref;"rPointsInterval")
		rGradesInterval:=OT GetReal ($OTref;"rGradesInterval")
		iGradesDec:=OT GetLong ($OTref;"iGradesDec")
		iPointsDec:=OT GetLong ($OTref;"iPointsDec")
		iEvaluationMode:=OT GetLong ($OTref;"iEvaluationMode")
		iViewMode:=OT GetLong ($OTref;"iViewMode")
		iPrintMode:=OT GetLong ($OTref;"iPrintMode")
		iResults:=OT GetLong ($OTref;"iResults")
		vi_Autodecimal:=OT GetLong ($OTref;"vi_Autodecimal")
		iPrintActa:=OT GetLong ($OTref;"iPrintActa")
		vi_gTrPAvg:=OT GetLong ($OTref;"vi_gTrPAvg")
		vi_gTrFAvg:=OT GetLong ($OTref;"vi_gTrFAvg")
		vi_RoundCPpresent:=OT GetLong ($OTref;"vi_RoundCPpresent")
		viEVS_EquMethod:=OT GetLong ($OTref;"viEVS_EquMethod")
		viEVS_EquMode:=OT GetLong ($OTref;"viEVS_EquMode")
		vi_gTrEXNF:=OT GetLong ($OTref;"vi_gTrEXNF")
		iConversionTable:=OT GetLong ($OTref;"iConversionTable")
		vs_GradesFormat:=OT GetString ($OTref;"vs_GradesFormat")
		vs_pointsFormat:=OT GetString ($OTref;"vs_pointsFormat")
		vs_PercentFormat:=OT GetString ($OTref;"vs_PercentFormat")
		sSymbolMinimum:=OT GetString ($OTref;"sSymbolMinimum")
		vi_ConvertSymbolicAverage:=OT GetLong ($OTref;"vi_ConvertSymbolicAverage")
		OT GetArray ($OTref;"aSymbol";aSymbol)
		OT GetArray ($OTref;"aSymbDesc";aSymbDesc)
		OT GetArray ($OTref;"aSymbGradeFrom";aSymbGradeFrom)
		OT GetArray ($OTref;"aSymbGradeto";aSymbGradeto)
		OT GetArray ($OTref;"aSymbPointsFrom";aSymbPointsFrom)
		OT GetArray ($OTref;"aSymbPointsTo";aSymbPointsTo)
		OT GetArray ($OTref;"aSymbPctFrom";aSymbPctFrom)
		OT GetArray ($OTref;"aSymbPctTo";aSymbPctTo)
		OT GetArray ($OTref;"aSymbPctEqu";aSymbPctEqu)
		OT GetArray ($OTref;"aSymbGradesEqu";aSymbGradesEqu)
		OT GetArray ($OTref;"aSymbPointsEqu";aSymbPointsEqu)
		OT GetArray ($OTref;"arEVS_ConvGrades";arEVS_ConvGrades)
		OT GetArray ($OTref;"arEVS_ConvPoints";arEVS_ConvPoints)
		OT GetArray ($OTref;"arEVS_ConvGradesOfficial";arEVS_ConvGradesOfficial)
		OT GetArray ($OTref;"arEVS_ConvPointsPercent";arEVS_ConvPointsPercent)
		OT GetArray ($OTref;"arEVS_ConvGradesPercent";arEVS_ConvGradesPercent)
		vi_gTroncarNotaFinal:=OT GetLong ($OTref;"vi_gTroncarNotaFinal")
		cb_EvaluaEsfuerzo:=OT GetLong ($OTref;"cb_EvaluaEsfuerzo")
		OT GetArray ($OTref;"aIndEsfuerzo";aIndEsfuerzo)
		OT GetArray ($OTref;"aDescEsfuerzo";aDescEsfuerzo)
		OT GetArray ($OTRef;"aFactorEsfuerzo";aFactorEsfuerzo)
		OT GetArray ($OTRef;"aSTWAColorRGB";aSTWAColorRGB)  //ASM 20180714 Ticket 211218 
		OT GetArray ($OTRef;"aSTWAColorHexa";aSTWAColorHexa)  //ASM 20180714 Ticket 211218 
		
		vrEVS_PonderacionQ1:=OT GetReal ($OTREF;"vrEVS_PonderacionQ1")
		vrEVS_PonderacionQ2:=OT GetReal ($OTREF;"vrEVS_PonderacionQ2")
		vrEVS_PonderacionQ3:=OT GetReal ($OTREF;"vrEVS_PonderacionQ3")
		vrEVS_PonderacionQ4:=OT GetReal ($OTREF;"vrEVS_PonderacionQ4")
		vrEVS_PonderacionQ5:=OT GetReal ($OTREF;"vrEVS_PonderacionQ5")
		vrEVS_PonderacionB1:=OT GetReal ($OTREF;"vrEVS_PonderacionB1")
		vrEVS_PonderacionB2:=OT GetReal ($OTREF;"vrEVS_PonderacionB2")
		vrEVS_PonderacionB3:=OT GetReal ($OTREF;"vrEVS_PonderacionB3")
		vrEVS_PonderacionB4:=OT GetReal ($OTREF;"vrEVS_PonderacionB4")
		
		vrEVS_PonderacionT1:=OT GetReal ($OTREF;"vrEVS_PonderacionT1")
		vrEVS_PonderacionT2:=OT GetReal ($OTREF;"vrEVS_PonderacionT2")
		vrEVS_PonderacionT3:=OT GetReal ($OTREF;"vrEVS_PonderacionT3")
		vrEVS_PonderacionS1:=OT GetReal ($OTREF;"vrEVS_PonderacionS1")
		vrEVS_PonderacionS2:=OT GetReal ($OTREF;"vrEVS_PonderacionS2")
		vi_BonificarNotaOficial:=OT GetLong ($OTREF;"vi_BonificarNotaOficial")
		vi_BonificarNotaFinalInterna:=OT GetLong ($OTREF;"vi_BonificarNotaFinalInterna")
		vi_BonificarPromedioAnual:=OT GetLong ($OTREF;"vi_BonificarPromedioAnual")
		vi_BonificarPromedioPeriodo:=OT GetLong ($OTREF;"vi_BonificarPromedioPeriodo")
		vi_ModoCalculoNF:=OT GetLong ($OTREF;"vi_ModoCalculoNF")
		vi_TruncarInferiorRequerido:=OT GetLong ($OTREF;"vi_TruncarInferiorRequerido")
		iGradesDecPP:=OT GetLong ($OTref;"iGradesDecPP")
		iGradesDecPF:=OT GetLong ($OTref;"iGradesDecPF")
		iGradesDecNF:=OT GetLong ($OTref;"iGradesDecNF")
		iGradesDecNO:=OT GetLong ($OTref;"iGradesDecNO")
		iPointsDecPP:=OT GetLong ($OTref;"iPointsDecPP")
		iPointsDecPF:=OT GetLong ($OTref;"iPointsDecPF")
		iPointsDecNF:=OT GetLong ($OTref;"iPointsDecNF")
		iPointsDecNO:=OT GetLong ($OTref;"iPointsDecNO")
		viEVS_EquivalenciasAbsolutas:=OT GetLong ($OTref;"viEVS_EquivalenciasAbsolutas")
		vr_MinimoRecuperacion:=OT GetReal ($OTRef;"vr_MinimoRecuperacion")
		vi_SinReprobacion:=OT GetLong ($OTRef;"vi_SinReprobacion")
		r1_EvEsfuerzoIndicadores:=OT GetLong ($OTRef;"r1_EvEsfuerzoIndicadores")
		r2_EvEsfuerzoBonificacion:=OT GetLong ($OTRef;"r1_EvEsfuerzoBonificacion")
		rAprobatorioPorcentaje:=OT GetReal ($OTRef;"rAprobatorioPorcentaje")
		
		iViewMode:=iEvaluationMode  // en v12 eliminamos el modo de visualización
		iViewMode:=iPrintMode  // MOD Ticket Nª 197116 en v12 eliminamos el modo de visualización
		
		If ((iGradesDec=0) & (rGradesInterval<1))
			rGradesInterval:=1
		End if 
		If ((iPointsDec=0) & (rPointsInterval<1))
			rPointsInterval:=1
		End if 
		
		If (<>tXS_RS_DecimalSeparator#<>vs_AppDecimalSeparator)
			vs_gradesFormat:=Replace string:C233(vs_gradesFormat;<>vs_AppDecimalSeparator;<>tXS_RS_DecimalSeparator)  // 20051218 BAK
			vs_pointsFormat:=Replace string:C233(vs_pointsFormat;<>vs_AppDecimalSeparator;<>tXS_RS_DecimalSeparator)
			vs_PercentFormat:=Replace string:C233(vs_PercentFormat;<>vs_AppDecimalSeparator;<>tXS_RS_DecimalSeparator)
		End if 
		SORT ARRAY:C229(aSymbPctFrom;aSymbol;aSymbDesc;aSymbGradeFrom;aSymbPointsFrom;aSymbGradeto;aSymbPointsTo;aSymbPctTo;aSymbPctEqu;aSymbGradesEqu;aSymbPointsEqu;>)
		SORT ARRAY:C229(aFactorEsfuerzo;aIndEsfuerzo;aDescEsfuerzo;>)
		EVS_SetFormats 
		
		Case of 
			: (iEvaluationMode=Notas)
				vrEVLG_Evaluacion_Minimo:=rGradesFrom
				vrEVLG_Evaluacion_Maximo:=rGradesTo
				vrEVLG_Requerido:=rGradesMinimum
				vlEVLG_Decimals:=iGradesDec
				vrEVLG_Interval:=rGradesInterval
				vsEVLG_Format:=vs_gradesFormat
				vrNTA_MinimoEscalaReferencia:=Round:C94(rGradesFrom/rGradesTo*100;11)
				vlNTA_DecimalesParciales:=iGradesDec
				vlNTA_DecimalesPP:=iGradesDecPP
				vlNTA_DecimalesPF:=iGradesDecPF
				vlNTA_DecimalesNF:=iGradesDecNF
				vlNTA_DecimalesNO:=iGradesDecNO
				
			: (iEvaluationMode=Puntos)
				vrEVLG_Evaluacion_Minimo:=rPointsFrom
				vrEVLG_Evaluacion_Maximo:=rPointsTo
				vrEVLG_Requerido:=rPointsMinimum
				vlEVLG_Decimals:=iPointsDec
				vrEVLG_Interval:=rPointsInterval
				vsEVLG_Format:=vs_PointsFormat
				vrNTA_MinimoEscalaReferencia:=Round:C94(rPointsFrom/rPointsTo*100;11)
				vlNTA_DecimalesParciales:=iPointsDec
				vlNTA_DecimalesPP:=iPointsDecPP
				vlNTA_DecimalesPF:=iPointsDecPF
				vlNTA_DecimalesNF:=iPointsDecNF
				vlNTA_DecimalesNO:=iPointsDecNO
				
			: (iEvaluationMode=Simbolos)
				vrEVLG_Evaluacion_Minimo:=0
				vrEVLG_Evaluacion_Maximo:=100
				vrEVLG_Requerido:=rPctMInimum
				vlEVLG_Decimals:=0
				vrEVLG_Interval:=0
				vsEVLG_Format:=""
				COPY ARRAY:C226(aSymbPctFrom;$aPercents)
				SORT ARRAY:C229($aPercents;>)
				If (Size of array:C274($aPercents)>0)
					vrNTA_MinimoEscalaReferencia:=$aPercents{1}
				Else 
					vrNTA_MinimoEscalaReferencia:=0
				End if 
				If (vrNTA_MinimoEscalaReferencia=0)
					Case of 
						: (rGradesFrom>0)
							vrNTA_MinimoEscalaReferencia:=Round:C94(rGradesFrom/rGradesTo*100;11)
						: (rPointsFrom>0)
							vrNTA_MinimoEscalaReferencia:=Round:C94(rPointsFrom/rPointsTo*100;11)
					End case 
				End if 
				
			: (iEvaluationMode=Porcentaje)
				vrEVLG_Evaluacion_Minimo:=0
				vrEVLG_Evaluacion_Maximo:=100
				vrEVLG_Requerido:=rPctMInimum
				vlEVLG_Decimals:=1
				vrEVLG_Interval:=0.1
				vsEVLG_Format:=vs_gradesFormat
				vrNTA_MinimoEscalaReferencia:=0
				Case of 
					: (rGradesFrom>0)
						vrNTA_MinimoEscalaReferencia:=Round:C94(rGradesFrom/rGradesTo*100;11)
					: (rPointsFrom>0)
						vrNTA_MinimoEscalaReferencia:=Round:C94(rPointsFrom/rPointsTo*100;11)
				End case 
				vlNTA_DecimalesParciales:=1
				vlNTA_DecimalesPP:=1
				vlNTA_DecimalesPF:=1
				vlNTA_DecimalesNF:=1
				vlNTA_DecimalesNO:=1
				
		End case 
		vt_SujetoRecuperacion:=NTA_PercentValue2StringValue (vr_MinimoRecuperacion)
		
		Case of 
			: (iPrintActa=Notas)
				vlNTA_DecimalesNO:=iGradesDecNO
			: (iPrintActa=Puntos)
				vlNTA_DecimalesNO:=iPointsDecNO
		End case 
		
		IDLE:C311
	End if 
End if 


If ($OTref#0)
	OT Clear ($OTref)
	IDLE:C311
End if 
$0:=$result




