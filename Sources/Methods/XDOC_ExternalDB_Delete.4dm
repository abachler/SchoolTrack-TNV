//%attributes = {"executedOnServer":true}
  // MÉTODO: XDOC_ExternalDB_Delete
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 08/03/11, 10:54:03
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // XDOC_ExternalDB_Delete()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_TEXT:C284($dataBaseFolder;$dbPath;$externalDBPath)

  // CODIGO PRINCIPAL
$dataBaseFolder:=SYS_GetParentNme (Data file:C490)+"xDocuments"
$externalDBPath:=XDOC_ExternalDB_GetPath 

Begin SQL
	USE DATABASE DATAFILE <<$externalDBPath>> AUTO_CLOSE;
	USE LOCAL DATABASE SQL_INTERNAL;
End SQL

SYS_DeleteFolder ($dataBaseFolder)

