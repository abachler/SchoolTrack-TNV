  // [Actividades].Input.desdeNivel()
  // Por: Alberto Bachler K.: 03-06-14, 16:07:35
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



$l_idxNivel:=IT_DynamicPopupMenu_Array (-><>at_NombreNivelesActivos;->[Actividades:29]Desde_NombreNivel:12)
If ($l_idxNivel>0)
	[Actividades:29]Desde_NumeroNivel:5:=<>al_NumeroNivelesActivos{$l_idxNivel}
	[Actividades:29]Desde_NombreNivel:12:=<>at_NombreNivelesActivos{$l_idxNivel}
End if 
IT_PropiedadesBotonPopup ("desdeNivel";[Actividades:29]Desde_NombreNivel:12;300)