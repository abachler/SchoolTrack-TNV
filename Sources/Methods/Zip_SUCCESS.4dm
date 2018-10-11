//%attributes = {"invisible":true}
  // Zip_SUCCESS()
  //
  //
  // creado por: Alberto Bachler Klein: 26-07-16, 19:58:34
  // codigo original de Miyako
  // -----------------------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($l_procesoLLamante)
C_TEXT:C284($t_error;$t_rutaArchivoOriginal)


If (False:C215)
	C_LONGINT:C283(Zip_SUCCESS ;$1)
End if 
C_OBJECT:C1216(ob_ZIP_Context)


$l_procesoLLamante:=$1
$t_error:=""

$t_rutaArchivoOriginal:=OB Get:C1224(ob_ZIP_Context;"srcPath")

OB SET:C1220(ob_ZIP_Context;"success";True:C214)
OB SET:C1220(ob_ZIP_Context;"error";$t_error)
OB SET:C1220(ob_ZIP_Context;"compressedFilePath";$t_rutaArchivoOriginal)
VARIABLE TO VARIABLE:C635($l_procesoLLamante;ob_ZIP_Context;ob_ZIP_Context)

POST OUTSIDE CALL:C329($l_procesoLLamante)


