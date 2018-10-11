//%attributes = {}
  // MÉTODO: IP_GetMessageQueue
  // IP_GetMessageQueue(arrayText_UUID:Y ; arrayLong_SourceProcess:Y; arrayText_Message:Y) -> messageCount:L
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 15/06/12, 08:52:33
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  //
  // ----------------------------------------------------



C_POINTER:C301($1;$y_UUIDArray)
C_POINTER:C301($2;$y_MessageArray)
C_POINTER:C301($3;$y_SenderProcessArray)

  // CODIGO PRINCIPAL
$y_UUIDArray:=$1
$y_MessageArray:=$2
ARRAY TEXT:C222($y_UUIDArray->;0)
ARRAY TEXT:C222($y_MessageArray->;0)
If (Count parameters:C259=3)
	$y_SenderProcessArray:=$3
	ARRAY LONGINT:C221($y_SenderProcessArray->;0)
End if 

While (Semaphore:C143("IPMessages"))
	DELAY PROCESS:C323(Current process:C322;(2))
End while 

$l_currentProcess:=Current process:C322

For ($i;1;Size of array:C274(<>at_IP_Message))
	If (<>al_IP_ReceiverProcess{$i}=$l_currentProcess)
		APPEND TO ARRAY:C911($y_UUIDArray->;<>at_IP_UUID{$i})
		APPEND TO ARRAY:C911($y_MessageArray->;<>at_IP_Message{$i})
		If (Count parameters:C259=3)
			APPEND TO ARRAY:C911($y_SenderProcessArray->;<>al_IP_SenderProcess{$i})
		End if 
	End if 
End for 
CLEAR SEMAPHORE:C144("IPMessages")

$l_messageCount:=Size of array:C274($y_UUIDArray->)

$0:=$l_messageCount