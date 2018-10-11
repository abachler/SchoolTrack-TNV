//%attributes = {}
  //XML_Records_To_XML

  // ----------------------------------------------------
  // Nombre usuario (OS): mauricio
  // Fecha y hora: 22/01/07, 11:04:26
  // ----------------------------------------------------
  // Método: XML_Records_To_XML
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

Case of 
	: (Records in selection:C76($vy_Table->)>0)
		  //Fields in a Table and Asign Their Names in a Text Array
		C_LONGINT:C283($i;$y;$vl_NumFields)
		$vl_NumFields:=Get last field number:C255($vy_Table)
		  //ARRAY TEXT($vat_NameFields;$vl_NumFields)
		  //ARRAY POINTER($vay_IDFields;$vl_NumFields)
		ARRAY TEXT:C222($vat_NameFields;0)
		ARRAY POINTER:C280($vay_IDFields;0)
		For ($i;1;$vl_NumFields)
			  //20130321 RCH
			If (Is field number valid:C1000(Table:C252($vy_Table);$i))
				  //$vat_NameFields{$i}:=Field name(Table($vy_Table);$i)
				  //$vay_IDFields{$i}:=Field(Table($vy_Table);$i)
				APPEND TO ARRAY:C911($vat_NameFields;Field name:C257(Table:C252($vy_Table);$i))
				APPEND TO ARRAY:C911($vay_IDFields;Field:C253(Table:C252($vy_Table);$i))
			End if 
		End for 
		
		  //Init Vars for Create XML Schema and Doms
		C_TEXT:C284($vt_DOMXML;$vt_RefItemXML;$vt_RefItemFooter)
		C_TEXT:C284($vt_OpenTag;$vt_CloseTag;$vt_CarriageReturn)
		$vt_OpenTag:="<+>"
		$vt_CloseTag:="</+>"
		$vt_CarriageReturn:="\r"
		C_TEXT:C284($vt_ValueFields)
		C_LONGINT:C283($vt_TypeField)
		
		  // XML Building
		  //Header XML Schema
		$vt_HeaderXML:=Replace string:C233($vt_OpenTag;"+";$vt_TableName)
		$vt_DOMXML:=$vt_DOMXML+$vt_HeaderXML+$vt_CarriageReturn
		FIRST RECORD:C50($vy_Table->)
		  // /Se rrecoren los registros
		For ($i;1;Records in selection:C76($vy_Table->))
			  // /Por cada registro se rrecoren todos los campos de la tabla, asignando a la variable correspondiente su valor
			For ($y;1;Size of array:C274($vat_NameFields))
				  //Tag DOM Header
				  //$vt_HeaderXML:=Replace string($vt_OpenTag;"+";XML_Gen_CleanXML ($vat_NameFields{$y}))
				$vt_HeaderXML:=Replace string:C233($vt_OpenTag;"+";$vat_NameFields{$y})
				$vt_DOMXML:=$vt_DOMXML+$vt_HeaderXML+$vt_CarriageReturn
				  // /Se asigna el contenido del campo a la variable como un dato tipo texto, si es texto se coloca como tal, si no se convierte
				$vt_ItemXML:=XML_Convert_To_String ($vay_IDFields{$y})
				
				$vt_DOMXML:=$vt_DOMXML+$vt_ItemXML+$vt_CarriageReturn
				  //Tag DOM Footer
				  //$vt_FooterXML:=Replace string($vt_CloseTag;"+";XML_Gen_CleanXML ($vat_NameFields{$y}))
				$vt_FooterXML:=Replace string:C233($vt_CloseTag;"+";$vat_NameFields{$y})
				  //Add To XML Schema
				$vt_DOMXML:=$vt_DOMXML+$vt_FooterXML+$vt_CarriageReturn
			End for 
			NEXT RECORD:C51($vy_Table->)
		End for 
		  //Footer Schema
		  //$vt_FooterXML:=Replace string($vt_CloseTag;"+";XML_Gen_CleanXML ($vt_TableName))
		$vt_FooterXML:=Replace string:C233($vt_CloseTag;"+";$vt_TableName)
		  //Result XML Sxhema
		$vt_DOMXML:=$vt_DOMXML+$vt_FooterXML
		
		  //Return Value
		$0:=$vt_DOMXML
	: (Records in selection:C76($vy_Table->)=0)
		
		  //Return Value
		$0:=""
End case 