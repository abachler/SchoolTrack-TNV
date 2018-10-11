//%attributes = {}
  //XML_Var_To_XML

  // ----------------------------------------------------
  // Nombre usuario (OS): DARTAGAN1
  // Fecha y hora: 06-07-06, 11:09:57
  // ----------------------------------------------------
  // Método: XMLF_Var_To_XML
  // Descripción
  // This Method converts a varaible to XML DOMXML
  //
  // Parámetros
  //$1 = Var Received
  //$2 = Name of  Header and Footer in XML DOMXML
  // ----------------------------------------------------

C_POINTER:C301($1;$vy_VarReceived)
C_TEXT:C284($2;$vt_ItemXML)
C_TEXT:C284($0;$vt_DOMXML)

$vy_VarReceived:=$1
$vt_ItemXML:=XML_Convert_To_String ($vy_VarReceived)

Case of 
	: (Count parameters:C259=1)
		  //Extract NameOf Var For Tag in XML
		C_TEXT:C284($vt_NameDOMXML)
		$vt_NameDOMXML:="DOMXMLSinNombre"
	: (Count parameters:C259=2)
		  //Extract NameOf Var For Tag in XML
		C_TEXT:C284($vt_NameDOMXML)
		$vt_NameDOMXML:=$2
End case 
  //Assign Data Type to Header and Footer DOMXML
C_TEXT:C284($vt_DOMXMLHeader;$vt_DOMXMLFooter)
$vt_DOMXMLHeader:=$vt_NameDOMXML
$vt_DOMXMLFooter:=$vt_NameDOMXML

  //Declare Tags Nomenclature and Carriage Return
C_TEXT:C284($vt_DOMXML)
C_TEXT:C284($vt_OpenTag;$vt_CloseTag;$vt_CarriageReturn)
$vt_OpenTag:="<+>"
$vt_CloseTag:="</+>"
$vt_CarriageReturn:="\r"

  //XML Building
  //DOMXML Header
  //$vt_HeaderXML:=Replace string($vt_OpenTag;"+";XML_Gen_CleanXML ($vt_DOMXMLHeader))
$vt_HeaderXML:=Replace string:C233($vt_OpenTag;"+";$vt_DOMXMLHeader)
$vt_DOMXML:=$vt_DOMXML+$vt_HeaderXML+$vt_CarriageReturn
  //Data Item
$vt_ItemXML:=$vt_ItemXML
$vt_DOMXML:=$vt_DOMXML+$vt_ItemXML+$vt_CarriageReturn
  //DOMXML Footer
  //$vt_FooterXML:=Replace string($vt_CloseTag;"+";XML_Gen_CleanXML ($vt_DOMXMLFooter))
$vt_FooterXML:=Replace string:C233($vt_CloseTag;"+";$vt_DOMXMLFooter)
$vt_DOMXML:=$vt_DOMXML+$vt_FooterXML

  //Result
$0:=$vt_DOMXML
