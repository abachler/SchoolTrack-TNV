//%attributes = {}
  //SAX_CreateNode

$ref:=$1
$tag:=$2
$value:=""
$closeNode:=False:C215
$checkChars:=False:C215

Case of 
	: (Count parameters:C259=3)
		$closeNode:=$3
		$checkChars:=False:C215
	: (Count parameters:C259=4)
		$closeNode:=$3
		$value:=$4
		$checkChars:=False:C215
	: (Count parameters:C259=5)
		$closeNode:=$3
		$value:=$4
		$checkChars:=$5
End case 

SAX OPEN XML ELEMENT:C853($ref;$tag)
If (Count parameters:C259>2)
	If ($value="")
		$value:="null"
	End if 
	If ($checkChars)
		  //20120426 RCH Se quitan caracteres de control ya que llegaban a SNet caracteres que no permitian el correcto procesamiento de archivos XML
		$value:=XML_GetValidXMLText ($value)
		  //SAX ADD XML CDATA($ref;$value)
	End if 
	SAX ADD XML ELEMENT VALUE:C855($ref;$value)
	
	If ($closeNode)
		SAX CLOSE XML ELEMENT:C854($ref)
	End if 
End if 