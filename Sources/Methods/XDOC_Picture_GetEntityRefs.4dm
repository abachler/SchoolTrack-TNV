//%attributes = {"executedOnServer":true}
  // MÉTODO: XDOC_Picture_GetEntityRefs
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 09/03/11, 08:40:35
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // XDOC_Picture_GetEntityRefs()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_BLOB:C604($xblob;$0)
C_TEXT:C284($entityRef;$1)
ARRAY TEXT:C222($aUUIDrefs;0)
Error:=0
$entityRef:=$1

  // CODIGO PRINCIPAL
ON ERR CALL:C155("EM_GenericInterruption")
$externalDBPath:=XDOC_ExternalDB_GetPath 


Begin SQL
	USE DATABASE DATAFILE <<$externalDBPath>>;
	SELECT MainDBRef
	FROM Pictures
	WHERE EntityRef=:$entityRef
	INTO :$aUUIDrefs;
End SQL

BLOB_Variables2Blob (->$xBlob;0;->$aUUIDrefs)

If (Error=0)
	$0:=$xBlob
End if 

ON ERR CALL:C155("")