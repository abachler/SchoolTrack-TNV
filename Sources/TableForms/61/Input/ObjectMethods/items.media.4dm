  //If ([BBL_Items]Media="")
$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (-><>atBBL_Media;->[BBL_Items:61]Media:15;OBJECT Get name:C1087(Object current:K67:2))
If ($l_itemSeleccionado>0)
	[BBL_Items:61]ID_Media:48:=<>alBBL_IDMedia{$l_itemSeleccionado}
	[BBL_Items:61]Media:15:=<>atBBL_Media{$l_itemSeleccionado}
End if 
  //End if 