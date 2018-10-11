//%attributes = {}
  // VC4D_CallWebService()
  // Por: Alberto Bachler K.: 30-09-14, 17:49:04
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_TEXT:C284($0)
C_TEXT:C284($1)

C_LONGINT:C283($l_timeOut)
C_TEXT:C284($t_metodo;$t_metodoSiError;$t_nameSpaceIntranet;$t_soapActionIntranet;$t_URLintranet)


If (False:C215)
	C_TEXT:C284(VC4D_CallWebService ;$0)
	C_TEXT:C284(VC4D_CallWebService ;$1)
End if 

C_TEXT:C284(vtWS_ErrorNum;vtWS_ErrorString)

$t_metodo:=$1
$t_URLintranet:=$2
$t_soapActionIntranet:=$3
$t_nameSpaceIntranet:=$4

Case of 
	: ($t_URLintranet="http://@")
	: ($t_URLintranet="https://@")
	Else 
		$t_URLintranet:="http://"+$t_URLintranet
End case 

Case of 
	: ($t_URLintranet="@/4DSOAP/")
	: ($t_URLintranet="@/4DSOAP")
	Else 
		$t_URLintranet:=$t_URLintranet+"/4DSOAP"
End case 

vtWS_ErrorNum:=""
vtWS_ErrorString:=""

$t_metodoSiError:=Method called on error:C704
ON ERR CALL:C155("WS_ErrorHandler")

$l_timeOut:=60
WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;$l_timeOut)
WEB SERVICE CALL:C778($t_URLintranet;$t_soapActionIntranet;$t_metodo;$t_nameSpaceIntranet;Web Service dynamic:K48:1)


ON ERR CALL:C155($t_metodoSiError)

$0:=vtWS_ErrorString