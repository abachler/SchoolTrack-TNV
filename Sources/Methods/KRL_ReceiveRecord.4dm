//%attributes = {}
  //KRL_ReceiveRecord


  // ----------------------------------------------------
  // Usuario (SO): Alberto Bachler
  // Fecha y hora: 24/09/09, 08:49:44
  // ----------------------------------------------------
  // Método: KRL_ReceiveRecord
  // Descripción
  //    Lee el registro desde un documento
  //    Si $2=TRUE  el registro es leido desde un blob
  //    Si $2=FALSE el registro es leido directamente en formato 4D
  // Parámetros
  // ----------------------------------------------------


C_BLOB:C604($blob)
C_POINTER:C301($tablePointer;$1)
C_BOOLEAN:C305($use_ApiPack)

$tablePointer:=$1
If (Count parameters:C259=2)
	$use_ApiPack:=$2
End if 


If ($use_ApiPack)
	CREATE RECORD:C68($tablePointer->)
	RECEIVE VARIABLE:C81($blob)
	$err:=API Blob To Record (Table:C252($tablePointer);$blob)
Else 
	RECEIVE RECORD:C79($tablePointer->)
End if 