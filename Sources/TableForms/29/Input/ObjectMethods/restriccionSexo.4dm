  // [Actividades].Input.menuRestriccionSexo()
  // Por: Alberto Bachler K.: 03-06-14, 16:35:52
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$y_seleccionSexo:=OBJECT Get pointer:C1124(Object named:K67:5;"restriccionSexo")
$t_texto:=OBJECT Get title:C1068(*;"restriccionSexo")
$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (-><>aSexSel;->$t_texto)
If ($l_itemSeleccionado>0)
	[Actividades:29]Selección_por_sexo:6:=$l_itemSeleccionado
End if 
Case of 
	: ([Actividades:29]Selección_por_sexo:6=1)
		IT_PropiedadesBotonPopup ("restriccionSexo";__ ("Ambos sexos");300)
		
	: ([Actividades:29]Selección_por_sexo:6=2)
		IT_PropiedadesBotonPopup ("restriccionSexo";__ ("Femenino");300)
		
	: ([Actividades:29]Selección_por_sexo:6=3)
		IT_PropiedadesBotonPopup ("restriccionSexo";__ ("Masculino");300)
		
End case 