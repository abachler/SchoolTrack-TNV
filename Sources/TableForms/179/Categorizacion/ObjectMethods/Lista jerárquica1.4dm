If (USR_GetMethodAcces ("ACTcfg_SaveItemdeCargo";0))
	C_LONGINT:C283($r)
	Case of 
		: (Form event:C388=On Clicked:K2:4)
			  //20171229 RCH
			$element:=Selected list items:C379(hl_Categorias)
			If ($element>0)
				GET LIST ITEM:C378(hl_Categorias;$element;$itemRef;$itemText)
				READ ONLY:C145([xxACT_ItemsCategorias:98])
				QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]ID:2=$itemRef)
				OBJECT SET HELP TIP:C1181(hl_Categorias;"Categoría: "+[xxACT_ItemsCategorias:98]Nombre:1+". Código: "+[xxACT_ItemsCategorias:98]Codigo:5+". Orden: "+String:C10([xxACT_ItemsCategorias:98]Posicion:3))
			End if 
			
			If (Contextual click:C713)
				$text:="Expandir Todo;Colapsar Todo"
				$choice:=Pop up menu:C542($text)
				Case of 
					: ($choice=1)
						HL_ExpandAll (hl_Categorias)
						_O_REDRAW LIST:C382(hl_Categorias)
					: ($choice=2)
						$items:=Count list items:C380(hl_Categorias)
						$i:=0
						While ($i<$items)
							$i:=$i+1
							GET LIST ITEM:C378(hl_Categorias;$i;$itemRef;$itemText;$subList;$expanded)
							SET LIST ITEM:C385(hl_Categorias;$itemRef;$itemText;$itemRef;$subList;False:C215)
							$items:=Count list items:C380(hl_Categorias)
						End while 
						_O_REDRAW LIST:C382(hl_Categorias)
				End case 
			End if 
			ACTcfg_HabilitaBtnsCategoriasIt 
		: (Form event:C388=On Data Change:K2:15)
			$hListPtr:=Focus object:C278
			RESOLVE POINTER:C394($hListPtr;$ListObjectName;$tableNum;$fieldNum)
			If ($ListObjectName="hl_Categorias")
				$element:=Selected list items:C379(hl_Categorias)
				GET LIST ITEM:C378(hl_Categorias;$element;$itemRef;$itemText)
				READ WRITE:C146([xxACT_ItemsCategorias:98])
				QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]ID:2=$itemRef)
				
				  //20171229 RCH
				$l_pos:=Position:C15("- Código: ";$itemText)
				If ($l_pos>0)
					$itemText:=Substring:C12($itemText;1;$l_pos-1)
				End if 
				
				[xxACT_ItemsCategorias:98]Nombre:1:=$itemText
				SAVE RECORD:C53([xxACT_ItemsCategorias:98])
				KRL_UnloadReadOnly (->[xxACT_ItemsCategorias:98])
				ACTcfg_HabilitaBtnsCategoriasIt 
			End if 
		: (Form event:C388=On Drop:K2:12)
			DRAG AND DROP PROPERTIES:C607($srcObject;$srcElement;$srcProcess)
			RESOLVE POINTER:C394($srcObject;$srcObjectName;$tableNum;$fieldNum)
			$dropPos:=Drop position:C608
			If ($srcElement#-1)
				Case of 
					: ($srcObjectName="hl_Items")
						If (Count list items:C380(hl_Categorias)=0)
							CREATE RECORD:C68([xxACT_ItemsCategorias:98])
							[xxACT_ItemsCategorias:98]ID:2:=ACTcfgcat_RetornaLastID 
							[xxACT_ItemsCategorias:98]Nombre:1:="Nueva Categoría"
							[xxACT_ItemsCategorias:98]Posicion:3:=SQ_SeqNumber (->[xxACT_ItemsCategorias:98]Posicion:3)
							SAVE RECORD:C53([xxACT_ItemsCategorias:98])
							APPEND TO LIST:C376(hl_Categorias;[xxACT_ItemsCategorias:98]Nombre:1;[xxACT_ItemsCategorias:98]ID:2)
							READ WRITE:C146([xxACT_Items:179])
							GET LIST ITEM:C378(hl_Items;$srcElement;$itemRef;$itemText)
							QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$itemRef)
							[xxACT_Items:179]ID_Categoria:8:=[xxACT_ItemsCategorias:98]ID:2
							SAVE RECORD:C53([xxACT_Items:179])
							DELETE FROM LIST:C624(hl_Items;$itemRef)
							$subList:=New list:C375
							APPEND TO LIST:C376($subList;[xxACT_Items:179]Glosa:2;[xxACT_Items:179]ID:1)
							SET LIST ITEM PROPERTIES:C386($subList;[xxACT_Items:179]ID:1;False:C215;0;0)
							SET LIST ITEM:C385(hl_Categorias;[xxACT_ItemsCategorias:98]ID:2;[xxACT_ItemsCategorias:98]Nombre:1;[xxACT_ItemsCategorias:98]ID:2;$subList;True:C214)
							_O_REDRAW LIST:C382(hl_Categorias)
							_O_REDRAW LIST:C382(hl_Items)
							ACTcfg_HabilitaBtnsCategoriasIt 
						Else 
							If ($dropPos>0)
								GET LIST ITEM:C378(hl_Categorias;$dropPos;$catRef;$catText;$subList)
								$itemRef:=List item parent:C633(hl_Categorias;$catRef)
								If ($itemRef#0)
									$dropPos:=List item position:C629(hl_Categorias;$itemRef)
								End if 
								GET LIST ITEM:C378(hl_Categorias;$dropPos;$catRef;$catText;$subList)
								GET LIST ITEM:C378(hl_Items;$srcElement;$itemRef;$itemText)
								READ WRITE:C146([xxACT_Items:179])
								QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$itemRef)
								If ([xxACT_Items:179]ID_Categoria:8#$catRef)
									If ([xxACT_Items:179]ID_Categoria:8#0)
										READ ONLY:C145([xxACT_ItemsCategorias:98])
										QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]ID:2=[xxACT_Items:179]ID_Categoria:8)
										$r:=CD_Dlog (0;__ ("Este ítem pertenece a la categoría ")+[xxACT_ItemsCategorias:98]Nombre:1+__ (". ¿Desea cambiarlo a la categoría ")+$catText+__ ("?");__ ("");__ ("No");__ ("Si"))
										If ($r=2)
											GET LIST ITEM:C378(hl_Categorias;List item position:C629(hl_Categorias;[xxACT_Items:179]ID_Categoria:8);$ref;$text;$sublist;$expanded)
											If (List item position:C629(hl_Categorias;[xxACT_Items:179]ID_Categoria:8)<$dropPos)
												If ($expanded)
													$dropPos:=$dropPos-1
												End if 
											End if 
											SET LIST ITEM:C385(hl_Categorias;$ref;$text;$ref;-1;True:C214)
											DELETE FROM LIST:C624(hl_Categorias;[xxACT_Items:179]ID:1)
											SET LIST ITEM:C385(hl_Categorias;$ref;$text;$ref;-1;$expanded)
										End if 
									Else 
										$r:=2
									End if 
								End if 
								If ($r=2)
									GET LIST ITEM:C378(hl_Categorias;$dropPos;$catRef;$catText;$subList)
									[xxACT_Items:179]ID_Categoria:8:=$catRef
									SAVE RECORD:C53([xxACT_Items:179])
									DELETE FROM LIST:C624(hl_Items;[xxACT_Items:179]ID:1)
									If ($subList#0)
										APPEND TO LIST:C376($subList;[xxACT_Items:179]Glosa:2;[xxACT_Items:179]ID:1)
										SORT LIST:C391($subList;>)
										SET LIST ITEM PROPERTIES:C386($subList;[xxACT_Items:179]ID:1;False:C215;0;0)
									Else 
										$subList:=New list:C375
										APPEND TO LIST:C376($subList;[xxACT_Items:179]Glosa:2;[xxACT_Items:179]ID:1)
										SORT LIST:C391($subList;>)
										SET LIST ITEM PROPERTIES:C386($subList;[xxACT_Items:179]ID:1;False:C215;0;0)
										SET LIST ITEM:C385(hl_Categorias;$catRef;$catText;$catRef;$subList;True:C214)
									End if 
								End if 
								_O_REDRAW LIST:C382(hl_Categorias)
								_O_REDRAW LIST:C382(hl_Items)
							End if 
						End if 
					: ($srcObjectName="hl_Categorias")
						$dropPos:=Drop position:C608
						If ($dropPos>0)
							GET LIST ITEM:C378(hl_Categorias;$srcElement;$catRef;$catText;$subList)
							$itemRef:=List item parent:C633(hl_Categorias;$catRef)
							If ($itemRef#0)
								READ WRITE:C146([xxACT_Items:179])
								QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$catRef)
								DELETE FROM LIST:C624(hl_Categorias;$catRef)
								If ($dropPos>$srcElement)
									$dropPos:=$dropPos-1
								End if 
								GET LIST ITEM:C378(hl_Categorias;$dropPos;$Ref;$Text;$subList)
								$itemRef:=List item parent:C633(hl_Categorias;$Ref)
								If ($itemRef#0)
									$dropPos:=List item position:C629(hl_Categorias;$itemRef)
								End if 
								GET LIST ITEM:C378(hl_Categorias;$dropPos;$Ref;$Text;$subList)
								[xxACT_Items:179]ID_Categoria:8:=$Ref
								SAVE RECORD:C53([xxACT_Items:179])
								If ($subList#0)
									APPEND TO LIST:C376($subList;[xxACT_Items:179]Glosa:2;[xxACT_Items:179]ID:1)
									SORT LIST:C391($subList;>)
									SET LIST ITEM PROPERTIES:C386($subList;[xxACT_Items:179]ID:1;False:C215;0;0)
								Else 
									$subList:=New list:C375
									APPEND TO LIST:C376($subList;[xxACT_Items:179]Glosa:2;[xxACT_Items:179]ID:1)
									SORT LIST:C391($subList;>)
									SET LIST ITEM PROPERTIES:C386($subList;[xxACT_Items:179]ID:1;False:C215;0;0)
									SET LIST ITEM:C385(hl_Categorias;$Ref;$Text;$Ref;$subList;True:C214)
								End if 
							Else 
								$elements:=Count list items:C380($sublist)
								If ($elements>0)
									C_LONGINT:C283($subListDrop)
									GET LIST ITEM:C378(hl_Categorias;$dropPos;$Ref;$Text;$subListDrop)
									$itemRef:=List item parent:C633(hl_Categorias;$Ref)
									$go:=True:C214
									If ($itemRef#0)
										$dropPos:=List item position:C629(hl_Categorias;$itemRef)
										If ($catRef=$itemRef)
											$go:=False:C215
										End if 
									Else 
										If ($catRef=$Ref)
											$go:=False:C215
										End if 
									End if 
									If ($go)
										GET LIST ITEM:C378(hl_Categorias;$dropPos;$Ref;$Text;$newSubList)
										$r:=CD_Dlog (0;__ ("Se dispone a trasladar todos los ítems de la categoría ")+$catText+__ (" a la categoría ")+$Text+__ (".\r¿Desea mantener la categoría ")+$catText+__ ("?");__ ("");__ ("No, eliminar");__ ("Si, mantener");__ ("Cancelar"))
										If ($r#3)
											SET LIST ITEM:C385(hl_Categorias;$catRef;$catText;$catRef;0;False:C215)
											CLEAR LIST:C377($sublist)
											_O_REDRAW LIST:C382(hl_Categorias)
											READ WRITE:C146([xxACT_Items:179])
											QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID_Categoria:8=$catRef)
											CREATE SET:C116([xxACT_Items:179];"nuevos")
											APPLY TO SELECTION:C70([xxACT_Items:179];[xxACT_Items:179]ID_Categoria:8:=$Ref)
											KRL_UnloadReadOnly (->[xxACT_Items:179])
											If ($newSubList=0)
												$newSubList:=New list:C375
												SET LIST ITEM:C385(hl_Categorias;$Ref;$Text;$Ref;$newSubList;True:C214)
											End if 
											USE SET:C118("nuevos")
											While (Not:C34(End selection:C36([xxACT_Items:179])))
												APPEND TO LIST:C376($newSubList;[xxACT_Items:179]Glosa:2;[xxACT_Items:179]ID:1)
												SET LIST ITEM PROPERTIES:C386($newSubList;[xxACT_Items:179]ID:1;False:C215;0;0)
												NEXT RECORD:C51([xxACT_Items:179])
											End while 
											SORT LIST:C391($newSubList;>)
											CLEAR SET:C117("nuevos")
											If ($r=1)
												READ WRITE:C146([xxACT_ItemsCategorias:98])
												QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]ID:2=$catRef)
												DELETE SELECTION:C66([xxACT_ItemsCategorias:98])
												KRL_UnloadReadOnly (->[xxACT_ItemsCategorias:98])
												DELETE FROM LIST:C624(hl_Categorias;$catRef)
											End if 
										End if 
									End if 
								End if 
							End if 
							_O_REDRAW LIST:C382(hl_Categorias)
						End if 
				End case 
			End if 
			ACTcfg_HabilitaBtnsCategoriasIt 
	End case 
End if 