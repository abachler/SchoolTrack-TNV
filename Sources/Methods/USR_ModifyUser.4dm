//%attributes = {}
  //USR_ModifyUser
  //ABC175748 
  //20171128 ASM Ticket 193893 Agrego el parametro para buscar y desplegar la información del arreglo que corresponde.
If (Count parameters:C259=1)
	$y_userName:=$1
Else 
	$y_userName:=-><>atUSR_UserNames
End if 

QUERY:C277([xShell_Users:47];[xShell_Users:47]login:9=$y_userName->{$y_userName->})
$title:=__ ("Usuario: ")+$y_userName->{$y_userName->}

WDW_OpenFormWindow (->[xShell_Users:47];"Input2";-1;4;$title)
BWR_ModifyRecord (->[xShell_Users:47];"Input2")
CLOSE WINDOW:C154
If (ok=1)
	USR_LoadPasswordTables 
End if 

KRL_UnloadReadOnly (->[xShell_UserGroups:17])
KRL_UnloadReadOnly (->[xShell_Users:47])