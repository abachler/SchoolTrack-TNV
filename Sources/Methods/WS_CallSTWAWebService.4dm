//%attributes = {}
  //WS_CallSTWAWebService

C_TEXT:C284($method;$1;$0)
C_BOOLEAN:C305($2;$logError)
C_LONGINT:C283($3;$timeout)
C_TEXT:C284(vtWS_ErrorNum;vtWS_ErrorString)

$method:=$1

$logError:=True:C214
$timeout:=<>timeoutSTWA

Case of 
	: (Count parameters:C259=2)
		$logError:=$2
	: (Count parameters:C259=3)
		$logError:=$2
		$timeout:=$3
End case 

vtWS_ErrorNum:=""
vtWS_ErrorString:=""

$soapAction:=<>soapActionSTWA+$method

$methodCalledOnError:=Method called on error:C704
ON ERR CALL:C155("WS_ErrorHandler")

WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;$timeout)
WEB SERVICE CALL:C778(<>urlSTWA;$soapAction;$method;<>nameSpaceSTWA;Web Service dynamic:K48:1)

ON ERR CALL:C155($methodCalledOnError)

$0:=vtWS_ErrorString