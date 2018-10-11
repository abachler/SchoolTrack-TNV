//%attributes = {"invisible":true}
  // Upload_CANCEL()
  // 
  //
  // creado por: Alberto Bachler Klein: 17-08-16, 19:36:02
  // -----------------------------------------------------------
C_LONGINT:C283($1;$l_procesoLlamante)
C_OBJECT:C1216(ob_Upload_Context)

$l_procesoLlamante:=$1

OB SET:C1220(ob_Upload_Context;"success";False:C215)
VARIABLE TO VARIABLE:C635($l_procesoLlamante;ob_Upload_Context;ob_Upload_Context)

C_TEXT:C284($t_rutaDestino)
$t_rutaDestino:=OB Get:C1224(ob_Upload_Context;"dstPath")

POST OUTSIDE CALL:C329($l_procesoLlamante)