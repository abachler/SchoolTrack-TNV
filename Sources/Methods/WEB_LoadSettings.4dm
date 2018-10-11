//%attributes = {}
C_BLOB:C604($webSettings)

  //==========  CREAMOS UNA CONFIGURACION GENERICA PARA LA PRIMERA VEZ  ==========

WEB_InitSettings 

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

$webSettings:=OT ObjectToNewBLOB ($OT_Object)
OT Clear ($OT_Object)

  //==========  FIN CONFIG. GENERICA  ==========

$webSettings:=PREF_fGetBlob (0;"WEB_Settings";$webSettings)

$OT_Object:=OT BLOBToObject ($webSettings)

<>web_server_puertoHTTP:=OT GetText ($OT_Object;"server_puertoHTTP")
<>web_server_usarSSL:=OT GetLong ($OT_Object;"server_usarSSL")
<>web_server_https_puertoHTTPS:=OT GetText ($OT_Object;"server_https_puertoHTTPS")
<>web_server_https_certDoc:=OT GetNewBLOB ($OT_Object;"server_https_certDoc")
<>web_server_https_keyDoc:=OT GetNewBLOB ($OT_Object;"server_https_keyDoc")

<>web_proxy_http_host:=OT GetText ($OT_Object;"proxy_http_host")
<>web_proxy_http_puerto:=OT GetText ($OT_Object;"proxy_http_puerto")
<>web_proxy_https_host:=OT GetText ($OT_Object;"proxy_https_host")
<>web_proxy_https_puerto:=OT GetText ($OT_Object;"proxy_https_puerto")
<>web_proxy_ftp_host:=OT GetText ($OT_Object;"proxy_ftp_host")
<>web_proxy_ftp_issocks:=OT GetLong ($OT_Object;"proxy_ftp_issocks")
<>web_proxy_ftp_puerto:=OT GetText ($OT_Object;"proxy_ftp_puerto")
<>web_proxy_ftp_userid:=OT GetText ($OT_Object;"proxy_ftp_userid")

  //<>ftp_UsePassive:=OT GetLong ($OT_Object;"ftp_usepassive")
<>ftp_UsePassive:=1  //20170520 RCH. Se cambia a pedido de JHB

OT Clear ($OT_Object)


If (<>web_proxy_ftp_host#"")
	$err:=IT_SetProxy (1;<>web_proxy_ftp_issocks;<>web_proxy_ftp_host;Num:C11(<>web_proxy_ftp_puerto);<>web_proxy_ftp_userid)
End if 