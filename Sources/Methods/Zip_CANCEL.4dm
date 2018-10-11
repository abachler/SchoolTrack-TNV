//%attributes = {"invisible":true}
  // Zip_CANCEL()
  //
  //
  // creado por: Alberto Bachler Klein: 26-07-16, 18:43:03
  // codigo original de Miyako
  // -----------------------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_LONGINT:C283($l_procesoLlamante)
C_TEXT:C284($t_error;$t_rutaDestino)


If (False:C215)
	C_LONGINT:C283(Zip_CANCEL ;$1)
	C_TEXT:C284(Zip_CANCEL ;$2)
End if 

C_OBJECT:C1216(ob_ZIP_Context)

$l_procesoLlamante:=$1
$t_error:=$2

OB SET:C1220(ob_ZIP_Context;"success";False:C215)
OB SET:C1220(ob_ZIP_Context;"error";$t_error)
VARIABLE TO VARIABLE:C635($l_procesoLlamante;ob_ZIP_Context;ob_ZIP_Context)

$t_rutaDestino:=OB Get:C1224(ob_ZIP_Context;"dstPath")

SYS_DeleteFileOrFolder ($t_rutaDestino)

POST OUTSIDE CALL:C329($l_procesoLlamante)