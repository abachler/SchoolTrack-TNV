//%attributes = {}
  //XML_Table_To_XML

  // ----------------------------------------------------
  // Nombre usuario (OS): DARTAGAN1
  // Fecha y hora: 06-07-06, 14:11:33
  // ----------------------------------------------------
  // Método: XML_Table_To_XML
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_POINTER:C301($1;$vy_Table)
$vy_Table:=$1

C_TEXT:C284($0;$vt_DOMXML)

  //Table Name
C_TEXT:C284($vt_TableName)
$vt_TableName:=Table name:C256($vy_Table)

  //Fields in a Table and Asign Their Names in a Text Array
C_LONGINT:C283($i;$vl_NumFields)
$vl_NumFields:=Get last field number:C255($vy_Table)
  //ARRAY TEXT($vat_NameFields;$vl_NumFields)
ARRAY TEXT:C222($vat_NameFields;0)
For ($i;1;$vl_NumFields)
	  //20130321 RCH
	If (Is field number valid:C1000(Table:C252($vy_Table);$i))
		  //$vat_NameFields{$i}:=Field name(Table($vy_Table);$i)
		APPEND TO ARRAY:C911($vat_NameFields;Field name:C257(Table:C252($vy_Table);$i))
	End if 
End for 

  //Declare Tags Nomenclature and Carriage Return
C_TEXT:C284($vt_RefItemXML;$vt_RefItemFooter)
C_TEXT:C284($vt_OpenTag;$vt_CloseTag;$vt_CursorReturn)
$vt_OpenTag:="<+>"
$vt_CloseTag:="</+>"
$vt_CursorReturn:="\r"

  //XML Building
  //Schema Header
  //$vt_HeaderXML:=Replace string($vt_OpenTag;"+";XML_Gen_CleanXML ($vt_TableName))
$vt_HeaderXML:=Replace string:C233($vt_OpenTag;"+";$vt_TableName)
$vt_DOMXML:=$vt_DOMXML+$vt_HeaderXML+$vt_CursorReturn
For ($i;1;Size of array:C274($vat_NameFields))
	  //DOM Header
	  //$vt_HeaderXML:=Replace string($vt_OpenTag;"+";XML_Gen_CleanXML ($vat_NameFields{$i}))
	$vt_HeaderXML:=Replace string:C233($vt_OpenTag;"+";$vat_NameFields{$i})
	$vt_DOMXML:=$vt_DOMXML+$vt_HeaderXML+$vt_CursorReturn
	  //Data Item
	$vt_ItemXML:=$vat_NameFields{$i}
	$vt_DOMXML:=$vt_DOMXML+$vt_ItemXML+$vt_CursorReturn
	  //DOM Footer
	  //$vt_FooterXML:=Replace string($vt_CloseTag;"+";XML_Gen_CleanXML ($vat_NameFields{$i}))
	$vt_FooterXML:=Replace string:C233($vt_CloseTag;"+";$vat_NameFields{$i})
	$vt_DOMXML:=$vt_DOMXML+$vt_FooterXML+$vt_CursorReturn
End for 
  //Schema Footer 
  //$vt_FooterXML:=Replace string($vt_CloseTag;"+";XML_Gen_CleanXML ($vt_TableName))
$vt_FooterXML:=Replace string:C233($vt_CloseTag;"+";$vt_TableName)
$vt_DOMXML:=$vt_DOMXML+$vt_FooterXML

  //Result
$0:=$vt_DOMXML