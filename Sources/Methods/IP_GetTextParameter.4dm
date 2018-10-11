//%attributes = {}
  // IP_GetTextParameter()
  //
  // DESCRIPCIÓN:
  //
  // PARÁMETROS:
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 15/06/12, 11:23:48
  // ---------------------------------------------
C_TEXT:C284($1;$0)

C_LONGINT:C283($l_elementFounded)
C_TEXT:C284($t_parameters;$t_uuid)

If (False:C215)
	C_TEXT:C284(IP_GetTextParameter ;$1)
End if 



  // CÓDIGO
$t_uuid:=$1

$l_elementFounded:=Find in array:C230(<>at_IP_UUID;$t_uuid)

If ($l_elementFounded>0)
	$t_parameters:=<>at_IP_MessageParameters{$l_elementFounded}
End if 

$0:=$t_parameters

