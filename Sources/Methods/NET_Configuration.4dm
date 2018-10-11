//%attributes = {}
  //NET_Configuration

C_TEXT:C284($1;$vt_action;$2;$aplicacion)
C_POINTER:C301($ptr)
$vt_action:=$1

$aplicacion:="CMT"
If (Count parameters:C259=2)
	$aplicacion:=$2
End if 
CMT_FTP_Settings ($vt_action;$ptr;$aplicacion)
NET_PROXY_Settings ($vt_action)