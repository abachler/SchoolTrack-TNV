//%attributes = {"executedOnServer":true}
  // MÉTODO: XDOC_ExternalDB_GetPath
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 08/03/11, 09:53:01
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Devuelve la ruta completa de la base de datos externa xDocuments
  // Si no existe la crea mediante llamado a XDOC_ExternalDB_Create
  // 
  // PARÁMETROS
  // XDOC_ExternalDB_GetPath()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_TEXT:C284($dataBaseFolder;$dbPath;$externalDBPath)
$dataBaseFolder:=SYS_GetParentNme (Data file:C490)+"xDocuments"
$externalDBPath:=$dataBaseFolder+Folder separator:K24:12+"xDocs"
$dbPath:=$externalDBPath+".4DB"

  // CODIGO PRINCIPAL

If (Test path name:C476($dbPath)#Is a document:K24:1)
	OK:=SYS_CreateFolder ($dataBaseFolder)
	If (OK=1)
		$error:=XDOC_ExternalDB_Create ($externalDBPath)
	Else 
		$error:=0
	End if 
Else 
	$error:=0
End if 

If ($error=0)
	$0:=$dbPath
End if 