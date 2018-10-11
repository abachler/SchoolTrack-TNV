//%attributes = {}
  // WEB_SaveSettings()
  // Por: Alberto Bachler K.: 18-06-15, 11:06:59
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)

C_BLOB:C604($x_ConfigServidorHTTP;$x_web_server_https_certDoc;$x_web_server_https_keyDoc)
C_TEXT:C284($t_web_proxy_http_host;$t_web_proxy_http_puerto;$t_web_proxy_https_host;$t_web_proxy_https_puerto;$t_web_server_puertoHTTP;$t_web_server_https_puertoHTTPS)
C_BOOLEAN:C305($b_reiniciarServidor)
C_LONGINT:C283($l_web_server_usarSSL;$OT_Object;$l_web_server_usarSSL)


If (False:C215)
	C_BOOLEAN:C305(WEB_SaveSettings ;$0)
End if 

  // obtengo la configuración previa a la apertura del panel de configuración Red para comparar con los valores al salir
$x_ConfigServidorHTTP:=PREF_fGetBlob (0;"WEB_Settings";$x_ConfigServidorHTTP)
$OT_Object:=OT BLOBToObject ($x_ConfigServidorHTTP)
$t_web_server_puertoHTTP:=OT GetText ($OT_Object;"server_puertoHTTP")
$l_web_server_usarSSL:=OT GetLong ($OT_Object;"server_usarSSL")
$t_web_server_https_puertoHTTPS:=OT GetText ($OT_Object;"server_https_puertoHTTPS")
$x_web_server_https_certDoc:=OT GetNewBLOB ($OT_Object;"server_https_certDoc")
$x_web_server_https_keyDoc:=OT GetNewBLOB ($OT_Object;"server_https_keyDoc")
$t_web_proxy_http_host:=OT GetText ($OT_Object;"proxy_http_host")
$t_web_proxy_http_puerto:=OT GetText ($OT_Object;"proxy_http_puerto")
$t_web_proxy_https_host:=OT GetText ($OT_Object;"proxy_https_host")
$t_web_proxy_https_puerto:=OT GetText ($OT_Object;"proxy_https_puerto")
OT Clear ($OT_Object)

  // si hubo modificaciones en estas variables se debe reiniciar el servidor para tenerlas en cuenta.
Case of 
	: (<>web_server_puertoHTTP#$t_web_server_puertoHTTP)
		$b_reiniciarServidor:=True:C214
	: ($l_web_server_usarSSL#<>web_server_usarSSL)
		$b_reiniciarServidor:=True:C214
	: ($t_web_server_https_puertoHTTPS#<>web_server_https_puertoHTTPS)
		$b_reiniciarServidor:=True:C214
	: (API Compare Blobs ($x_web_server_https_certDoc;<>web_server_https_certDoc)=0)
		$b_reiniciarServidor:=True:C214
	: (API Compare Blobs ($x_web_server_https_keyDoc;<>web_server_https_keyDoc)=0)
		$b_reiniciarServidor:=True:C214
	: ($t_web_proxy_http_host#<>web_proxy_http_host)
		$b_reiniciarServidor:=True:C214
	: ($t_web_proxy_http_puerto#<>web_proxy_http_puerto)
		$b_reiniciarServidor:=True:C214
	: ($t_web_proxy_https_host#<>web_proxy_https_host)
		$b_reiniciarServidor:=True:C214
	: ($t_web_proxy_https_puerto#<>web_proxy_https_puerto)
		$b_reiniciarServidor:=True:C214
End case 
$OT_Object:=OT New 

OT PutText ($OT_Object;"server_puertoHTTP";<>web_server_puertoHTTP)
OT PutLong ($OT_Object;"server_usarSSL";<>web_server_usarSSL)
OT PutText ($OT_Object;"server_https_puertoHTTPS";<>web_server_https_puertoHTTPS)
OT PutBLOB ($OT_Object;"server_https_certDoc";<>web_server_https_certDoc)
OT PutBLOB ($OT_Object;"server_https_keyDoc";<>web_server_https_keyDoc)

OT PutText ($OT_Object;"proxy_http_host";<>web_proxy_http_host)
OT PutText ($OT_Object;"proxy_http_puerto";<>web_proxy_http_puerto)
OT PutText ($OT_Object;"proxy_https_host";<>web_proxy_https_host)
OT PutText ($OT_Object;"proxy_https_puerto";<>web_proxy_https_puerto)
OT PutText ($OT_Object;"proxy_ftp_host";<>web_proxy_ftp_host)
OT PutLong ($OT_Object;"proxy_ftp_issocks";<>web_proxy_ftp_issocks)
OT PutText ($OT_Object;"proxy_ftp_puerto";<>web_proxy_ftp_puerto)
OT PutText ($OT_Object;"proxy_ftp_userid";<>web_proxy_ftp_userid)

OT PutLong ($OT_Object;"ftp_usepassive";<>ftp_UsePassive)

$x_ConfigServidorHTTP:=OT ObjectToNewBLOB ($OT_Object)
OT Clear ($OT_Object)

PREF_SetBlob (0;"WEB_Settings";$x_ConfigServidorHTTP)

$0:=$b_reiniciarServidor