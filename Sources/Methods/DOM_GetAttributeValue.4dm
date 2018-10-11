//%attributes = {}
  //DOM_GetAttributeValue
C_TEXT:C284($v_valor)

$ref:=$1
$xPath:=$2
$name:=$3

$refElement:=DOM Find XML element:C864($ref;$xPath)
If ($refElement#"0000000000000000")
	EM_ErrorManager ("Install")
	EM_ErrorManager ("SetMode";"")
	DOM GET XML ATTRIBUTE BY NAME:C728($refElement;$name;$v_valor)
	EM_ErrorManager ("Clear")
Else 
	$v_valor:=""
End if 
$0:=$v_valor