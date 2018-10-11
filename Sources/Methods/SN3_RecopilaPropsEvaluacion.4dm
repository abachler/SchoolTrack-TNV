//%attributes = {}
  //SN3_RecopilaPropsEvaluacion

$xmlRef:=$1
$periodo:=$2

For ($i;1;Size of array:C274(atAS_EvalPropSourceName))
	SAX_CreateNode ($xmlRef;"propiedad")
	SAX_CreateNode ($xmlRef;"columna";True:C214;String:C10($i))
	SAX_CreateNode ($xmlRef;"periodo";True:C214;$periodo)
	SAX_CreateNode ($xmlRef;"idorigen";True:C214;String:C10(alAS_EvalPropSourceID{$i}))
	SAX_CreateNode ($xmlRef;"detallar";True:C214;String:C10(Num:C11(abAS_EvalPropPrintDetail{$i})))
	If (atAS_EvalPropPrintName{$i}="")
		SAX_CreateNode ($xmlRef;"nombre";True:C214;atAS_EvalPropSourceName{$i};True:C214)
	Else 
		SAX_CreateNode ($xmlRef;"nombre";True:C214;atAS_EvalPropPrintName{$i};True:C214)
	End if 
	If (vlAS_CalcMethod=0)
		SAX_CreateNode ($xmlRef;"ponderacion";True:C214;"0")
	Else 
		SAX_CreateNode ($xmlRef;"ponderacion";True:C214;String:C10(arAS_EvalPropPonderacion{$i}))
	End if 
	SAX CLOSE XML ELEMENT:C854($xmlRef)
End for 

