//%attributes = {}
  //ACTic_CargaListas

READ ONLY:C145([xxACT_Items:179])
QUERY:C277([xxACT_Items:179];[xxACT_Items:179]EsRelativo:5=False:C215;*)
QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID_Categoria:8=0)
ORDER BY:C49([xxACT_Items:179];[xxACT_Items:179]Glosa:2;>)
  //hl_Items:=HL_Selection2List (->[xxACT_Items]Glosa;->[xxACT_Items]ID)

ARRAY TEXT:C222($at_nombre;0)
ARRAY LONGINT:C221($al_id;0)

SELECTION TO ARRAY:C260([xxACT_Items:179]Glosa:2;$at_nombre;[xxACT_Items:179]ID:1;$al_id)
C_REAL:C285(hl_Items)
If (Is a list:C621(hl_Items))
	CLEAR LIST:C377(hl_Items)
End if 
hl_Items:=New list:C375
For ($l_indice;1;Size of array:C274($at_nombre))
	If ($al_id{$l_indice}<0)
		$at_nombre{$l_indice}:="(*)"+$at_nombre{$l_indice}
	End if 
	APPEND TO LIST:C376(hl_Items;$at_nombre{$l_indice};$al_id{$l_indice})
End for 

OBJECT SET ENTERABLE:C238(hl_Items;False:C215)
READ ONLY:C145([xxACT_ItemsCategorias:98])
  //ALL RECORDS([xxACT_ItemsCategorias])
QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]ID:2#0)
ORDER BY:C49([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]Posicion:3;>)

  //hl_Categorias:=HL_Selection2List (->[xxACT_ItemsCategorias]Nombre;->[xxACT_ItemsCategorias]ID)
ARRAY TEXT:C222($at_nombre;0)
ARRAY LONGINT:C221($al_id;0)
ARRAY TEXT:C222($at_codigo;0)
SELECTION TO ARRAY:C260([xxACT_ItemsCategorias:98]Nombre:1;$at_nombre;[xxACT_ItemsCategorias:98]ID:2;$al_id;[xxACT_ItemsCategorias:98]Codigo:5;$at_codigo)
C_REAL:C285(hl_Categorias)
If (Is a list:C621(hl_Categorias))
	CLEAR LIST:C377(hl_Categorias)
End if 
hl_Categorias:=New list:C375
For ($l_indice;1;Size of array:C274($at_nombre))
	If ($at_codigo{$l_indice}#"")
		$at_nombre{$l_indice}:=$at_nombre{$l_indice}+" - Código: "+$at_codigo{$l_indice}  //Este texto tb se usa al editar una categoria en la lista
	End if 
	APPEND TO LIST:C376(hl_Categorias;$at_nombre{$l_indice};$al_id{$l_indice})
End for 

For ($i;1;Count list items:C380(hl_Categorias))
	GET LIST ITEM:C378(hl_Categorias;$i;$itemRef;$itemText)
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID_Categoria:8=$itemRef)
	ORDER BY:C49([xxACT_Items:179];[xxACT_Items:179]Glosa:2;>)
	$sublist:=HL_Selection2List (->[xxACT_Items:179]Glosa:2;->[xxACT_Items:179]ID:1)
	SET LIST ITEM:C385(hl_Categorias;$itemRef;$itemText;$itemRef;$sublist;False:C215)
End for 
For ($i;Count list items:C380(hl_Categorias);1;-1)
	GET LIST ITEM:C378(hl_Categorias;$i;$ref;$text;$sublist;$expanded)
	SET LIST ITEM:C385(hl_Categorias;$ref;$text;$ref;$sublist;True:C214)
	$itemRef:=List item parent:C633(hl_Categorias;$ref)
	If ($itemRef#0)
		SET LIST ITEM PROPERTIES:C386(hl_Categorias;$ref;False:C215;0;0)
	End if 
End for 
For ($i;1;Count list items:C380(hl_Categorias))
	GET LIST ITEM:C378(hl_Categorias;$i;$ref;$text;$sublist;$expanded)
	$itemRef:=List item parent:C633(hl_Categorias;$ref)
	If ($itemRef#0)
		SET LIST ITEM PROPERTIES:C386(hl_Categorias;$ref;False:C215;0;0)
	End if 
End for 
SET LIST PROPERTIES:C387(hl_Categorias;1;0;18)
SET LIST PROPERTIES:C387(hl_Items;1;0;18)