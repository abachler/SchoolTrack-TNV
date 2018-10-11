If (USR_GetMethodAcces ("ACTcfg_SaveItemdeCargo";0))
	Case of 
		: (Form event:C388=On Drop:K2:12)
			DRAG AND DROP PROPERTIES:C607($srcObject;$srcElement;$srcProcess)
			RESOLVE POINTER:C394($srcObject;$srcObjectName;$tableNum;$fieldNum)
			If ($srcElement#-1)
				If ($srcObjectName="hl_Categorias")
					GET LIST ITEM:C378(hl_Categorias;$srcElement;$ref;$text;$sublist;$expanded)
					$parentRef:=List item parent:C633(hl_Categorias;$ref)
					If ($parentRef#0)
						$pos:=List item position:C629(hl_Categorias;$parentRef)
						GET LIST ITEM:C378(hl_Categorias;$pos;$parentRef;$parenttext)
						$r:=CD_Dlog (0;__ ("¿Desea realmente retirar el item ")+$text+__ (" de la categoria ")+$parenttext+__ ("?");__ ("");__ ("No");__ ("Si"))
						If ($r=2)
							READ WRITE:C146([xxACT_Items:179])
							QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$ref)
							[xxACT_Items:179]ID_Categoria:8:=0
							SAVE RECORD:C53([xxACT_Items:179])
							APPEND TO LIST:C376(hl_Items;[xxACT_Items:179]Glosa:2;[xxACT_Items:179]ID:1)
							SORT LIST:C391(hl_Items;>)
							KRL_UnloadReadOnly (->[xxACT_Items:179])
							DELETE FROM LIST:C624(hl_Categorias;$ref)
							_O_REDRAW LIST:C382(hl_Categorias)
							_O_REDRAW LIST:C382(hl_Items)
						End if 
					Else 
						$r:=CD_Dlog (0;__ ("Se dispone a retirar todos los ítems de la categoría ")+$text+__ (".\r¿Desea mantener la categoría ")+$text+__ ("?");__ ("");__ ("No, eliminar");__ ("Si, mantener");__ ("Cancelar"))
						If ($r#3)
							SET LIST ITEM:C385(hl_Categorias;$ref;$text;$ref;0;False:C215)
							HL_ClearList ($subList)
							READ WRITE:C146([xxACT_Items:179])
							QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID_Categoria:8=$ref)
							While (Not:C34(End selection:C36([xxACT_Items:179])))
								[xxACT_Items:179]ID_Categoria:8:=0
								SAVE RECORD:C53([xxACT_Items:179])
								APPEND TO LIST:C376(hl_Items;[xxACT_Items:179]Glosa:2;[xxACT_Items:179]ID:1)
								NEXT RECORD:C51([xxACT_Items:179])
							End while 
							KRL_UnloadReadOnly (->[xxACT_ItemsCategorias:98])
							SORT LIST:C391(hl_Items;>)
							If ($r=1)
								READ WRITE:C146([xxACT_ItemsCategorias:98])
								QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]ID:2=$ref)
								DELETE SELECTION:C66([xxACT_ItemsCategorias:98])
								KRL_UnloadReadOnly (->[xxACT_ItemsCategorias:98])
								DELETE FROM LIST:C624(hl_Categorias;$ref)
							End if 
							_O_REDRAW LIST:C382(hl_Categorias)
							_O_REDRAW LIST:C382(hl_Items)
						End if 
					End if 
				End if 
			End if 
			ACTcfg_HabilitaBtnsCategoriasIt 
	End case 
End if 