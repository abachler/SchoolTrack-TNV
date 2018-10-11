//%attributes = {"executedOnServer":true}
  // KRL_SendFileToServer()
  //
  //
  // creado por: Alberto Bachler Klein: 28-12-16, 15:40:03
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_BLOB:C604($2)
C_BOOLEAN:C305($3)

C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_esRutaAbsoluta)
C_TEXT:C284($t_error;$t_metodoOnErr;$t_rutaDocumento;$t_rutaDocumentoServidor)




If (False:C215)
	C_TEXT:C284(KRL_SendFileToServer ;$0)
	C_TEXT:C284(KRL_SendFileToServer ;$1)
	C_BLOB:C604(KRL_SendFileToServer ;$2)
	C_BOOLEAN:C305(KRL_SendFileToServer ;$3)
End if 

$t_rutaDocumento:=$1
$t_rutaDocumento:=Replace string:C233($t_rutaDocumento;":";Folder separator:K24:12)
$t_rutaDocumento:=Replace string:C233($t_rutaDocumento;"\\";Folder separator:K24:12)
If (SYS_IsWindows )
	$t_rutaDocumento:=Replace string:C233($t_rutaDocumento;"\\\\";":\\")
End if 
$x_blob:=$2

If (Count parameters:C259=3)
	$b_esRutaAbsoluta:=$3
Else 
	$b_esRutaAbsoluta:=False:C215
End if 


$t_metodoOnErr:=Method called on error:C704
ON ERR CALL:C155("ERR_GenericOnError")

If (Not:C34($b_esRutaAbsoluta))
	$t_rutaDocumentoServidor:=SYS_GetServerProperty (XS_StructureFolder)+$t_rutaDocumento
Else 
	$t_rutaDocumentoServidor:=$t_rutaDocumento
End if 

  // Modificado por: Saúl Ponce (20-02-2017) - Ticket Nº 175361 Para que se cree la carpeta que contendrá las cartas de cobranza y no un directorio
  // SYS_CreateFolder ($t_rutaDocumentoServidor)

  // Modificado por: Saúl Ponce (09-04-2018) - Alberto B, por e-mail, indica que realizar la creación de la ruta en este punto es erróneo.
  // $parentH:=SYS_GetParentNme ($t_rutaDocumentoServidor) 
  // SYS_CreateFolder ($parentH)

If (Test path name:C476($t_rutaDocumentoServidor)=1)
	DELETE DOCUMENT:C159($t_rutaDocumentoServidor)
End if 

$h_refDoc:=Create document:C266($t_rutaDocumentoServidor)
CLOSE DOCUMENT:C267($h_refDoc)
BLOB TO DOCUMENT:C526($t_rutaDocumentoServidor;$x_blob)

If (error#0)
	$t_error:=ERR_LogExecutionError 
End if 

ON ERR CALL:C155($t_metodoOnErr)

$0:=$t_error


EM_ErrorManager ("Clear")

