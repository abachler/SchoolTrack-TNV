C_LONGINT:C283($subList)
C_BOOLEAN:C305($expanded)
Case of 
	: (Form event:C388=On Clicked:K2:4)
		If (Contextual click:C713)
			GET LIST ITEM:C378(hl_Observaciones;Selected list items:C379(hl_Observaciones);$itemRef;$itemText;$subList;$expanded)
			If ($itemRef<0)
				$popupItems:="Añadir Categoría;Añadir Observación en \""+$itemText+"\";(-;Borrar Categoría"
				$choice:=Pop up menu:C542($popupItems)
				Case of 
					: ($choice=1)
						$nextCategoriaID:=0
						For ($i;1;Count list items:C380(hl_observaciones))
							GET LIST ITEM:C378(hl_observaciones;$i;$ref;$text)
							If ($ref<$nextCategoriaID)
								$nextCategoriaID:=$ref
							End if 
						End for 
						$nextCategoriaID:=$nextCategoriaID-1
						APPEND TO LIST:C376(hl_Observaciones;"Nueva Categoría";$nextCategoriaID)
						_O_REDRAW LIST:C382(hl_Observaciones)
					: ($choice=2)
						$hList:=Copy list:C626(hl_Observaciones)
						HL_ExpandAll ($hList)
						$nextRefObservación:=HL_GetNextItemRefNumber ($hList)
						If ($subList=0)
							$subList:=New list:C375
						End if 
						APPEND TO LIST:C376($subList;"Nueva Observación";$nextRefObservación)
						SET LIST ITEM:C385(hl_observaciones;$itemRef;$itemText;$itemRef;$subList;True:C214)
						SET LIST ITEM PROPERTIES:C386(hl_observaciones;$nextRefObservación;True:C214;0;0)
						_O_REDRAW LIST:C382(hl_observaciones)
						HL_ClearList ($hList)
					: ($choice=4)
						$r:=CD_Dlog (0;__ ("¿Desea eliminar la categoría seleccionada y todas las observaciones que dependen de ella?");__ ("");__ ("No");__ ("Si"))
						If ($r=2)
							DELETE FROM LIST:C624(hl_Observaciones;$itemRef)
							_O_REDRAW LIST:C382(hl_Observaciones)
						End if 
						
				End case 
			Else 
				$popupItems:="Añadir Categoría;Añadir Observación;(-;Borrar Observación"
				$choice:=Pop up menu:C542($popupItems)
				Case of 
					: ($choice=1)
						$nextCategoriaID:=0
						For ($i;1;Count list items:C380(hl_observaciones))
							GET LIST ITEM:C378(hl_observaciones;$i;$ref;$text)
							If ($ref<$nextCategoriaID)
								$nextCategoriaID:=$ref
							End if 
						End for 
						$nextCategoriaID:=$nextCategoriaID-1
						APPEND TO LIST:C376(hl_Observaciones;"Nueva Categoría";$nextCategoriaID)
						_O_REDRAW LIST:C382(hl_Observaciones)
					: ($choice=2)
						  //$itemRef:=HL_getParentListRef (hl_Observaciones)
						  //SELECT LIST ITEM BY REFERENCE(hl_Observaciones;$itemRef)
						$itemRef:=List item parent:C633(hl_Observaciones;$itemRef)
						SELECT LIST ITEMS BY REFERENCE:C630(hl_Observaciones;$itemRef)
						GET LIST ITEM:C378(hl_Observaciones;Selected list items:C379(hl_Observaciones);$itemRef;$itemText;$subList;$expanded)
						
						$hList:=Copy list:C626(hl_Observaciones)
						HL_ExpandAll ($hList)
						$nextRefObservación:=HL_GetNextItemRefNumber ($hList)
						If ($subList=0)
							$subList:=New list:C375
						End if 
						APPEND TO LIST:C376($subList;"Nueva Observación";$nextRefObservación)
						SET LIST ITEM:C385(hl_observaciones;$itemRef;$itemText;$itemRef;$subList;True:C214)
						SELECT LIST ITEMS BY REFERENCE:C630(hl_observaciones;$nextRefObservación)
						SET LIST ITEM PROPERTIES:C386(hl_observaciones;$nextRefObservación;True:C214;0;0)
						_O_REDRAW LIST:C382(hl_observaciones)
						HL_ClearList ($hList)
						
					: ($choice=4)
						$r:=CD_Dlog (0;__ ("¿Desea eliminar la observación seleccionada?");__ ("");__ ("Si");__ ("No"))
						If ($r=1)
							DELETE FROM LIST:C624(hl_Observaciones;$itemRef)
							_O_REDRAW LIST:C382(hl_Observaciones)
						End if 
						
				End case 
				
			End if 
			
		End if 
		
		
		
		
	: (Form event:C388=On Drag Over:K2:13)
	: (Form event:C388=On Data Change:K2:15)
End case 
