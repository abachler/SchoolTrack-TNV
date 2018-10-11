//%attributes = {}
  //XML_Is_ValidXMLTag

  // ----------------------------------------------------
  // Nombre usuario (OS): DARTAGAN1
  // Fecha y hora: 06-07-06, 19:32:40
  // ----------------------------------------------------
  // Método: XMLF_ValidXMLTag
  // Descripción
  // See if  the XMLTagName Is Valid or Not
  //
  // Parámetros
  // ----------------------------------------------------


C_BOOLEAN:C305($0;$vb_IsValid_XMLTagName)
C_TEXT:C284($1;$vt_XMLTagNameSource)
$vt_XMLTagNameSource:=$1
$vb_IsValid_XMLTagName:=False:C215

C_TEXT:C284($vt_XMLTagName_Cleaned)
$vt_XMLTagName_Cleaned:=""
$vt_XMLTagName_Cleaned:=XML_Gen_CleanXML ($vt_XMLTagNameSource)
Case of 
	: ($vt_XMLTagName_Cleaned="")
		$vb_IsValid_XMLTagName:=False:C215
	: ($vt_XMLTagNameSource#$vt_XMLTagName_Cleaned)
		$vb_IsValid_XMLTagName:=False:C215
	Else 
		$vb_IsValid_XMLTagName:=True:C214
End case 
$0:=$vb_IsValid_XMLTagName