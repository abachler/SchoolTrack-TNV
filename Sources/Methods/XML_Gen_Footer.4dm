//%attributes = {}
  //XML_Gen_Footer

  // ----------------------------------------------------
  // Nombre usuario (OS): mauricio
  // Fecha y hora: 22/01/07, 11:02:07
  // ----------------------------------------------------
  // Método: XML_Footer
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_TEXT:C284($1;$Footer)
C_TEXT:C284($0;$Result)

$Footer:=$1


C_TEXT:C284($vt_CloseTag)
$vt_CloseTag:="</+>"
$Result:=Replace string:C233($vt_CloseTag;"+";XML_Gen_CleanXML ($Footer))
$0:=$Result
