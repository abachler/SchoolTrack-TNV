//%attributes = {}
  //DOM_GetValue

$ref:=$1
$xPath:=$2

$elementRef:=DOM Find XML element:C864($ref;$xPath)
If (($elementRef#"0000000000000000") & (OK=1))  //MONO Ticket 217934
	DOM GET XML ELEMENT VALUE:C731($elementRef;$value)
Else 
	$value:=""
End if 
$0:=$value