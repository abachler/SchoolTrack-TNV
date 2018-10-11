//%attributes = {"executedOnServer":true}
  // SYS_DeleteFileOnServer (rutaDocumento:T) --> resultado:B
  // Elimina el documento rutaDocumento. Devuelve True en resultado y OK toma el valor 1 si el documento es eliminado
  // o si no existe
  //
  // creado por: Alberto Bachler Klein: 26-12-16, 10:42:13
  // -----------------------------------------------------------
C_BOOLEAN:C305($0)
C_TEXT:C284($1)

C_TEXT:C284($t_rutaDocumento)


If (False:C215)
	C_BOOLEAN:C305(SYS_DeleteFileOnServer ;$0)
	C_TEXT:C284(SYS_DeleteFileOnServer ;$1)
End if 

$t_rutaDocumento:=$1

$t_rutaDocumento:=Replace string:C233($t_rutaDocumento;":";Folder separator:K24:12)
$t_rutaDocumento:=Replace string:C233($t_rutaDocumento;"\\";Folder separator:K24:12)
If (SYS_IsWindows )
	$t_rutaDocumento:=Replace string:C233($t_rutaDocumento;"\\\\";":\\")
End if 

OK:=1
If (Test path name:C476($t_rutaDocumento)=Is a document:K24:1)
	DELETE DOCUMENT:C159($t_rutaDocumento)
End if 
$0:=(OK=1)