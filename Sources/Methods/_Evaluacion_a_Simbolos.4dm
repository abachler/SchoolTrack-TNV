//%attributes = {}
  //_Evaluacion_a_Simbolos

C_LONGINT:C283(vl_LastEvStyleID)
C_LONGINT:C283(vl_convert2StyleID)

Case of 
	: (Count parameters:C259>=2)
		vl_convert2StyleID:=$2
	Else 
		vl_convert2StyleID:=[Asignaturas:18]Numero_de_EstiloEvaluacion:39
End case 

If (vl_LastEvStyleID#vl_convert2StyleID)
	EVS_ReadStyleData (vl_convert2StyleID)
	vl_LastEvStyleID:=vl_convert2StyleID
End if 

$0:=NTA_PercentValue2StringValue ($1;Simbolos)

