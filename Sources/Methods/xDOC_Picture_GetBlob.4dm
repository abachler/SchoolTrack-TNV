//%attributes = {"executedOnServer":true}
  // MÉTODO: xDOC_Picture_GetBlob
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 08/03/11, 09:03:04
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // xDOC_Picture_GetBlob()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_BLOB:C604($xblob;$0)
C_TEXT:C284($UUIDref;$1)
Error:=0
$UUIDref:=$1

  // CODIGO PRINCIPAL
ON ERR CALL:C155("EM_GenericInterruption")
$externalDBPath:=XDOC_ExternalDB_GetPath 


Begin SQL
	USE DATABASE DATAFILE <<$externalDBPath>>;
	SELECT xPicture
	FROM Pictures
	WHERE MainDBRef=:$UUIDref
	INTO :$xBlob;
End SQL

If (Error=0)
	$0:=$xBlob
End if 

ON ERR CALL:C155("")