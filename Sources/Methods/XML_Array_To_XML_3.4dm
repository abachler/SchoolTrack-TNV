//%attributes = {}
  //XML_Array_To_XML_3

  // ----------------------------------------------------
  // Nombre usuario (OS): DARTAGAN1
  // Fecha y hora: 06-07-06, 16:30:44
  // ----------------------------------------------------
  // Método: XML_Array_To_XML
  // Descripción
  // This Method Converts a Array To XML, the second parameter it´s the name of tag for each Value of the first parameter passing in the array
  //
  // Parámetros
  //$1 = Values Array
  //$2 = Names of Tags For Values
  //$3 = Name of Header and Footer DOMXML (Optional)
  // ----------------------------------------------------

  // Modificado por: DARTAGAN1 (07-07-2006)

C_POINTER:C301($1;$vy_PointerValuesArray)
C_POINTER:C301($2;$vy_PointerArrayNamesTags)
$vy_PointerValuesArray:=$1
$vy_PointerArrayNamesTags:=$2

C_TEXT:C284($0;$vt_DOMXML)

  //Value Items
ARRAY TEXT:C222($vat_ArrayValues;0)
COPY ARRAY:C226($vy_PointerValuesArray->;$vat_ArrayValues)

  //Names Tags For Values Array
ARRAY TEXT:C222($vat_ArrayNamesTags;0)
COPY ARRAY:C226($vy_PointerArrayNamesTags->;$vat_ArrayNamesTags)

  //Assign Data Type to Header and Footer DOMXML
C_TEXT:C284($3;$vt_NameHeaderFooterDOMXML)
C_TEXT:C284($vt_DOMXMLHeader;$vt_DOMXMLFooter)
Case of 
	: (Count parameters:C259=2)
		  //Optional Text For Header and Footer DOMXML
		$vt_DOMXMLHeader:="NoNameDOMXML"
		$vt_DOMXMLFooter:="NoNameDOMXML"
	: (Count parameters:C259=3)
		  //Optional Text For Header And Footer DOMXML
		$vt_NameHeaderFooterDOMXML:=$3
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
C_LONGINT:C283($i)
  //DOMXML Header
  //$vt_HeaderXML:=Replace string($vt_OpenTag;"+";XML_Gen_CleanXML ($vt_DOMXMLHeader))
$vt_HeaderXML:=Replace string:C233($vt_OpenTag;"+";$vt_DOMXMLHeader)
$vt_DOMXML:=$vt_DOMXML+$vt_HeaderXML+$vt_CarriageReturn
C_TEXT:C284(vt_ValueOfVarReceive;vt_ValueOfVarSend)
For ($i;1;Size of array:C274($vat_ArrayValues))
	  //DOM Header
	  //$vt_HeaderXML:=Replace string($vt_OpenTag;"+";XML_Gen_CleanXML ($vat_ArrayNamesTags{$i})+" N="+String($i))
	$vt_HeaderXML:=Replace string:C233($vt_OpenTag;"+";$vat_ArrayNamesTags{$i}+" N="+String:C10($i))
	$vt_DOMXML:=$vt_DOMXML+$vt_HeaderXML+$vt_CarriageReturn
	  //Data Item
	vt_ItemXML:=$vat_ArrayValues{$i}
	vt_ValueOfVarSend:=XML_Convert_To_String (->vt_ItemXML)
	vt_ValueOfVarReceive:=vt_ValueOfVarSend
	  //vt_ValueOfVarReceive:=XML_Convert_To_String (->vt_ValueOfVarSend)+"_"+String($i)
	$vt_DOMXML:=$vt_DOMXML+vt_ValueOfVarReceive+$vt_CarriageReturn
	  //DOM Footer
	  //$vt_FooterXML:=Replace string($vt_CloseTag;"+";XML_Gen_CleanXML ($vat_ArrayNamesTags{$i})+" N="+String($i))
	$vt_FooterXML:=Replace string:C233($vt_CloseTag;"+";$vat_ArrayNamesTags{$i}+" N="+String:C10($i))
	$vt_DOMXML:=$vt_DOMXML+$vt_FooterXML+$vt_CarriageReturn
End for 
  //DOMXML Footer 
  //$vt_FooterXML:=Replace string($vt_CloseTag;"+";XML_Gen_CleanXML ($vt_DOMXMLFooter))
$vt_FooterXML:=Replace string:C233($vt_CloseTag;"+";$vt_DOMXMLFooter)
$vt_DOMXML:=$vt_DOMXML+$vt_FooterXML


  //Result
$0:=$vt_DOMXML
