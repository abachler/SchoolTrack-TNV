//%attributes = {}
  //XML_Gen_Header

  // ----------------------------------------------------
  // Nombre usuario (OS): mauricio
  // Fecha y hora: 22/01/07, 11:02:47
  // ----------------------------------------------------
  // Método: XML_Header
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_TEXT:C284($1;$Header)
C_TEXT:C284($0;$Result)

$Header:=$1


C_TEXT:C284($vt_OpenTag)
$vt_OpenTag:="<+>"
$Result:=Replace string:C233($vt_OpenTag;"+";XML_Gen_CleanXML ($Header))
$0:=$Result