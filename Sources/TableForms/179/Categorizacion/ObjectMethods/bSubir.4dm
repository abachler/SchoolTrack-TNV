GET LIST ITEM:C378(hl_Categorias;Selected list items:C379(hl_Categorias);$OriginalRef;$text;$subList;$expanded)
$parentRef:=List item parent:C633(hl_Categorias;$OriginalRef)
If ($parentRef=0)
	$pos:=List item position:C629(hl_Categorias;$OriginalRef)
	$arriba:=0
	For ($i;$pos-1;1;-1)
		GET LIST ITEM:C378(hl_Categorias;$i;$tempref;$temptext)
		$parentRef:=List item parent:C633(hl_Categorias;$tempref)
		If ($parentRef=0)
			$arriba:=$i
			$i:=0
		End if 
	End for 
	If ($arriba#0)
		GET LIST ITEM:C378(hl_Categorias;$arriba;$itemRef;$itemText)
		READ WRITE:C146([xxACT_ItemsCategorias:98])
		QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]ID:2=$Itemref)
		$pos1:=[xxACT_ItemsCategorias:98]Posicion:3
		QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]ID:2=$OriginalRef)
		$pos2:=[xxACT_ItemsCategorias:98]Posicion:3
		QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]ID:2=$Itemref)
		[xxACT_ItemsCategorias:98]Posicion:3:=$pos2
		SAVE RECORD:C53([xxACT_ItemsCategorias:98])
		QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]ID:2=$OriginalRef)
		[xxACT_ItemsCategorias:98]Posicion:3:=$pos1
		SAVE RECORD:C53([xxACT_ItemsCategorias:98])
		KRL_UnloadReadOnly (->[xxACT_ItemsCategorias:98])
	End if 
	ARRAY LONGINT:C221($aCollapsedItemRefs;0)
	For ($i;1;Count list items:C380(hl_Categorias))
		GET LIST ITEM:C378(hl_Categorias;$i;$ref;$text;$sublist;$expanded)
		If ($subList>0)
			If ($expanded=False:C215)
				INSERT IN ARRAY:C227($aCollapsedItemRefs;Size of array:C274($aCollapsedItemRefs)+1;1)
				$aCollapsedItemRefs{Size of array:C274($aCollapsedItemRefs)}:=$ref
			End if 
		End if 
	End for 
	READ ONLY:C145([xxACT_ItemsCategorias:98])
	READ ONLY:C145([xxACT_Items:179])
	  // Modificado por: Saúl Ponce (21-03-2018) Ticket 198530, para que al subir una categoría no se vuelva a mostrar "Items sin categoria"
	  //ALL RECORDS([xxACT_ItemsCategorias])
	QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]ID:2#0)
	SELECTION TO ARRAY:C260([xxACT_ItemsCategorias:98]Posicion:3;$aPos;[xxACT_ItemsCategorias:98];$aRN)
	SORT ARRAY:C229($aPos;$aRN;>)
	CREATE SELECTION FROM ARRAY:C640([xxACT_ItemsCategorias:98];$aRN;"")
	FIRST RECORD:C50([xxACT_ItemsCategorias:98])
	HL_ClearList (hl_Categorias)
	hl_Categorias:=HL_Selection2List (->[xxACT_ItemsCategorias:98]Nombre:1;->[xxACT_ItemsCategorias:98]ID:2)
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
	For ($i;1;Size of array:C274($aCollapsedItemRefs))
		SELECT LIST ITEMS BY REFERENCE:C630(hl_Categorias;$aCollapsedItemRefs{$i})
		GET LIST ITEM:C378(hl_Categorias;Selected list items:C379(hl_Categorias);$ref;$label;$sublist;$expanded)
		SET LIST ITEM:C385(hl_Categorias;$ref;$label;$ref;$sublist;False:C215)
	End for 
	SELECT LIST ITEMS BY REFERENCE:C630(hl_Categorias;$OriginalRef)
	If (Find in array:C230($aCollapsedItemRefs;$OriginalRef)#-1)
		GET LIST ITEM:C378(hl_Categorias;Selected list items:C379(hl_Categorias);$OriginalRef;$label;$sublist;$expanded)
		SET LIST ITEM:C385(hl_Categorias;$OriginalRef;$label;$OriginalRef;$sublist;False:C215)
	End if 
	ACTcfg_HabilitaBtnsCategoriasIt 
	_O_REDRAW LIST:C382(hl_Categorias)
End if 