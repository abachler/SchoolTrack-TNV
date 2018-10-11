//%attributes = {}
  //EVS_WriteStyleData



C_BLOB:C604($blob)
READ WRITE:C146([xxSTR_EstilosEvaluacion:44])
LOAD RECORD:C52([xxSTR_EstilosEvaluacion:44])



$iConversionTable:=iConversionTable
iConversionTable:=0  //para evitar que la conversión se efectue con la tabla
AT_ResizeArrays (->arEVS_ConvPointsPercent;0)
AT_ResizeArrays (->arEVS_ConvGradesPercent;0)
AT_ResizeArrays (->arEVS_ConvPointsPercent;Size of array:C274(arEVS_ConvGrades))
AT_ResizeArrays (->arEVS_ConvGradesPercent;Size of array:C274(arEVS_ConvGrades))
For ($i;1;Size of array:C274(arEVS_ConvGrades))
	arEVS_ConvPointsPercent{$i}:=EV2_Puntos_a_Real (arEVS_ConvPoints{$i})
	arEVS_ConvGradesPercent{$i}:=EV2_Nota_a_Real (arEVS_ConvGrades{$i})
End for 
iConversionTable:=$iConversionTable  //restablecemos


  // ABK 20121211
  // si no hay escalas numericas en las tablas de conversión en uso en nigún modo no se debe usar Tablas de Conversión
If (iConversionTable=1)
	If (Size of array:C274(arEVS_ConvGrades)=0)
		iConversionTable:=0
	End if 
End if 
  // .ABK 20121211 



EVS_SetFormats 
$OTref:=OT New 
OT PutReal ($OTref;"rGradesFrom";rGradesFrom)
OT PutReal ($OTref;"rGradesTo";rGradesTo)
OT PutReal ($OTref;"rGradesMinimum";rGradesMinimum)
OT PutReal ($OTref;"rPointsFrom";rPointsFrom)
OT PutReal ($OTref;"rPointsTo";rPointsTo)
OT PutReal ($OTref;"rPointsMinimum";rPointsMinimum)
OT PutReal ($OTref;"rPctMinimum";rPctMinimum)
OT PutReal ($OTref;"rPointsInterval";rPointsInterval)
OT PutReal ($OTref;"rGradesInterval";rGradesInterval)
OT PutLong ($OTref;"iGradesDec";iGradesDec)
OT PutLong ($OTref;"iPointsDec";iPointsDec)
OT PutLong ($OTref;"iEvaluationMode";iEvaluationMode)
OT PutLong ($OTref;"iViewMode";iViewMode)
OT PutLong ($OTref;"iPrintMode";iPrintMode)
OT PutLong ($OTref;"iResults";iResults)
OT PutLong ($OTref;"vi_Autodecimal";vi_Autodecimal)
OT PutLong ($OTref;"iPrintActa";iPrintActa)
OT PutLong ($OTref;"vi_gTrPAvg";vi_gTrPAvg)
OT PutLong ($OTref;"vi_gTrFAvg";vi_gTrFAvg)
OT PutLong ($OTref;"vi_RoundCPpresent";vi_RoundCPpresent)
OT PutLong ($OTref;"viEVS_EquMethod";viEVS_EquMethod)
OT PutLong ($OTref;"viEVS_EquMode";viEVS_EquMode)
OT PutLong ($OTref;"vi_gTrEXNF";vi_gTrEXNF)
OT PutLong ($OTref;"iConversionTable";iConversionTable)
OT PutLong ($OTref;"vi_ConvertSymbolicAverage";vi_ConvertSymbolicAverage)
OT PutString ($OTref;"vs_GradesFormat";vs_GradesFormat)
OT PutString ($OTref;"vs_pointsFormat";vs_pointsFormat)
OT PutString ($OTref;"vs_PercentFormat";vs_PercentFormat)
OT PutString ($OTref;"sSymbolMinimum";sSymbolMinimum)
OT PutArray ($OTref;"aSymbol";aSymbol)
OT PutArray ($OTref;"aSymbDesc";aSymbDesc)
OT PutArray ($OTref;"aSymbGradeFrom";aSymbGradeFrom)
OT PutArray ($OTref;"aSymbGradeto";aSymbGradeto)
OT PutArray ($OTref;"aSymbPointsFrom";aSymbPointsFrom)
OT PutArray ($OTref;"aSymbPointsTo";aSymbPointsTo)
OT PutArray ($OTref;"aSymbPctFrom";aSymbPctFrom)
OT PutArray ($OTref;"aSymbPctTo";aSymbPctTo)
OT PutArray ($OTref;"aSymbPctEqu";aSymbPctEqu)
OT PutArray ($OTref;"aSymbGradesEqu";aSymbGradesEqu)
OT PutArray ($OTref;"aSymbPointsEqu";aSymbPointsEqu)
OT PutArray ($OTref;"arEVS_ConvGrades";arEVS_ConvGrades)
OT PutArray ($OTref;"arEVS_ConvPoints";arEVS_ConvPoints)
OT PutArray ($OTref;"arEVS_ConvGradesOfficial";arEVS_ConvGradesOfficial)
OT PutArray ($OTref;"arEVS_ConvPointsPercent";arEVS_ConvPointsPercent)
OT PutArray ($OTref;"arEVS_ConvGradesPercent";arEVS_ConvGradesPercent)
OT PutLong ($OTref;"vi_gTroncarNotaFinal";vi_gTroncarNotaFinal)
OT PutLong ($OTref;"cb_EvaluaEsfuerzo";cb_EvaluaEsfuerzo)
OT PutArray ($OTref;"aIndEsfuerzo";aIndEsfuerzo)
OT PutArray ($OTref;"aDescEsfuerzo";aDescEsfuerzo)
OT PutArray ($OTref;"aFactorEsfuerzo";aFactorEsfuerzo)
OT PutArray ($OTref;"aSTWAColorRGB";aSTWAColorRGB)  //ASM 20180714 Ticket 211218 
OT PutArray ($OTref;"aSTWAColorHexa";aSTWAColorHexa)  //ASM 20180714 Ticket 211218 

OT PutReal ($OTREF;"vrEVS_PonderacionQ1";vrEVS_PonderacionQ1)
OT PutReal ($OTREF;"vrEVS_PonderacionQ2";vrEVS_PonderacionQ2)
OT PutReal ($OTREF;"vrEVS_PonderacionQ3";vrEVS_PonderacionQ3)
OT PutReal ($OTREF;"vrEVS_PonderacionQ4";vrEVS_PonderacionQ4)
OT PutReal ($OTREF;"vrEVS_PonderacionQ5";vrEVS_PonderacionQ5)

OT PutReal ($OTREF;"vrEVS_PonderacionB1";vrEVS_PonderacionB1)
OT PutReal ($OTREF;"vrEVS_PonderacionB2";vrEVS_PonderacionB2)
OT PutReal ($OTREF;"vrEVS_PonderacionB3";vrEVS_PonderacionB3)
OT PutReal ($OTREF;"vrEVS_PonderacionB4";vrEVS_PonderacionB4)

OT PutReal ($OTREF;"vrEVS_PonderacionT1";vrEVS_PonderacionT1)
OT PutReal ($OTREF;"vrEVS_PonderacionT2";vrEVS_PonderacionT2)
OT PutReal ($OTREF;"vrEVS_PonderacionT3";vrEVS_PonderacionT3)
OT PutReal ($OTREF;"vrEVS_PonderacionS1";vrEVS_PonderacionS1)
OT PutReal ($OTREF;"vrEVS_PonderacionS2";vrEVS_PonderacionS2)
OT PutLong ($OTREF;"vi_BonificarNotaOficial";vi_BonificarNotaOficial)
OT PutLong ($OTREF;"vi_BonificarNotaFinalInterna";vi_BonificarNotaFinalInterna)
OT PutLong ($OTREF;"vi_BonificarPromedioAnual";vi_BonificarPromedioAnual)
OT PutLong ($OTREF;"vi_BonificarPromedioPeriodo";vi_BonificarPromedioPeriodo)
OT PutLong ($OTREF;"vi_ModoCalculoNF";vi_ModoCalculoNF)
OT PutLong ($OTREF;"vi_TruncarInferiorRequerido";vi_TruncarInferiorRequerido)
OT PutLong ($OTref;"iGradesDecPP";iGradesDecPP)
OT PutLong ($OTref;"iGradesDecPF";iGradesDecPF)
OT PutLong ($OTref;"iGradesDecNF";iGradesDecNF)
OT PutLong ($OTref;"iGradesDecNO";iGradesDecNO)
OT PutLong ($OTref;"iPointsDecPP";iPointsDecPP)
OT PutLong ($OTref;"iPointsDecPF";iPointsDecPF)
OT PutLong ($OTref;"iPointsDecNF";iPointsDecNF)
OT PutLong ($OTref;"iPointsDecNO";iPointsDecNO)
OT PutLong ($OTref;"viEVS_EquivalenciasAbsolutas";viEVS_EquivalenciasAbsolutas)
OT PutReal ($OTref;"vr_MinimoRecuperacion";vr_MinimoRecuperacion)
OT PutLong ($OTref;"vi_SinReprobacion";vi_SinReprobacion)
OT PutLong ($OTRef;"r1_EvEsfuerzoIndicadores";r1_EvEsfuerzoIndicadores)
OT PutLong ($OTRef;"r1_EvEsfuerzoBonificacion";r2_EvEsfuerzoBonificacion)
OT PutReal ($OTRef;"rAprobatorioPorcentaje";rAprobatorioPorcentaje)



$blob:=OT ObjectToNewBLOB ($OTref)
OT Clear ($OTref)
[xxSTR_EstilosEvaluacion:44]OT_Data:7:=$blob
[xxSTR_EstilosEvaluacion:44]Observaciones:10:=vtEVS_comments
SAVE RECORD:C53([xxSTR_EstilosEvaluacion:44])


