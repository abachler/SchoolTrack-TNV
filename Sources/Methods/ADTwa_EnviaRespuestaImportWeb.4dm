//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 17-03-17, 17:18:15
  // ----------------------------------------------------
  // Método: BM_EnviaRespuestaImportWeb
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_TEXT:C284($t_respuesta;$t_urlPostulaciones;$t_json)
C_LONGINT:C283($l_contador;$l_conexionOK)
C_BLOB:C604($x_blob)

ARRAY TEXT:C222($at_httpHeaderNames;0)
ARRAY TEXT:C222($at_httpHeaderValues;0)

$x_blob:=$1

BLOB_Blob2Vars (->$x_blob;0;->$t_urlPostulaciones;->$t_json)

  //Envio la respuesta de finalización del proceso
APPEND TO ARRAY:C911($at_httpHeaderNames;"content-type")
APPEND TO ARRAY:C911($at_httpHeaderValues;"application/json")

$l_contador:=1
$l_conexionOK:=0

$t_metodoSiError:=Method called on error:C704
ON ERR CALL:C155("WS_ErrorHandler")

While (($l_conexionOK#200) & ($l_contador<=3))
	$l_conexionOK:=HTTP Request:C1158(HTTP POST method:K71:2;$t_urlPostulaciones;$t_json;$t_respuesta;$at_httpHeaderNames;$at_httpHeaderValues)
	$l_contador:=$l_contador+1
End while 

ON ERR CALL:C155($t_metodoSiError)

If ($l_conexionOK#200)
	$0:=False:C215
Else 
	$0:=True:C214
End if 

