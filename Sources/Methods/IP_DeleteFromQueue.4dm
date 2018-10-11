//%attributes = {}
  // MÉTODO: IP_DeleteFromQueue
  // IP_DeleteFromQueue(uuid:T)
  //
  // DESCRIPCIÓN
  // Elimina el mensaje interproceso cuyo ID recibe en $1
  //
  // PARÁMETROS
  // $1: UUID:T 
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 15/06/12, 09:18:38
  // ----------------------------------------------------

C_TEXT:C284($1;$t_UUID)


  // CODIGO PRINCIPAL
$t_UUID:=$1

While (Semaphore:C143("IPMessages"))
	DELAY PROCESS:C323(Current process:C322;(2))
End while 

$l_element:=Find in array:C230(<>at_IP_UUID;$t_UUID)
If ($l_element>0)
	DELETE FROM ARRAY:C228(<>at_IP_UUID;$l_element)
	DELETE FROM ARRAY:C228(<>at_IP_Message;$l_element)
	DELETE FROM ARRAY:C228(<>al_IP_SenderProcess;$l_element)
	DELETE FROM ARRAY:C228(<>al_IP_ReceiverProcess;$l_element)
	DELETE FROM ARRAY:C228(<>at_IP_MessageParameters;$l_element)
	DELETE FROM ARRAY:C228(<>al_IP_ObjectReference;$l_element)
End if 

CLEAR SEMAPHORE:C144("IPMessages")
