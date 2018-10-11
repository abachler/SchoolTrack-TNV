//%attributes = {}
  // MÉTODO: USR_GetUserEventDescription
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 30/06/11, 19:33:15
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // USR_GetUserEventDescription()
  // ----------------------------------------------------
C_LONGINT:C283($l_found)
C_TEXT:C284($0)

  // DECLARACIONES E INICIALIZACIONES

  // CODIGO PRINCIPAL
$l_found:=Find in array:C230(<>al_lbTaskTypes_Ids;[xShell_UserEvents:282]Event:6)
If ($l_found>0)
	$0:=<>at_lbTaskTypes_names{$l_found}
Else 
	$0:=String:C10([xShell_UserEvents:282]Event:6)
End if 

