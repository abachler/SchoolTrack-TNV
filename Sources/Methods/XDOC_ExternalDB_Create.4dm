//%attributes = {"executedOnServer":true}
  // MÉTODO: XDOC_ExternalDB_Create
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 08/03/11, 09:51:33
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Crea la base de datos externa xDocuments en la carpeta en que se encuentra la base de datos HOST
  //
  // PARÁMETROS
  // XDOC_ExternalDB_Create()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_TEXT:C284($1;$externalDBPath)
C_LONGINT:C283($0)

Error:=0


  // CODIGO PRINCIPAL
ON ERR CALL:C155("EM_GenericInterruption")

$externalDBPath:=$1
Begin SQL
	CREATE DATABASE IF NOT EXISTS DATAFILE <<$externalDBPath>>;
	USE DATABASE DATAFILE <<$externalDBPath>>;
	
	CREATE TABLE IF NOT EXISTS Pictures
	(MainDBRef UUID, 
	EntityRef VARCHAR(6), 
	xPicture Blob);
	CREATE INDEX IDX_Pict_MainDBRef on Pictures (MainDBRef);
	CREATE INDEX IDX_Pict_EntityRef on Pictures (EntityRef);
	
	CREATE TABLE IF NOT EXISTS Documents
	(MainDBRef UUID, 
	EntityRef VARCHAR(6), 
	xDocument BLOB);
	CREATE INDEX IDX_Doc_MainDBRef on Documents (MainDBRef);
	CREATE INDEX IDX_Doc_EntityRef on Documents (EntityRef);
	
	USE LOCAL DATABASE SQL_INTERNAL
End SQL

ON ERR CALL:C155("")
$0:=Error
