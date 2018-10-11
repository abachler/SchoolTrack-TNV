//%attributes = {}
  //EVS_initialize

C_BOOLEAN:C305(vb_EstilosInicializados)
C_LONGINT:C283(vlEVS_CurrentEvStyleID)
C_REAL:C285(rGradesFrom;rGradesTo:rGradesMinimum;rPointsFrom;rPointsTo;rPointsMinimum;rPctMinimum;rGradesInterval;rPointsInterval;rAprobatorioPorcentaje)
C_LONGINT:C283(iGradesDec;iPointsDec;iEvaluationMode;iViewMode;iPrintMode;iPrintActa;iResults;vi_Autodecimal;vi_gTrPAvg;vi_gTrFAvg;vi_RoundCPpresent;viEVS_EquMethod;viEVS_EquMode;iConversionTable;vi_gTroncarNotaFinal;vi_ConvertSymbolicAverage;vi_TruncarInferiorRequerido)
C_LONGINT:C283(vi_BonificarNotaOficial;vi_BonificarNotaFinalInterna;vi_BonificarPromedioAnual;vi_BonificarPromedioPeriodo)
C_LONGINT:C283(vi_ModoCalculoNF)
_O_C_STRING:C293(255;vs_GradesFormat;vs_pointsFormat;vs_PercentFormat;sSymbolMinimum)
C_REAL:C285(vrEVS_PonderacionQ1;vrEVS_PonderacionQ2;vrEVS_PonderacionQ3;vrEVS_PonderacionQ4;vrEVS_PonderacionQ5)
C_REAL:C285(vrEVS_PonderacionB1;vrEVS_PonderacionB2;vrEVS_PonderacionB3;vrEVS_PonderacionB4)
C_REAL:C285(vrEVS_PonderacionT1;vrEVS_PonderacionT2;vrEVS_PonderacionT3)
C_REAL:C285(vrEVS_PonderacionS1;vrEVS_PonderacionS2;vrNTA_MinimoEscalaReferencia)
C_LONGINT:C283(iGradesDecPP;iGradesDecPF;iGradesDecNF;iGradesDecNO)
C_LONGINT:C283(iPointsDecPP;iPointsDecPF;iPointsDecNF;iPointsDecNO)
C_LONGINT:C283(cb_EvaluaEsfuerzo)
C_LONGINT:C283(viEVS_EquivalenciasAbsolutas)
  //C_TEXT(vt_comments)//20170503 RCH Según lo comentado por ABK, esta variable no se usa. Se quita.
C_TEXT:C284(vtEVS_comments)  //20170503 RCH
C_REAL:C285(vr_MinimoRecuperacion)
C_LONGINT:C283(vi_SinReprobacion)
C_LONGINT:C283(r1_EvEsfuerzoIndicadores;r2_EvEsfuerzoBonificacion)


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

ARRAY TEXT:C222(aIndEsfuerzo;0)
ARRAY TEXT:C222(aDescEsfuerzo;0)
ARRAY REAL:C219(aFactorEsfuerzo;0)

ARRAY LONGINT:C221(aSTWAColorRGB;0)  //ASM 20180714 Ticket 211218 
ARRAY TEXT:C222(aSTWAColorHexa;0)  //ASM 20180714 Ticket 211218 


  //vt_comments:="" //20170503 RCH Según lo comentado por ABK, esta variable no se usa. Se quita.
vtEVS_comments:=""  //20170503 RCH
rGradesFrom:=0
rGradesTo:=0
rGradesMinimum:=0
rPointsFrom:=0
rPointsTo:=0
rPointsMinimum:=0
rPctMinimum:=0
iGradesDec:=0
iPointsDec:=0
iEvaluationMode:=0
iViewMode:=0
iPrintMode:=0
iPrintActa:=0
iResults:=0
vi_Autodecimal:=0
vi_TruncarInferiorRequerido:=0
vi_gTrPAvg:=0
vi_gTrFAvg:=0
vi_gTrEXNF:=0
vi_ModoCalculoNF:=1
vi_RoundCPpresent:=0
viEVS_EquMethod:=0
viEVS_EquMode:=0
vs_GradesFormat:=""
vs_pointsFormat:=""
vs_PercentFormat:=""
rGradesInterval:=0
rPointsInterval:=0
iConversionTable:=0
sSymbolMinimum:=""
vi_BonificarNotaOficial:=0
vi_BonificarNotaFinalInterna:=0
vi_BonificarPromedioPeriodo:=0
vi_BonificarPromedioAnual:=0
vi_ConvertSymbolicAverage:=0

vrEVS_PonderacionQ1:=0
vrEVS_PonderacionQ2:=0
vrEVS_PonderacionQ3:=0
vrEVS_PonderacionQ4:=0
vrEVS_PonderacionQ5:=0

vrEVS_PonderacionB1:=0
vrEVS_PonderacionB2:=0
vrEVS_PonderacionB3:=0
vrEVS_PonderacionB4:=0

vrEVS_PonderacionT1:=0
vrEVS_PonderacionT2:=0
vrEVS_PonderacionT3:=0
vrEVS_PonderacionS1:=0
vrEVS_PonderacionS2:=0
iGradesDecPP:=iGradesDec
iGradesDecPF:=iGradesDec
iGradesDecNF:=iGradesDec
iGradesDecNO:=iGradesDec
iPointsDecPP:=iPointsDec
iPointsDecPF:=iPointsDec
iPointsDecNF:=iPointsDec
iPointsDecNO:=iPointsDec

viEVS_EquivalenciasAbsolutas:=0
vlEVS_CurrentEvStyleID:=0

cb_EvaluaEsfuerzo:=0

vr_MinimoRecuperacion:=0
vi_SinReprobacion:=0

vb_EstilosInicializados:=True:C214

  //20121113 RCH para control de recalculo de todas las notas
C_BOOLEAN:C305(<>vb_calculandoPromediosT)