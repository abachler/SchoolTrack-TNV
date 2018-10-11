//%attributes = {}
  //_Evaluacion_a_Indicador

C_LONGINT:C283(vl_LastEvStyleID)
C_LONGINT:C283(vl_convert2StyleID)
C_TEXT:C284($0;$indicador)

Case of 
	: (Count parameters:C259>=2)
		vl_convert2StyleID:=$2
	Else 
		vl_convert2StyleID:=[Asignaturas:18]Numero_de_EstiloEvaluacion:39
End case 

If (vl_convert2StyleID#0)  // si se especifica 0 en $2 se utiliza el estilo actualmente seleccionado
	If (vl_LastEvStyleID#vl_convert2StyleID)
		EVS_ReadStyleData (vl_convert2StyleID)
		vl_LastEvStyleID:=vl_convert2StyleID
	End if 
End if 

$symbol:=NTA_PercentValue2StringValue ($1;Simbolos)

$el:=Find in array:C230(aSymbol;$symbol)
If ($el>0)
	$indicador:=aSymbDesc{$el}
End if 

$0:=$indicador