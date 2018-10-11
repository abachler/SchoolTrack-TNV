//%attributes = {}
  // SYS_DeleteFile()
  // 
  //
  // creado por: Alberto Bachler Klein: 13/02/17, 16:50:41
  // -----------------------------------------------------------
$t_rutaDocumento:=$1

If (Test path name:C476($t_rutaDocumento)=Is a document:K24:1)
	DELETE DOCUMENT:C159($t_rutaDocumento)
End if 