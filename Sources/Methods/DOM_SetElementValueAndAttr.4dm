//%attributes = {}
  //DOM_SetElementValueAndAttr

_O_C_STRING:C293(16;$nodeRef;$1;$elementRef;$0)
C_TEXT:C284($xPath;$2;$value;$3)
C_TEXT:C284(${5})
C_BOOLEAN:C305($crearElementosSinValor;$4)
$nodeRef:=$1
$xPath:=$2
$crearElementosSinValor:=False:C215


Case of 
	: (Count parameters:C259=3)
		$value:=$3
	: (Count parameters:C259>=4)
		$value:=$3
		$crearElementosSinValor:=$4
End case 

If (Count parameters:C259=2)
	$elementRef:=DOM Create XML element:C865($nodeRef;$xPath)
Else 
	If (($value#"") | ($crearElementosSinValor))
		$elementRef:=DOM Find XML element:C864($nodeRef;$xPath)
		If (OK=0)
			$elementRef:=DOM Create XML element:C865($nodeRef;$xPath)
		End if 
		DOM SET XML ELEMENT VALUE:C868($elementRef;$value)
		If (Count parameters:C259>5)
			For ($i;5;Count parameters:C259;2)
				DOM SET XML ATTRIBUTE:C866($elementRef;${$i};${$i+1})
			End for 
		End if 
	End if 
End if 

$0:=$elementRef
