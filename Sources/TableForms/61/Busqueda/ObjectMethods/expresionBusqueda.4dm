  // [BBL_Items].Busqueda.expresionBusqueda()
  // Por: Alberto Bachler K.: 16-12-14, 11:56:16
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
$y_menuRef:=OBJECT Get pointer:C1124(Object named:K67:5;"menuRef")
$y_comparador:=OBJECT Get pointer:C1124(Object named:K67:5;"comparador")

Case of 
	: (Form event:C388=On Clicked:K2:4)
		
	: (Form event:C388=On Double Clicked:K2:5)
		
	: (Form event:C388=On Getting Focus:K2:7)
		OBJECT SET TITLE:C194(*;"tipoBusqueda";__ ("Buscar en todas partes"))
		For ($i;4;10)
			If (Character code:C91(Get menu item mark:C428($y_menuRef->;$i))=18)
				$t_item:=ST_ClearSpaces (Get menu item:C422($y_menuRef->;$i))
				OBJECT SET TITLE:C194(*;"tipoBusqueda";__ ("Buscar solo en ")+"\""+$t_item+"\"")
			End if 
		End for 
		
		For ($i;13;18)
			If (Character code:C91(Get menu item mark:C428($y_menuRef->;$i))=18)
				$t_item:=ST_ClearSpaces (Get menu item:C422($y_menuRef->;$i))
				OBJECT SET TITLE:C194(*;"modocomparacion";$t_item)
			End if 
		End for 
		
		BBL_BusquedaRapida ("ajustesBarraEstado")
		OBJECT SET VISIBLE:C603(*;"modoComparacion";True:C214)
		
	: (Form event:C388=On After Keystroke:K2:26)
		(OBJECT Get pointer:C1124(Object named:K67:5;"registro"))->:=""
		(OBJECT Get pointer:C1124(Object named:K67:5;"codigo"))->:=""
		(OBJECT Get pointer:C1124(Object named:K67:5;"clasificacion"))->:=""
		
		
		BBL_BusquedaItems 
End case 
