//%attributes = {}
  //XML_Gen_Empty_XML

  // ----------------------------------------------------
  // Nombre usuario (OS): mauricio
  // Fecha y hora: 12/06/06, 12:57:22
  // ----------------------------------------------------
  // Método: XML_Generate_Empty_XML
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($0;$vt_Result)

C_TEXT:C284($vt_ReferenciaContenido;$vt_XML_Data_TMP;$vt_CarriageReturn)
$vt_CarriageReturn:="\r"

  //============== XML_TMP ===============

  //============== XML HEADER =============
$vt_ReferenciaContenido:="xmlempty"
$vt_XML_Data_TMP:=""
  // // Ref
$vt_XML_Data_TMP:=XML_Gen_RefXML +$vt_CarriageReturn
  // // Header
$vt_XML_Data_TMP:=$vt_XML_Data_TMP+XML_Gen_Header ($vt_ReferenciaContenido)+$vt_CarriageReturn
  //============== XML HEADER END =============

  //==============XML FOOTER=============
  // // Footer of XML Schemma
$vt_XML_Data_TMP:=$vt_XML_Data_TMP+XML_Gen_Footer ($vt_ReferenciaContenido)
  //==============XML FOOTER END=============

$vt_Result:=$vt_XML_Data_TMP

$0:=$vt_Result