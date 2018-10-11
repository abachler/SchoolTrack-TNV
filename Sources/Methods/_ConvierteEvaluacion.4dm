//%attributes = {}
  //_ConvierteEvaluacion


C_LONGINT:C283($vl_conversionMode)
C_POINTER:C301($conversionPointer)

Case of 
	: (Count parameters:C259>=4)
		$conversionPointer:=$4
		$vl_conversionMode:=$3
		$vl_convert2StyleID:=$2
	: (Count parameters:C259>=3)
		$vl_conversionMode:=$3
		$vl_convert2StyleID:=$2
	: (Count parameters:C259>=2)
		$vl_convert2StyleID:=$2
	Else 
		$vl_convert2StyleID:=[Asignaturas:18]Numero_de_EstiloEvaluacion:39
End case 

EVS_ReadStyleData ($vl_convert2StyleID)

If ($vl_conversionMode=0)
	If (Not:C34(Is nil pointer:C315($conversionPointer)))
		$vl_conversionMode:=$conversionPointer->
	End if 
End if 
If ($vl_conversionMode=0)
	$vl_conversionMode:=iPrintMode
End if 


$0:=NTA_PercentValue2StringValue ($1;$vl_conversionMode)