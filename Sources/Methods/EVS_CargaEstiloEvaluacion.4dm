//%attributes = {}
  // EVS_CargaEstiloEvaluacion()
  // 
  //
  // creado por: Alberto Bachler Klein: 15-07-16, 09:15:27
  // -----------------------------------------------------------


C_LONGINT:C283($records)

$l_IdEstilo:=$1
vb_evStyleModified:=False:C215




vlEVS_CurrentEvStyleID:=0
EVS_ReadStyleData ($l_IdEstilo)
vl_LastEvStyleRecNum:=Record number:C243([xxSTR_EstilosEvaluacion:44])

EVS_CargaConversionesSimbolos 
EVS_CargaTablaConversion 
EVS_CargaTablaEsfuerzo 

EVS_FijaEstadoObjetosInterfaz 