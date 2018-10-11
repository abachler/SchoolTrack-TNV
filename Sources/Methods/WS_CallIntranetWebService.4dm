//%attributes = {}
  // WS_CallIntranetWebService()
  // Por: Alberto Bachler K.: 30-07-14, 10:13:27
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_BOOLEAN:C305($2)

C_BOOLEAN:C305($b_ForzarIntranet2)
C_LONGINT:C283($l_timeOut)
C_TEXT:C284($t_metodo;$t_metodoSiError;$t_nameSpaceIntranet;$t_soapActionIntranet;$t_URLintranet)


If (False:C215)
	C_TEXT:C284(WS_CallIntranetWebService ;$0)
	C_TEXT:C284(WS_CallIntranetWebService ;$1)
	C_BOOLEAN:C305(WS_CallIntranetWebService ;$2)
End if 

C_TEXT:C284(vtWS_ErrorNum;vtWS_ErrorString)

$t_metodo:=$1
If (Count parameters:C259=2)
	$b_ForzarIntranet2:=$2
End if 

vtWS_ErrorNum:=""
vtWS_ErrorString:=""

$t_metodoSiError:=Method called on error:C704
ON ERR CALL:C155("WS_ErrorHandler")

$t_URLintranet:="https://intranet.colegium.com/4DSOAP/"
$t_soapActionIntranet:="SchoolNetII_WebServices"
$t_nameSpaceIntranet:="https://intranet.colegium.com/namespace_SchoolNetII"
$l_timeOut:=30

$b_conectado:=INET_IsHostAvailable ("intranet.colegium.com";0;2)
If ((Not:C34($b_conectado)) & ($b_ForzarIntranet2))
	$t_URLintranet:="http://intranet2.colegium.com/4DSOAP/"
End if 

WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;$l_timeOut)
WEB SERVICE CALL:C778($t_URLintranet;$t_soapActionIntranet;$t_metodo;$t_nameSpaceIntranet;Web Service dynamic:K48:1)

If ((vtWS_ErrorString="@404 Not Found@") | (vtWS_ErrorString="No such function is published on this server@"))
	vtWS_ErrorNum:=""
	vtWS_ErrorString:=""
	$t_URLintranet:="http://intranet2.colegium.com/4DSOAP/"
	WEB SERVICE CALL:C778($t_URLintranet;$t_soapActionIntranet;$t_metodo;$t_nameSpaceIntranet;Web Service dynamic:K48:1)
End if 

ON ERR CALL:C155($t_metodoSiError)

$0:=vtWS_ErrorString