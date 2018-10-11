//%attributes = {"executedOnServer":true}
  // VC4D_SaveConfigFile()
  // 
  //
  // creado por: Alberto Bachler Klein: 05-02-16, 11:16:49
  // -----------------------------------------------------------

$ob_config:=$1

$t_rutaConfigFile:=Get 4D folder:C485(Database folder:K5:14)+"VC4D"+Folder separator:K24:12+"vc4d.config"
VARIABLE TO BLOB:C532($ob_config;$x_blob)
BLOB TO DOCUMENT:C526($t_rutaConfigFile;$x_blob)

