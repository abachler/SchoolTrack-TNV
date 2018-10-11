  // [BBL_Items].Input.Botón invisible()
  // Por: Alberto Bachler: 20/11/13, 13:35:23
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (-><>atBBL_Media;->[BBL_Subscripciones:117]Media:25)
If ($l_itemSeleccionado>0)
	[BBL_Subscripciones:117]ID_Media:26:=<>alBBL_IDMedia{$l_itemSeleccionado}
	[BBL_Subscripciones:117]Media:25:=<>atBBL_Media{$l_itemSeleccionado}
End if 







