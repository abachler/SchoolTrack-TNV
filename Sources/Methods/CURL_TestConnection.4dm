//%attributes = {}
  // CURL_TestConnection()
  //
  //
  // creado por: Alberto Bachler Klein: 09/02/17, 19:34:47
  // -----------------------------------------------------------
C_TEXT:C284($t_password;$t_rutaDestino;$t_rutaOrigen;$t_usuario)

ARRAY LONGINT:C221($al_nombreValores;0)
ARRAY TEXT:C222($at_valores;0)

SN3_FTP_Server:="ftp.colegium.com"
SN3_FTP_User:="abachler"
SN3_FTP_Password:="gamine"

$t_usuario:=SN3_FTP_User
$t_password:=SN3_FTP_Password
$t_rutaDestino:="ftp://"+SN3_FTP_Server

APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_USERNAME)
APPEND TO ARRAY:C911($at_valores;$t_usuario)
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_PASSWORD)
APPEND TO ARRAY:C911($at_valores;$t_password)
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_CONNECT_ONLY)
APPEND TO ARRAY:C911($at_valores;"1")
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_USE_SSL)
APPEND TO ARRAY:C911($at_valores;"1")
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_SSL_VERIFYPEER)
APPEND TO ARRAY:C911($at_valores;"0")
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_SSL_VERIFYHOST)
APPEND TO ARRAY:C911($at_valores;"0")
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_FTP_RESPONSE_TIMEOUT)
APPEND TO ARRAY:C911($at_valores;"127")
APPEND TO ARRAY:C911($al_nombreValores;CURLOPT_FTPPORT)
APPEND TO ARRAY:C911($at_valores;Choose:C955(<>ftp_UsePassive=0;"0";"NULL"))

$l_error:=cURL ($t_rutaDestino;$al_nombreValores;$at_valores;$x_in;$x_out)

$0:=$l_error