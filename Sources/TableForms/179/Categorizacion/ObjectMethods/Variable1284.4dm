$hListPtr:=Focus object:C278
RESOLVE POINTER:C394($hListPtr;$ListObjectName;$tableNum;$fieldNum)
If ($ListObjectName="hl_Categorias")
	$element:=Selected list items:C379(hl_Categorias)
	If ($element>0)
		GET LIST ITEM:C378(hl_Categorias;$element;$ref;$text;$subList;$expanded)
		$parentRef:=List item parent:C633(hl_Categorias;$ref)
		If ($parentRef=0)
			$r:=CD_Dlog (0;__ ("¿Desea realmente eliminar la categoría ")+$text+__ ("?");__ ("");__ ("No");__ ("Si"))
			If ($r=2)
				READ WRITE:C146([xxACT_Items:179])
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID_Categoria:8=$ref)
				ARRAY LONGINT:C221($al_recNumsItems;0)
				LONGINT ARRAY FROM SELECTION:C647([xxACT_Items:179];$al_recNumsItems;"")
				For ($i;1;Size of array:C274($al_recNumsItems))
					GOTO RECORD:C242([xxACT_Items:179];$al_recNumsItems{$i})
					[xxACT_Items:179]ID_Categoria:8:=0
					SAVE RECORD:C53([xxACT_Items:179])
					APPEND TO LIST:C376(hl_Items;[xxACT_Items:179]Glosa:2;[xxACT_Items:179]ID:1)
					NEXT RECORD:C51([xxACT_Items:179])
				End for 
				SORT LIST:C391(hl_Items;>)
				KRL_UnloadReadOnly (->[xxACT_Items:179])
				READ WRITE:C146([xxACT_ItemsCategorias:98])
				QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]ID:2=$ref)
				DELETE SELECTION:C66([xxACT_ItemsCategorias:98])
				KRL_UnloadReadOnly (->[xxACT_ItemsCategorias:98])
				SET LIST ITEM:C385(hl_Categorias;$ref;$text;$ref;0;False:C215)
				HL_ClearList ($subList)
				DELETE FROM LIST:C624(hl_Categorias;$ref)
			End if 
		Else 
			$pos:=List item position:C629(hl_Categorias;$parentRef)
			GET LIST ITEM:C378(hl_Categorias;$pos;$parentRef;$parenttext)
			$r:=CD_Dlog (0;__ ("¿Desea realmente retirar el item ")+$text+__ (" de la categoria ")+$parenttext+__ ("?");__ ("");__ ("No");__ ("Si"))
			If ($r=2)
				READ WRITE:C146([xxACT_Items:179])
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$ref)
				[xxACT_Items:179]ID_Categoria:8:=0
				SAVE RECORD:C53([xxACT_Items:179])
				APPEND TO LIST:C376(hl_Items;[xxACT_Items:179]Glosa:2;[xxACT_Items:179]ID:1)
				KRL_UnloadReadOnly (->[xxACT_Items:179])
				DELETE FROM LIST:C624(hl_Categorias;$ref)
			End if 
		End if 
		_O_REDRAW LIST:C382(hl_Categorias)
		_O_REDRAW LIST:C382(hl_Items)
	End if 
	ACTcfg_HabilitaBtnsCategoriasIt 
End if 