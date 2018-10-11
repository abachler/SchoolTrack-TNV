  // [BBL_Items].Input.Botón invisible()
  // Por: Alberto Bachler: 20/11/13, 13:35:23
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (-><>atBBL_Media;->[BBL_Items:61]Media:15)
If ($l_itemSeleccionado>0)
	[BBL_Items:61]ID_Media:48:=<>alBBL_IDMedia{$l_itemSeleccionado}
	[BBL_Items:61]Media:15:=<>atBBL_Media{$l_itemSeleccionado}
End if 







