//%attributes = {}
  // MÉTODO: IP_SendMessage
  // IP_SendMessage(calledProcess:L; message:T)
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 15/06/12, 08:34:02
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  //
  // ----------------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_LONGINT:C283($4)

C_LONGINT:C283($l_objectReference;$l_receiverProcessID;$l_senderProcessID)
C_TEXT:C284($t_message;$t_messageParameter)

If (False:C215)
	C_LONGINT:C283(IP_SendMessage ;$1)
	C_TEXT:C284(IP_SendMessage ;$2)
	C_TEXT:C284(IP_SendMessage ;$3)
	C_LONGINT:C283(IP_SendMessage ;$4)
End if 

  // CODIGO PRINCIPAL
$l_receiverProcessID:=$1
$t_message:=$2

Case of 
	: (Count parameters:C259=4)
		$l_objectReference:=$4
		$t_messageParameter:=$3
		
	: (Count parameters:C259>=3)
		$t_messageParameter:=$3
End case 

$l_senderProcessID:=Current process:C322

While (Semaphore:C143("IPMessages"))
	DELAY PROCESS:C323(Current process:C322;(2))
End while 

APPEND TO ARRAY:C911(<>at_IP_UUID;Generate UUID:C1066)
APPEND TO ARRAY:C911(<>al_IP_SenderProcess;$l_senderProcessID)

APPEND TO ARRAY:C911(<>al_IP_ReceiverProcess;$l_receiverProcessID)
APPEND TO ARRAY:C911(<>at_IP_Message;$t_message)
APPEND TO ARRAY:C911(<>at_IP_MessageParameters;$t_messageParameter)
APPEND TO ARRAY:C911(<>al_IP_ObjectReference;$l_objectReference)

CLEAR SEMAPHORE:C144("IPMessages")

POST OUTSIDE CALL:C329($l_receiverProcessID)

