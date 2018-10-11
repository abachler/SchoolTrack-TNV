//%attributes = {"executedOnServer":true}
  //Metodo: xDoc_StoreDocument
  //Por abachler
  //Creada el 26/06/2008, 20:11:07
  // ----------------------------------------------------
  // Descripción
  // Este método es llamado desde un cliente pero se ejecuta en el servidor 
  // Almacena en la ruta indicada en $1 un documento contenido en el blob pasado en $2
  // ----------------------------------------------------
  // Parámetros
  // 
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES
C_TEXT:C284($1;$path;$4;$fileType;$5;$fileCreator)
C_POINTER:C301($blobPointer)
C_BOOLEAN:C305($6;$isStream;$7;$openDocument;$8;$closeDocument;$3;$invisible)

$path:=$1
$blobPointer:=$2

$path:=Replace string:C233($path;":";Folder separator:K24:12)
$path:=Replace string:C233($path;"\\";Folder separator:K24:12)
If (SYS_IsWindows )
	$path:=Replace string:C233($path;"\\\\";":\\")
End if 


  //CUERPO
$fileType:=Replace string:C233($fileType;Char:C90(0);"")
$fileCreator:=Replace string:C233($fileCreator;Char:C90(0);"")

$parentH:=SYS_GetParentNme ($path)
SYS_CreatePath ($parentH)

$ref:=Create document:C266($path;$fileType)
CLOSE DOCUMENT:C267($ref)
BLOB TO DOCUMENT:C526(document;$blobPointer->)


error:=0
If (error=-16001)
	$0:=1
Else 
	$0:=0
End if 


  //LIMPIEZA




