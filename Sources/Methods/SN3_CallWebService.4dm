//%attributes = {}
  //SN3_CallWebService

C_TEXT:C284($method;$1;$0)
C_BOOLEAN:C305($2;$logError)
C_LONGINT:C283($3;$timeout)
C_TEXT:C284(vtWS_ErrorNum;vtWS_ErrorString)

ARRAY TEXT:C222($at_direccionMAC;0)
C_TEXT:C284($t_log;$t_MacAddress)
C_BOOLEAN:C305($b_continuar)

$method:=$1

$logError:=True:C214
  //$timeout:=<>timeoutSchoolNet3PG
$timeout:=<>timeoutSchoolNet3

Case of 
	: (Count parameters:C259=2)
		$logError:=$2
	: (Count parameters:C259=3)
		$logError:=$2
		$timeout:=$3
End case 

vtWS_ErrorNum:=""
vtWS_ErrorString:=""

$b_continuar:=SN3_VerificaInicioWS ($method)
If ($b_continuar)
	$methodCalledOnError:=Method called on error:C704
	ON ERR CALL:C155("WS_ErrorHandler")
	
	  //20170216 RCH
	$t_MacAddress:=SYS_GetServerMAC (->$at_direccionMAC)
	$t_log:=SN3_ParametroLog ($method)
	WEB SERVICE SET PARAMETER:C777("macserver";$t_MacAddress)
	WEB SERVICE SET PARAMETER:C777("log";$t_log)
	
	WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;$timeout)
	WEB SERVICE CALL:C778(<>urlSchoolNet3;<>soapActionSchoolNet3;$method;<>nameSpaceSchoolNet3;Web Service dynamic:K48:1)
	
	ON ERR CALL:C155($methodCalledOnError)
	
	  //SN3_RegisterLogEntry (SN3_Log_Info;"Llamado a servicio SN: "+$method+". Datos: "+$t_log+".")
	SN3_RegisterLogEntry (SN3_Log_Info;"Llamado a servicio SN: "+$method+". Datos: "+$t_log+Choose:C955(vtWS_ErrorNum="";".";". Error: "+vtWS_ErrorNum+". Error string: "+vtWS_ErrorString))  //20170512 RCH
Else 
	vtWS_ErrorString:="Error. Servicio no autorizado."
End if 

$0:=vtWS_ErrorString