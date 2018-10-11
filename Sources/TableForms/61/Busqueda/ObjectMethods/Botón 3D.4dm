  // [BBL_Items].Busqueda.Botón 3D()
  // Por: Alberto Bachler K.: 11-12-14, 10:40:31
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_muestraMenu)
C_LONGINT:C283($i;$l_lineaMenuCampos)
C_POINTER:C301($y_comparador;$y_menuRef;$y_palabrasCompletas)
C_TEXT:C284($t_item;$t_itemSeleccionado;$t_objetoActual;$t_refMenuCampos)

ARRAY TEXT:C222($at_parametroMenu;0)
ARRAY TEXT:C222($at_referencias;0)
ARRAY TEXT:C222($at_titulos;0)

$y_menuRef:=OBJECT Get pointer:C1124(Object named:K67:5;"menuRef")


$t_objetoActual:=OBJECT Get name:C1087(Object with focus:K67:3)

Case of 
	: (Form event:C388=On Long Click:K2:37)
		$b_muestraMenu:=True:C214
		GOTO OBJECT:C206(*;"expresionBusqueda")
		(OBJECT Get pointer:C1124(Object named:K67:5;"registro"))->:=""
		(OBJECT Get pointer:C1124(Object named:K67:5;"codigo"))->:=""
		(OBJECT Get pointer:C1124(Object named:K67:5;"clasificacion"))->:=""
		
	: ((Form event:C388=On Clicked:K2:4) & ($t_objetoactual="expresionBusqueda"))
		$b_muestraMenu:=True:C214
		
	Else 
		GOTO OBJECT:C206(*;"expresionBusqueda")
		(OBJECT Get pointer:C1124(Object named:K67:5;"registro"))->:=""
		(OBJECT Get pointer:C1124(Object named:K67:5;"codigo"))->:=""
		(OBJECT Get pointer:C1124(Object named:K67:5;"clasificacion"))->:=""
End case 


If ($b_muestraMenu)
	
	$t_itemSeleccionado:=Dynamic pop up menu:C1006($y_menuRef->)
	$y_comparador:=OBJECT Get pointer:C1124(Object named:K67:5;"comparador")
	$y_palabrasCompletas:=OBJECT Get pointer:C1124(Object named:K67:5;"palabrasCompletas")
	
	GET MENU ITEMS:C977($y_menuRef->;$at_titulos;$at_referencias)
	For ($i;1;Size of array:C274($at_titulos))
		APPEND TO ARRAY:C911($at_parametroMenu;Get menu item parameter:C1003($y_menuRef->;$i))
	End for 
	
	
	
	
	If ($t_itemSeleccionado#"")
		$l_lineaMenuCampos:=Find in array:C230($at_parametroMenu;$t_itemSeleccionado)
		Case of 
			: ($t_itemSeleccionado="%enTodasPartes")
				SET MENU ITEM MARK:C208($y_menuRef->;1;Char:C90(18))
				OBJECT SET TITLE:C194(*;"tipoBusqueda";$at_titulos{$l_lineaMenuCampos})
				  //OBJECT SET TITLE(*;"modoComparacion";__ ("Alguna de las palabras"))
				For ($i;4;10)
					SET MENU ITEM MARK:C208($y_menuRef->;$i;"")
				End for 
				
				
			: ($t_itemSeleccionado="_F@")
				SET MENU ITEM MARK:C208($y_menuRef->;1;"")
				For ($i;4;10)
					SET MENU ITEM MARK:C208($y_menuRef->;$i;"")
				End for 
				SET MENU ITEM MARK:C208($y_menuRef->;$l_lineaMenuCampos;Char:C90(18))
				$t_item:=ST_ClearSpaces (Get menu item:C422($y_menuRef->;$l_lineaMenuCampos))
				OBJECT SET TITLE:C194(*;"tipoBusqueda";__ ("Buscar solo en ")+"\""+$t_item+"\"")
				
				
				
			: ($t_itemSeleccionado="Op_@")
				For ($i;13;18)
					SET MENU ITEM MARK:C208($y_menuRef->;$i;"")
				End for 
				SET MENU ITEM MARK:C208($y_menuRef->;$l_lineaMenuCampos;Char:C90(18))
				$y_comparador->:=Num:C11($t_itemSeleccionado)
				OBJECT SET TITLE:C194(*;"modoComparacion";$at_titulos{$l_lineaMenuCampos})
				
			: ($t_itemSeleccionado="_palabrasCompletas")
				If ($y_palabrasCompletas->=1)
					SET MENU ITEM MARK:C208($y_menuRef->;20;"")
					$y_palabrasCompletas->:=0
				Else 
					SET MENU ITEM MARK:C208($y_menuRef->;20;Char:C90(18))
					$y_palabrasCompletas->:=1
				End if 
				
		End case 
		
		Case of 
			: ($t_itemSeleccionado="_F01_encabezado")
				DISABLE MENU ITEM:C150($y_menuRef->;20)
				DISABLE MENU ITEM:C150($y_menuRef->;15)
				DISABLE MENU ITEM:C150($y_menuRef->;16)
				DISABLE MENU ITEM:C150($y_menuRef->;17)
				DISABLE MENU ITEM:C150($y_menuRef->;18)
				If ($y_comparador->>=2)
					$y_comparador->:=1
					SET MENU ITEM MARK:C208($y_menuRef->;13;Char:C90(18))
					For ($i;14;18)
						SET MENU ITEM MARK:C208($y_menuRef->;$i;"")
					End for 
				End if 
				
			: ($y_comparador->>=2)
				DISABLE MENU ITEM:C150($y_menuRef->;20)
				SET MENU ITEM MARK:C208($y_menuRef->;20;"")
				
			Else 
				ENABLE MENU ITEM:C149($y_menuRef->;20)
				SET MENU ITEM MARK:C208($y_menuRef->;20;Char:C90(18)*$y_palabrasCompletas->)
				ENABLE MENU ITEM:C149($y_menuRef->;15)
				ENABLE MENU ITEM:C149($y_menuRef->;16)
				ENABLE MENU ITEM:C149($y_menuRef->;17)
				ENABLE MENU ITEM:C149($y_menuRef->;18)
		End case 
		
		BBL_BusquedaRapida ("ajustesBarraEstado")
		
		
		If ((OBJECT Get pointer:C1124(Object named:K67:5;"expresionBusqueda"))->#"")
			BBL_BusquedaItems 
		End if 
		
		
		
	End if 
End if 