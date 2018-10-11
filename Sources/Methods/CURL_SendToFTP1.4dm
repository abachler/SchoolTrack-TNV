//%attributes = {}
  // CURL_SendToFTP()
  //
  //
  // creado por: Alberto Bachler Klein: 09/02/17, 18:22:01
  // MOD Ticket N° 210367 Patricio Aliaga 20180905 Se realiza la implementacion de CallBack a metodo Upload_CALLBACK1
  // -----------------------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_TEXT:C284($5)

C_BLOB:C604($x_in;$x_out)
C_LONGINT:C283($l_error;$l_tamañoDocumento;l_progress)
C_TEXT:C284($t_error;$t_password;$t_rutaDestino;$t_rutaOrigen;$t_usuario;t_mensaje)

ARRAY LONGINT:C221($al_nombreValores;0)
ARRAY TEXT:C222($at_valores;0)

If (False:C215)
	C_TEXT:C284(CURL_SendToFTP ;$0)
	C_TEXT:C284(CURL_SendToFTP ;$1)
	C_TEXT:C284(CURL_SendToFTP ;$2)
	C_TEXT:C284(CURL_SendToFTP ;$3)
	C_TEXT:C284(CURL_SendToFTP ;$4)
End if 

$t_rutaOrigen:=$1
$t_rutaDestino:=$2
$t_usuario:=$3
$t_password:=$4
If (Count parameters:C259>=5)
	t_mensaje:=$5
Else 
	t_mensaje:="Transfiriendo datos...\n"
End if 

$l_tamañoDocumento:=Get document size:C479($t_rutaOrigen)

APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_USERNAME)
APPEND TO ARRAY:C911($at_valores;$t_usuario)
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_PASSWORD)
APPEND TO ARRAY:C911($at_valores;$t_password)
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_READDATA)
APPEND TO ARRAY:C911($at_valores;$t_rutaOrigen)
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_XFERINFOFUNCTION)
APPEND TO ARRAY:C911($at_valores;"Upload_CALLBACK1")
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_XFERINFODATA)
APPEND TO ARRAY:C911($at_valores;String:C10($l_tamañoDocumento))
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_UPLOAD)
APPEND TO ARRAY:C911($at_valores;"1")
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_USE_SSL)
APPEND TO ARRAY:C911($at_valores;"1")
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_SSL_VERIFYPEER)
APPEND TO ARRAY:C911($at_valores;"0")
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_SSL_VERIFYHOST)
APPEND TO ARRAY:C911($at_valores;"0")
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_FTP_CREATE_MISSING_DIR)
APPEND TO ARRAY:C911($at_valores;"1")
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_FTP_RESPONSE_TIMEOUT)
APPEND TO ARRAY:C911($at_valores;"127")
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_FTP_SKIP_PASV_IP)
APPEND TO ARRAY:C911($at_valores;"1")

l_progress:=IT_Progress (1;0;0;t_mensaje)

$l_error:=cURL ($t_rutaDestino;$al_nombreValores;$at_valores;$x_in;$x_out)

l_progress:=IT_Progress (-1;l_progress)

If ($l_error#0)
	$t_error:="Error en carga hacia el FTP mediante CURL Nº"+String:C10($l_error)
	LOG_RegisterEvt ($t_error)
End if 

CLEAR VARIABLE:C89(l_progress)
CLEAR VARIABLE:C89(t_mensaje)

$0:=$l_error