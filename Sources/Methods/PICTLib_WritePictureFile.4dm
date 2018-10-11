//%attributes = {"executedOnServer":true}
  // PICTLib_WritePictureFile()
  // 
  //
  // creado por: Alberto Bachler Klein: 07-09-16, 11:15:36
  // -----------------------------------------------------------

$t_ruta:=$1
$p_imagen:=$2

$t_rutaExterna:=Get 4D folder:C485(Database folder:K5:14)+Replace string:C233($t_ruta;"/";Folder separator:K24:12)
$t_rutaExterna:=Replace string:C233($t_rutaExterna;Folder separator:K24:12+Folder separator:K24:12;Folder separator:K24:12)
CREATE FOLDER:C475($t_rutaExterna;*)

If (Test path name:C476($t_rutaExterna)=Is a document:K24:1)
	DELETE DOCUMENT:C159($t_rutaExterna)
End if 

WRITE PICTURE FILE:C680($t_rutaExterna;$p_imagen)

