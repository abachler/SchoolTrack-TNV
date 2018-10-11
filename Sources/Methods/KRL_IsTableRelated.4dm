//%attributes = {}
  //KRL_IsTableRelated

  // ===============================================================================
  // Usuario (OS): abachler
  // Fecha y Hora: 30/07/03, 11:29:49
  // -------------------------------------------------------------------------------
  // Metodo: KRL_IsTableRelated
  // Descripcion
  // 
  //
  // Parametros
  //
  // ===============================================================================



  // DECLARACIONES
  // -------------------------------------------------------------------------------
C_LONGINT:C283($1;$2;$i;$mainTable;$oneTable;$tableID;$oneField;$choiceField)
  //C_BOOLEAN($0;$result;$choiceField)
C_BOOLEAN:C305($0;$result;$autoOne;$autoMany)


  // INICIALIZACIONES
  // -------------------------------------------------------------------------------
$mainTable:=$1
$manyTable:=$2

  // CUERPO DEL METODO
  // -------------------------------------------------------------------------------
For ($i;1;Get last field number:C255($manyTable))
	  //20130321 RCH
	If (Is field number valid:C1000($manyTable;$i))
		  //GET RELATION PROPERTIES($manyTable;$i;$OneTable;$oneField;$choiceField)
		GET RELATION PROPERTIES:C686($manyTable;$i;$OneTable;$oneField;$choiceField;$autoOne;$autoMany)
		If ($mainTable=$oneTable)
			$result:=True:C214
			$i:=Get last field number:C255($mainTable)
		End if 
	End if 
End for 

$0:=$result


  // LIBERACION DE MEMORIA
  // -------------------------------------------------------------------------------


  // FIN DEL METODO
  // -------------------------------------------------------------------------------
