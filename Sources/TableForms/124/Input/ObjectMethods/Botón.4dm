$t_nombreDocumento:="AC_"+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1)+".pdf"

$t_rutaServer:=SYS_CarpetaAplicacion (CLG_ArchivosAsociados)+"AvisosPDF"+SYS_FolderDelimiterOnServer 
$t_rutaServer:=$t_rutaServer+$t_nombreDocumento  //20170228 RCH
If (Application type:C494=4D Remote mode:K5:5)
	$t_rutaLocal:=Temporary folder:C486+$t_nombreDocumento
	SYS_DeleteFile ($t_rutaLocal)
	$t_error:=KRL_CopyFileFromServer ($t_rutaServer;$t_rutaLocal)
Else 
	$t_rutaLocal:=$t_rutaServer
End if 
If (Test path name:C476($t_rutaLocal)=Is a document:K24:1)
	OPEN URL:C673($t_rutaLocal;*)
Else 
	CD_Dlog (0;__ ("No se ha generado un archivo PDF para este aviso de cobranza o el archivo no puede ser localizado."))
End if 
