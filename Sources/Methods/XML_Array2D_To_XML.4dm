//%attributes = {}
  //XML_Array2D_To_XML

  // ----------------------------------------------------
  // Nombre usuario (OS): DARTAGAN1
  // Fecha y hora: 06-07-06, 17:21:44
  // ----------------------------------------------------
  // Método: XML_Array2D_To_XML
  // Descripción
  // This Method Converts a 2 Dimensional Array to XML
  //
  // Parámetros
  //$1 =  2 Dimensional Array,  $vat_Array2{Tags}{Values}
  // $3 = Name of Header and Footer DOMXML (Optional)
  // ----------------------------------------------------
C_POINTER:C301($1;$vy_PointerArray2)
$vy_PointerArray2:=$1
ARRAY TEXT:C222($vat_Array2;0;0)
COPY ARRAY:C226($vy_PointerArray2->;$vat_Array2)

C_TEXT:C284($2;$vt_NameHeaderFooterDOMXML)
C_TEXT:C284($vt_DOMXMLHeader;$vt_DOMXMLFooter)

C_TEXT:C284($0;$vt_DOMXML)

  //Assign Data Type to Header and Footer DOMXML
Case of 
	: (Count parameters:C259=1)
		  //Optional Text For Header and Footer DOMXML
		$vt_DOMXMLHeader:="NoNameDOMXML"
		$vt_DOMXMLFooter:="NoNameDOMXML"
	: (Count parameters:C259=2)
		  //Optional Text For Header And Footer DOMXML
		$vt_NameHeaderFooterDOMXML:=$2
		Case of 
			: ($vt_NameHeaderFooterDOMXML#"")
				$vt_DOMXMLHeader:=$vt_NameHeaderFooterDOMXML
				$vt_DOMXMLFooter:=$vt_NameHeaderFooterDOMXML
			: ($vt_NameHeaderFooterDOMXML="")
				$vt_DOMXMLHeader:="NoNameDOMXML"
				$vt_DOMXMLFooter:="NoNameDOMXML"
		End case 
End case 

  //Declare Tags Nomenclature and Carriage Return
C_TEXT:C284($vt_OpenTag;$vt_CloseTag;$vt_CarriageReturn)
$vt_OpenTag:="<+>"
$vt_CloseTag:="</+>"
$vt_CarriageReturn:="\r"

  //XML Building
C_LONGINT:C283($i;$j)
C_TEXT:C284($vt_HeaderXML;$vt_HeaderXML_Temp;$vt_FooterXML)
  //DOMXML Header
  //$vt_HeaderXML:=Replace string($vt_OpenTag;"+";XML_Gen_CleanXML ($vt_DOMXMLHeader))
$vt_HeaderXML:=Replace string:C233($vt_OpenTag;"+";$vt_DOMXMLHeader)
$vt_DOMXML:=$vt_DOMXML+$vt_HeaderXML+$vt_CarriageReturn
For ($i;0;Size of array:C274($vat_Array2))
	  //DOM Header
	  //$vt_HeaderXML:=Replace string($vt_OpenTag;"+";XML_Gen_CleanXML ($vat_Array2{$i}{$j}))
	$vt_HeaderXML:=Replace string:C233($vt_OpenTag;"+";$vat_Array2{$i}{$j})
	$vt_HeaderXML_Temp:=$vat_Array2{$i}{$j}
	$vt_DOMXML:=$vt_DOMXML+$vt_HeaderXML+$vt_CarriageReturn
	  //Data Item
	For ($j;1;Size of array:C274($vat_Array2{1}))
		$vt_ItemXML:=$vat_Array2{$i}{$j}
		$vt_DOMXML:=$vt_DOMXML+$vt_ItemXML+$vt_CarriageReturn
	End for 
	  //reset counter $j
	$j:=0
	  //DOM Footer
	  //$vt_FooterXML:=Replace string($vt_CloseTag;"+";XML_Gen_CleanXML ($vt_HeaderXML_Temp))
	$vt_FooterXML:=Replace string:C233($vt_CloseTag;"+";$vt_HeaderXML_Temp)
	$vt_DOMXML:=$vt_DOMXML+$vt_FooterXML+$vt_CarriageReturn
End for 
  //DOMXML Footer
  //$vt_FooterXML:=Replace string($vt_CloseTag;"+";XML_Gen_CleanXML ($vt_DOMXMLFooter))
$vt_FooterXML:=Replace string:C233($vt_CloseTag;"+";$vt_DOMXMLFooter)
$vt_DOMXML:=$vt_DOMXML+$vt_FooterXML

  //Result
$0:=$vt_DOMXML
