//%attributes = {}
  //EVS_LeeEstiloEvalHistorico

C_LONGINT:C283($0)
C_BLOB:C604($1;$blob)
$blob:=$1

If (BLOB size:C605($blob)>32)
	$OTref:=OT BLOBToObject ($blob)
	If (OT IsObject ($OTref)=1)
		If ($OTref#0)  // en OT 4 la referencia puede ser + o - 
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
			iGradesDecPP:=OT GetLong ($OTref;"iGradesDecPP")
			iGradesDecPF:=OT GetLong ($OTref;"iGradesDecPF")
			iGradesDecNF:=OT GetLong ($OTref;"iGradesDecNF")
			iGradesDecNO:=OT GetLong ($OTref;"iGradesDecNO")
			iPointsDecPP:=OT GetLong ($OTref;"iPointsDecPP")
			iPointsDecPF:=OT GetLong ($OTref;"iPointsDecPF")
			iPointsDecNF:=OT GetLong ($OTref;"iPointsDecNF")
			iPointsDecNO:=OT GetLong ($OTref;"iPointsDecNO")
			
			
			
			OT Clear ($OTref)
			
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
					vrNTA_MinimoEscalaReferencia:=Round:C94(rGradesFrom/rGradesTo*100;10)
					
				: (iEvaluationMode=Puntos)
					vrEVLG_Evaluacion_Minimo:=rPointsFrom
					vrEVLG_Evaluacion_Maximo:=rPointsTo
					vrEVLG_Requerido:=rPointsMinimum
					vlEVLG_Decimals:=iPointsDec
					vrEVLG_Interval:=rPointsInterval
					vsEVLG_Format:=vs_PointsFormat
					vrNTA_MinimoEscalaReferencia:=Round:C94(rPointsFrom/rPointsTo*100;10)
					
					
				: (iEvaluationMode=Simbolos)
					vrEVLG_Evaluacion_Minimo:=0
					vrEVLG_Evaluacion_Maximo:=100
					vrEVLG_Requerido:=rPctMInimum
					vlEVLG_Decimals:=0
					vrEVLG_Interval:=0
					vsEVLG_Format:=""
					If (vrNTA_MinimoEscalaReferencia=0)
						Case of 
							: (rGradesFrom>0)
								vrNTA_MinimoEscalaReferencia:=Round:C94(rGradesFrom/rGradesTo*100;10)
							: (rGradesFrom>0)
								vrNTA_MinimoEscalaReferencia:=Round:C94(rPointsFrom/rPointsTo*100;10)
						End case 
					End if 
					
				: (iEvaluationMode=Porcentaje)
					vrEVLG_Evaluacion_Minimo:=0
					vrEVLG_Evaluacion_Maximo:=100
					vrEVLG_Requerido:=vrEVLG_PctMinimo
					vlEVLG_Decimals:=1
					vrEVLG_Interval:=0.1
					vsEVLG_Format:=vs_gradesFormat
					If (vrNTA_MinimoEscalaReferencia=0)
						Case of 
							: (rGradesFrom>0)
								vrNTA_MinimoEscalaReferencia:=Round:C94(rGradesFrom/rGradesTo*100;10)
							: (rGradesFrom>0)
								vrNTA_MinimoEscalaReferencia:=Round:C94(rPointsFrom/rPointsTo*100;10)
						End case 
					End if 
					
			End case 
			$0:=1
		Else 
			$0:=0
		End if 
	Else 
		$0:=0
	End if 
Else 
	$0:=0
End if 

