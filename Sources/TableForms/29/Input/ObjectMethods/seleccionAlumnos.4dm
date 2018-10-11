  // [Actividades].Input.seleccionAlumnos()
If (False:C215)
	  // Por: Alberto Bachler K.: 05-06-14, 11:58:16
	  //  ---------------------------------------------
	  // 
	  //
	  //  ---------------------------------------------
	
	
End if 


ARRAY TEXT:C222($at_menuItems;0)
APPEND TO ARRAY:C911($at_menuItems;__ ("Todos los alumnos inscritos"))
APPEND TO ARRAY:C911($at_menuItems;"(-")
$t_itemActual:=OBJECT Get title:C1068(*;OBJECT Get name:C1087(Object current:K67:2))
For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
	APPEND TO ARRAY:C911($at_menuItems;__ ("Alumnos inscritos en ")+atSTR_Periodos_Nombre{$i})
End for 
APPEND TO ARRAY:C911($at_menuItems;"(-")
APPEND TO ARRAY:C911($at_menuItems;__ ("Alumnos inscritos en todos los períodos"))
$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_menuItems;->$t_itemActual)
If ($l_itemSeleccionado>0)
	Case of 
		: ($l_itemSeleccionado=Size of array:C274($at_menuItems))
			$l_periodo:=0
			vPeriodo:=0
			
			
		: ($l_itemSeleccionado=1)
			$l_periodo:=-1
			vPeriodo:=0
			
			
		: ($l_itemSeleccionado>=3)
			$l_periodo:=$l_itemSeleccionado-2
			vPeriodo:=$l_periodo
			
	End case 
	(OBJECT Get pointer:C1124(Object named:K67:5;"periodo"))->:=$l_periodo
	
	OBJECT SET TITLE:C194(*;OBJECT Get name:C1087(Object current:K67:2);$at_menuItems{$l_itemSeleccionado})
	IT_PropiedadesBotonPopup (OBJECT Get name:C1087(Object current:K67:2);$at_menuItems{$l_itemSeleccionado};340)
	
	XCR_ListaAlumnosInscritos 
	
	vPeriodo:=0
End if 