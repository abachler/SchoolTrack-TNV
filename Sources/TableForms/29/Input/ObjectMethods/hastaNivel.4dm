  // [Actividades].Input.hastaNivel()
  // Por: Alberto Bachler K.: 03-06-14, 16:54:30
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



$l_idxNivel:=IT_DynamicPopupMenu_Array (-><>at_NombreNivelesActivos;->[Actividades:29]Hasta_NombreNivel:11)
If ($l_idxNivel>0)
	[Actividades:29]Hasta_NumeroNivel:9:=<>al_NumeroNivelesActivos{$l_idxNivel}
	[Actividades:29]Hasta_NombreNivel:11:=<>at_NombreNivelesActivos{$l_idxNivel}
End if 
IT_PropiedadesBotonPopup ("hastaNivel";[Actividades:29]Hasta_NombreNivel:11;300)
