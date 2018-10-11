  // [BBL_Items].Busqueda.Botón 3D5()
  // Por: Alberto Bachler K.: 06-01-15, 18:52:04
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


$t_menu:=Create menu:C408
APPEND MENU ITEM:C411($t_menu;__ ("Mostrar todos en el explorador"))
SET MENU ITEM PARAMETER:C1004($t_menu;-1;"mostrarTodos")
SET MENU ITEM SHORTCUT:C423($t_menu;-1;"M";Command key mask:K16:1)
APPEND MENU ITEM:C411($t_menu;__ ("Añadir todos a la lista en explorador"))
SET MENU ITEM SHORTCUT:C423($t_menu;-1;"J";Command key mask:K16:1)
SET MENU ITEM PARAMETER:C1004($t_menu;-1;"añadirTodos")
APPEND MENU ITEM:C411($t_menu;"(-")
If (Records in set:C195("$ListboxItems")>0)
	APPEND MENU ITEM:C411($t_menu;__ ("Mostrar seleccionados en el explorador"))
	SET MENU ITEM SHORTCUT:C423($t_menu;-1;"M";Command key mask:K16:1+Option key mask:K16:7)
	SET MENU ITEM PARAMETER:C1004($t_menu;-1;"mostrarSeleccionados")
	APPEND MENU ITEM:C411($t_menu;__ ("Añadir seleccionados a la lista en explorador"))
	SET MENU ITEM PARAMETER:C1004($t_menu;-1;"añadirSeleccionados")
	SET MENU ITEM SHORTCUT:C423($t_menu;-1;"J";Command key mask:K16:1+Option key mask:K16:7)
Else 
	APPEND MENU ITEM:C411($t_menu;"("+__ ("Mostrar seleccionados en el explorador"))
	APPEND MENU ITEM:C411($t_menu;"("+__ ("Añadir seleccionados a la lista en explorador"))
End if 

$t_seleccion:=Dynamic pop up menu:C1006($t_menu)

Case of 
	: ($t_seleccion="mostrarTodos")
		POST KEY:C465(Character code:C91("m");Command key mask:K16:1)
		
	: ($t_seleccion="mostrarSeleccionados")
		  //USE SET("$ListboxItems")
		  //CLEAR SET("$ListboxItems")
		POST KEY:C465(Character code:C91("m");Command key mask:K16:1+Option key mask:K16:7)
		
	: ($t_seleccion="añadirTodos")
		POST KEY:C465(Character code:C91("j");Command key mask:K16:1)
		  //CREATE SET([BBL_Items];"$seleccion")
		  //UNION("RecordSet_Table"+String(Table(yBWR_currentTable));"$seleccion";"RecordSet_Table"+String(Table(yBWR_currentTable)))
		  //USE SET("RecordSet_Table"+String(Table(yBWR_currentTable)))
		  //CLEAR SET("$seleccion")
		  //ACCEPT
		
	: ($t_seleccion="añadirSeleccionados")
		POST KEY:C465(Character code:C91("j");Command key mask:K16:1+Option key mask:K16:7)
		  //UNION("RecordSet_Table"+String(Table(yBWR_currentTable));"$ListboxItems";"RecordSet_Table"+String(Table(yBWR_currentTable)))
		  //USE SET("RecordSet_Table"+String(Table(yBWR_currentTable)))
		  //CLEAR SET("$ListboxItems")
		  //ACCEPT
		
	Else 
		
End case 
