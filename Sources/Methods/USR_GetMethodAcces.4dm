//%attributes = {}
  //USR_GetMethodAcces

C_TEXT:C284($1;$command;$method)
C_LONGINT:C283($2;$displayMessage)
C_LONGINT:C283($3;$userID)
$command:=$1
$displayMessage:=1
$userID:=<>lUSR_CurrentUserID
$0:=False:C215

Case of 
	: (Count parameters:C259=2)
		$displayMessage:=$2
	: (Count parameters:C259=3)
		$displayMessage:=$2
		$userID:=$3
End case 

$el:=Find in array:C230(<>ATUSR_AUTHORIZEDCOMMANDS;$command)  // el nombre del comando es el alias
If (($el>0) | ($userID<0))
	$0:=True:C214
Else 
	  // el nombre del comando es el nombre del metodo
	$el:=Find in array:C230(<>ATUSR_METHODNAMES;$command)  // se busca el nombre del metodo en la matriz metodos/alias
	If ($el>0)
		$command:=<>atUSR_Commands{$el}  //se cambia el nombre del metodo por el nombre del comando
		$el:=Find in array:C230(<>ATUSR_AUTHORIZEDCOMMANDS;$command)
		If (($el>0) | ($userID<0))
			$0:=True:C214
		End if 
	End if 
End if 

If ($0=False:C215)
	$0:=USR_HasSpecialPermission ($command;$command;$userID)
End if 

If (($0=False:C215) & ($displayMessage#0))
	USR_ALERT_UserHasNoRights (4)
End if 