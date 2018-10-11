//%attributes = {}
  // IP_GetParameterObjectRef()
  //
  // DESCRIPCIÓN:
  //
  // PARÁMETROS:
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 15/06/12, 11:29:58
  // ---------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)

C_LONGINT:C283($l_elementFounded;$l_objectRef)
C_TEXT:C284($t_uuid)

If (False:C215)
	C_LONGINT:C283(IP_GetParameterObjectRef ;$0)
	C_TEXT:C284(IP_GetParameterObjectRef ;$1)
End if 




  // CÓDIGO
$t_uuid:=$1

$l_elementFounded:=Find in array:C230(<>at_IP_UUID;$t_uuid)

If ($l_elementFounded>0)
	$l_objectRef:=<>al_IP_ObjectReference{$l_elementFounded}
End if 

$0:=$l_objectRef

