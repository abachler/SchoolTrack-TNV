//%attributes = {"shared":true,"executedOnServer":true}
  // VC4D_ReadConfigFile()
  //
  //
  // creado por: Alberto Bachler Klein: 05-02-16, 10:58:04
  // -----------------------------------------------------------
C_OBJECT:C1216($0)

C_BLOB:C604($x_blob)
C_TEXT:C284($t_rutaConfigFile)
C_OBJECT:C1216($ob_config)


If (False:C215)
	C_OBJECT:C1216(VC4D_ReadConfigFile ;$0)
End if 

$t_rutaConfigFile:=Get 4D folder:C485(Database folder:K5:14)+"VC4D"+Folder separator:K24:12+"vc4d.config"
If (Test path name:C476($t_rutaConfigFile)=Is a document:K24:1)
	DOCUMENT TO BLOB:C525($t_rutaConfigFile;$x_blob)
	BLOB TO VARIABLE:C533($x_blob;$ob_config)
Else 
	VARIABLE TO BLOB:C532($ob_config;$x_blob)
	BLOB TO DOCUMENT:C526($t_rutaConfigFile;$x_blob)
End if 

$0:=$ob_config








