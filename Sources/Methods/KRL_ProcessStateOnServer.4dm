//%attributes = {"executedOnServer":true}
  // KRL_ProcessStateOnServer()
  // Por: Alberto Bachler K.: 07-04-15, 19:16:07
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)

C_LONGINT:C283($l_idOnServer;$l_idProceso)
C_TEXT:C284($t_nombreProceso)



If (False:C215)
	C_LONGINT:C283(KRL_ProcessStateOnServer ;$0)
End if 

$l_idProceso:=Abs:C99($1)
$t_nombreProceso:=$2

$l_idOnServer:=Process number:C372($t_nombreProceso)
If ($l_idProceso=$l_idOnServer)
	$0:=Process state:C330($l_idOnServer)
Else 
	$0:=Process state:C330($l_idProceso)
End if 

