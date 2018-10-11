//%attributes = {}
  //KRL_RecordExists

  // ===============================================================================
  // Usuario (OS): abachler
  // Fecha y Hora: 16/07/03, 18:00:48
  // -------------------------------------------------------------------------------
  // Metodo: KRL_RecordExists
  // Descripcion
  // 
  //
  // Parametros
  //
  // ===============================================================================



  // DECLARACIONES
  // -------------------------------------------------------------------------------
C_POINTER:C301($1;$fieldPointer;$tablePointer)
C_BOOLEAN:C305($0;$indexed)
C_LONGINT:C283($i;$fieldType;$length)

  // INICIALIZACIONES
  // -------------------------------------------------------------------------------
$0:=False:C215
$fieldPointer:=$1
$tablepointer:=Table:C252(Table:C252($fieldPointer))
GET FIELD PROPERTIES:C258($fieldPointer;$fieldType;$length;$indexed)


  // CUERPO DEL METODO
  // -------------------------------------------------------------------------------
If ($fieldPointer->#Old:C35($fieldPointer->))
	If ($indexed)
		$recNumFounded:=Find in field:C653($fieldPointer->;$fieldPointer->)
		$0:=($recNumFounded>=0)
	Else 
		SET QUERY DESTINATION:C396(Into variable:K19:4;$records)
		SET QUERY LIMIT:C395(1)  //we only need to know if ONE record exist
		QUERY:C277($tablepointer->;$fieldpointer->;=;$fieldpointer->)
		SET QUERY LIMIT:C395(0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		$0:=($records>0)
	End if 
End if 


  // LIBERACION DE MEMORIA
  // -------------------------------------------------------------------------------


  // FIN DEL METODO
  // -------------------------------------------------------------------------------
