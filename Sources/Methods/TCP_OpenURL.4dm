//%attributes = {}
  //20140904 RCH Cambios por error en compilado
C_TEXT:C284($url;$1)
C_LONGINT:C283($port;$2;$l_TCPid)
C_POINTER:C301($handler;$3)

$url:=$1
$port:=$2
$handler:=$3

WEB_LoadSettings 
If (<>web_proxy_http_host#"")
	$err:=TCP_Open (<>web_proxy_http_host;Num:C11(<>web_proxy_http_puerto);$l_TCPid)
Else 
	$err:=TCP_Open ($url;$port;$l_TCPid)
End if 

If ($err=0)
	$handler->:=$l_TCPid
End if 

$0:=$err

  //C_TEXT($url)
  //C_LONGINT($port)
  //
  //$url:=$1
  //$port:=$2
  //$handler:=$3
  //
  //WEB_LoadSettings 
  //If (web_proxy_http_host#"")
  //$err:=TCP_Open (web_proxy_http_host;Num(web_proxy_http_puerto);$handler->)
  //Else 
  //$err:=TCP_Open ($url;$port;$handler->)
  //End if 
  //$0:=$err