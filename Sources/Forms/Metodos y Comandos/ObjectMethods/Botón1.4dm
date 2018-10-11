  // Metodos y Comandos.Botón()
  // Por: Alberto Bachler: 25/02/13, 18:13:09
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_itemTemas)
C_POINTER:C301($y_lastObject)

ARRAY LONGINT:C221($al_ComandosSeleccionados;0)
$y_lastObject:=Focus object:C278

If ($y_lastObject->=hl_temas)
	$l_itemTemas:=Selected list items:C379(hl_temas;$al_ComandosSeleccionados;*)
	For ($i;1;Size of array:C274($al_ComandosSeleccionados))
		DELETE FROM LIST:C624(hl_temas;$al_ComandosSeleccionados{$i})
	End for 
End if 

SORT LIST:C391(hl_comandos)
