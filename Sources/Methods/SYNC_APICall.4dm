//%attributes = {}
  //SYNC_APICall()
C_TEXT:C284($domain;$urlbase;$url;$rutina;$cUUID;$method)
C_OBJECT:C1216($answer;$contenido;$0;$3)
C_LONGINT:C283($i;$httpStatus;$type)
C_TEXT:C284(${4})

HTTP AUTHENTICATE:C1161("colegium";"@Hj}S)/y/W/W-43$^/J(kT#";HTTP basic:K71:8)
$protocol:="https://"
$domain:="sync-api.colegium.com"
$port:=8443
$urlbase:=$protocol+$domain+":"+String:C10($port)+"/api/"

$rutina:=$1
If (Count parameters:C259>1)
	If ($2="")
		$method:=HTTP GET method:K71:1
	Else 
		$method:=$2
	End if 
Else 
	$method:=HTTP GET method:K71:1
End if 

error:=0
$errmethod:=Method called on error:C704
ON ERR CALL:C155("ERR_GenericOnError")
  //If (INET_IsHostAvailable ($domain;$port))//20180824 RCH Se desactiva a solicitud de JHB
HTTP SET OPTION:C1160(HTTP compression:K71:15;1)
HTTP SET OPTION:C1160(HTTP timeout:K71:10;3)
$url:=$urlbase+$rutina+"/"
If (Count parameters:C259>2)
	If ($method=HTTP GET method:K71:1)
		For ($i;4;Count parameters:C259)
			$url:=$url+${$i}+"/"
		End for 
		$url:=Substring:C12($url;1;Length:C16($url)-1)
		$httpStatus:=HTTP Get:C1157($url;$answer)
	Else 
		$contenido:=$3
		$httpStatus:=HTTP Request:C1158($method;$url;$contenido;$answer)
	End if 
Else 
	$httpStatus:=HTTP Request:C1158($method;$url;$contenido;$answer)
End if 
OB SET:C1220($answer;"status";$httpStatus)
  //Else 
  //OB SET($answer;"ERR";True)
  //OB SET($answer;"MSG";"SYNC API no disponible")
  //End if 
If (error#0)
	OB SET:C1220($answer;"ERR";True:C214)
	OB SET:C1220($answer;"MSG";"SYNC API no disponible")
End if 
ON ERR CALL:C155($errmethod)
$0:=$answer