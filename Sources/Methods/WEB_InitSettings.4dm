//%attributes = {}
C_TEXT:C284(<>web_server_puertoHTTP)
C_LONGINT:C283(<>web_server_usarSSL)

C_TEXT:C284(<>web_server_https_puertoHTTPS)
C_BLOB:C604(<>web_server_https_certDoc;<>web_server_https_keyDoc)

C_TEXT:C284(<>web_proxy_http_host;<>web_proxy_http_puerto;<>web_proxy_https_host;<>web_proxy_https_puerto;<>web_proxy_ftp_host)
C_LONGINT:C283(<>web_proxy_ftp_issocks)
C_TEXT:C284(<>web_proxy_ftp_puerto;<>web_proxy_ftp_userid)

C_LONGINT:C283(<>ftp_UsePassive)

<>web_server_puertoHTTP:="80"
<>web_server_usarSSL:=0
<>web_server_https_puertoHTTPS:="443"
SET BLOB SIZE:C606(<>web_server_https_certDoc;0)
SET BLOB SIZE:C606(<>web_server_https_keyDoc;0)

<>web_proxy_http_host:=""
<>web_proxy_http_puerto:=""
<>web_proxy_https_host:=""
<>web_proxy_https_puerto:=""
<>web_proxy_ftp_host:=""
<>web_proxy_ftp_issocks:=0
<>web_proxy_ftp_puerto:=""
<>web_proxy_ftp_userid:=""

<>ftp_UsePassive:=1