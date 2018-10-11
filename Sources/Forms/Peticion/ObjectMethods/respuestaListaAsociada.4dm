  // Peticion.respuestaListaAsociada()
  // Por: Alberto Bachler K.: 02-09-14, 10:58:25
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_itemSeleccionado)

ARRAY TEXT:C222($at_elementos;0)

AT_Text2Array (->$at_elementos;vt_ListaValores)


$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_elementos)

If ($l_itemSeleccionado>0)
	vt_respuesta:=$at_elementos{$l_itemSeleccionado}
End if 

