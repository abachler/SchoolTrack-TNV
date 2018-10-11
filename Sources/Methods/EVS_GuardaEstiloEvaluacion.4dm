//%attributes = {}
  // EVS_GuardaEstiloEvaluacion()
  // 
  //
  // creado por: Alberto Bachler Klein: 15-07-16, 09:15:39
  // -----------------------------------------------------------
C_BOOLEAN:C305($1;$b_validaTablaConv)  //MONO Ticket 202359
$b_validaTablaConv:=True:C214
If (Count parameters:C259=1)
	$b_validaTablaConv:=$1
End if 

If (Find in array:C230(alEVS_ModifiedStyles;[xxSTR_EstilosEvaluacion:44]ID:1)>0)
	[xxSTR_EstilosEvaluacion:44]modificadoPor:12:=<>tUSR_CurrentUserName
	SAVE RECORD:C53([xxSTR_EstilosEvaluacion:44])
End if 
EVS_GuardaConversionSimbolos 
EVS_GuardaTablaConversion ($b_validaTablaConv)  //MONO Ticket 202359
EVS_GuardaTablaEsfuerzo 
EVS_WriteStyleData 