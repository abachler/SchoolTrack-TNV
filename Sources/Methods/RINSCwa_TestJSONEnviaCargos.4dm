//%attributes = {}
  //RINSCwa_TestJSONEnviaCargos 




C_LONGINT:C283($l_idApp)
C_TEXT:C284($t_err;$t_llavePrivada;$t_parametro;$t_hash;$node;$t_principal;$0;$json;$t_anio)
C_BLOB:C604($blob)

$l_idApp:=4
$t_llavePrivada:="79694f50d2e1bc9a0630524218056bd426a90f775ea1b025a09b51e5ec5c51e0"
$t_parametro:=Generate UUID:C1066

  //CONVERT FROM TEXT($t_llavePrivada+$t_parametro;"utf-8";$blob)
CONVERT FROM TEXT:C1011($t_parametro+$t_llavePrivada;"utf-8";$blob)  //20170822 RCH
$t_hash:=SHA512 ($blob;Crypto HEX)


  // Modificado por: Alexis Bustamante (10-06-2017)
  //ticket 179869 


C_OBJECT:C1216($ob_raiz;$ob_autenticacion)

$ob_raiz:=OB_Create 
$ob_autenticacion:=OB_Create 
$t_anio:="2016"

OB_SET ($ob_autenticacion;->$l_idApp;"aplicacion")
OB_SET ($ob_autenticacion;->$t_hash;"llave")
OB_SET ($ob_autenticacion;->$t_parametro;"parametro")


OB_SET ($ob_raiz;->$ob_autenticacion;"autenticacion")
OB_SET ($ob_raiz;->$t_anio;"anio")
$json:=OB_Object2Json ($ob_raiz)


  //$t_principal:=JSON New 
  //  //$t_err:=JSON Append node ($t_principal;"autenticacion")
  //  //$node:=JSON Append long ($t_err;"aplicacion";$l_idApp)
  //  //$node:=JSON Append text ($t_err;"llave";$t_hash)
  //  //$node:=JSON Append text ($t_err;"parametro";$t_parametro)
  //$t_err:=JSON Append text ($t_principal;"anio";"2016")

  //If (False)
  //$json:=JSON Export to text ($t_principal;JSON_WITH_WHITE_SPACE)
  //SET TEXT TO PASTEBOARD($json)
  //Else 
  //$json:=JSON Export to text ($t_principal;JSON_WITHOUT_WHITE_SPACE)
  //End if 
  //JSON CLOSE ($t_principal)

$0:=$json