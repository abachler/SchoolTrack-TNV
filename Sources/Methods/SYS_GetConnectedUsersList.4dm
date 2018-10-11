//%attributes = {}
  // Método: SYS_GetConnectedUsersList
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 03/09/10, 12:32:07
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_POINTER:C301($arrayPointer;$1)
$arrayPointer:=$1

  // Código principal
ARRAY TEXT:C222($aMethods;0)
ARRAY TEXT:C222($atConnectedUsers;0)
GET REGISTERED CLIENTS:C650($atConnectedUsers;$methods)
ARRAY TEXT:C222($arrayPointer->;Size of array:C274($atConnectedUsers))
For ($i;1;Size of array:C274($atConnectedUsers))
	$UserId:=Num:C11(ST_GetWord ($atConnectedUsers{$i};2))
	If ($UserId#0)
		$arrayPointer->{$i}:=USR_GetUserName ($UserId)
	End if 
End for 

