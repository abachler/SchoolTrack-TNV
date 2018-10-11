//%attributes = {"executedOnServer":true}
  // MÉTODO: xDOC_Picture_StoreBlob
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 08/03/11, 09:55:34
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // xDOC_Picture_StoreBlob()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_TEXT:C284($1;$UUIDref;$2;$entityRef;$foundedUUID)
C_BLOB:C604($xblob;$3)
C_LONGINT:C283($0)
$UUIDref:=$1
$entityRef:=$2
$xblob:=$3


  // CODIGO PRINCIPAL
Error:=0
ON ERR CALL:C155("EM_GenericInterruption")

$externalDBPath:=XDOC_ExternalDB_GetPath 

Begin SQL
	USE DATABASE DATAFILE <<$externalDBPath>>;
	SELECT MainDBRef
	FROM Pictures
	WHERE MainDBRef=:$UUIDref
	INTO :$foundedUUID;
End SQL

If ($foundedUUID="")
	Begin SQL
		INSERT INTO Pictures (MainDBRef,xPicture,EntityRef)
		Values (:$UUIDref, :$xblob, :$entityRef);
	End SQL
Else 
	Begin SQL
		UPDATE Pictures
		SET xPicture=:$xblob, EntityRef=:$entityRef
		WHERE MainDBRef=:$UUIDref;
	End SQL
End if 

Begin SQL
	USE LOCAL DATABASE SQL_INTERNAL;
End SQL


ON ERR CALL:C155("")
$0:=ERROR
