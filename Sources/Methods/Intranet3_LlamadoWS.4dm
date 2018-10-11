//%attributes = {}
  //Intranet3_LlamadoWS - MONO, ADRIÁN
  //1 nombre del servicio
  //2 json con los parámetros del WS
  //0 json de respuesta de la intranet

  //20180126 RCH Se prepara metodo para recibir parámetros de encabezado ya que no funciona para servicio que retorna la versión

C_TEXT:C284($1;$2;$body_t;$response;$t_url;$body_t)
C_POINTER:C301($4;$5)  //encabezados
C_LONGINT:C283($httpStatus_l;$0)
C_TEXT:C284(vWS_NationalID;$ws_name;$llave)
C_BLOB:C604($llave_utf8)
ARRAY TEXT:C222($at_httpHeaderNames;0)
ARRAY TEXT:C222($at_httpHeaderValues;0)

C_TEXT:C284($t_metodoSiError)

$ws_name:=$1
$body_t:=$2

$key:="e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
$llave:=$key+$ws_name
CONVERT FROM TEXT:C1011($llave;"utf-8";$llave_utf8)
$url:=SHA512 ($llave_utf8;Crypto HEX)
$url:="https://serviciosintranet.colegium.com/servicios/"+$ws_name+"/"+$url
$t_url:=$url

  //20160308 RCH Cambios para devolver tb el codigo http y atrapar los posibles errores
  //$at_httpHeaderNames{1}:="content-type"
  //$at_httpHeaderValues{1}:="application/json"

  //$httpStatus_l:=HTTP Request(HTTP POST method;$t_url;$body_t;$response;$at_httpHeaderNames;$at_httpHeaderValues)
  //If ($httpStatus_l>200)
  //$response:="Error "+String($httpStatus_l)
  //End if 

  //$0:=$response
$t_metodoSiError:=Method called on error:C704
ON ERR CALL:C155("WS_ErrorHandler")

If (Count parameters:C259<=3)
	APPEND TO ARRAY:C911($at_httpHeaderNames;"content-type")
	APPEND TO ARRAY:C911($at_httpHeaderValues;"application/json")
Else 
	COPY ARRAY:C226($4->;$at_httpHeaderNames)
	COPY ARRAY:C226($5->;$at_httpHeaderValues)
End if 

$httpStatus_l:=HTTP Request:C1158(HTTP POST method:K71:2;$t_url;$body_t;$response;$at_httpHeaderNames;$at_httpHeaderValues)

If (Count parameters:C259>=3)
	$3->:=$response
End if 

ON ERR CALL:C155($t_metodoSiError)

$0:=$httpStatus_l