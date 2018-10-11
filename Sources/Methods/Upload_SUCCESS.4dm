//%attributes = {"invisible":true}
  // Upload_SUCCESS()
  // 
  //
  // creado por: Alberto Bachler Klein: 01-08-16, 09:31:17
  // codigo original de Miyako
  // -----------------------------------------------------------




C_LONGINT:C283($1;$l_procesoLlamante)

$l_procesoLlamante:=$1

<>UPLOAD_STATUS:=1000
OB SET:C1220(ob_Upload_Context;"success";True:C214)
VARIABLE TO VARIABLE:C635($l_procesoLlamante;ob_Upload_Context;ob_Upload_Context)

POST OUTSIDE CALL:C329($l_procesoLlamante)