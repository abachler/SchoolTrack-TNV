//%attributes = {}
  //WS_CallCommTrackWebService

C_TEXT:C284($method;$1;$0)
C_BOOLEAN:C305($2;$logError)
C_LONGINT:C283($3;$timeout)
C_TEXT:C284(vtWS_ErrorNum;vtWS_ErrorString)

$method:=$1

$logError:=True:C214
$timeout:=<>timeoutCommTrack

Case of 
	: (Count parameters:C259=2)
		$logError:=$2
	: (Count parameters:C259=3)
		$logError:=$2
		$timeout:=$3
End case 

vtWS_ErrorNum:=""
vtWS_ErrorString:=""

$soapAction:=<>soapActionCommTrack+$method

$methodCalledOnError:=Method called on error:C704
ON ERR CALL:C155("WS_ErrorHandler")

WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;$timeout)
WEB SERVICE CALL:C778(<>urlCommTrack;$soapAction;$method;<>nameSpaceCommTrack;Web Service dynamic:K48:1)

ON ERR CALL:C155($methodCalledOnError)

If ($logError)
	If ((vtWS_ErrorNum#"") & (vtWS_ErrorString#""))
		CMT_LogAction ("Error";vtWS_ErrorString;Num:C11(vtWS_ErrorNum))
	End if 
End if 

$0:=vtWS_ErrorString