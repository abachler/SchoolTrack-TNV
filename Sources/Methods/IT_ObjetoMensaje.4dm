//%attributes = {}
  // IT_ObjetoMensaje()
  // Por: Alberto Bachler K.: 27-01-14, 13:46:15
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



C_OBJECT:C1216($0)
C_TEXT:C284($t_UUID)
ARRAY OBJECT:C1221(<>ao_IP_Objeto;0)

$t_uuid:=$1

$l_elementFounded:=Find in array:C230(<>at_IP_UUID;$t_uuid)

If ($l_indiceObjeto<=Size of array:C274(<>ao_IP_Objeto))
	If (OB Is defined:C1231(<>ao_IP_Objeto{$l_elementFounded}))
		$0:=<>ao_IP_Objeto{$l_elementFounded}
	End if 
End if 




