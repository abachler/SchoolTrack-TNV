C_POINTER:C301($fieldPtr)
C_LONGINT:C283(hlQR_SortList)
C_BOOLEAN:C305($enterable)
C_LONGINT:C283($styles)

  //****INICIALIZACIONES****


  //****CUERPO****
Case of 
	: (Form event:C388=On Load:K2:1)
		  //HL_ClearList (hl_OrderDefinition)
		  //hl_OrderDefinition:=New list
		SET LIST PROPERTIES:C387(hl_OrderDefinition;0;0;18)
		_O_REDRAW LIST:C382(hl_OrderDefinition)
	: (Form event:C388=On Drag Over:K2:13)
		DRAG AND DROP PROPERTIES:C607($sourceObject;$sourceNumber;$sourceProcess)
		GET LIST ITEM:C378($sourceObject->;$sourceNumber;$itemRef;$itemText)
		Case of 
			: ($sourceObject=(Self:C308))
				$0:=0
			: ($sourceObject=(->hl_Columns))
				$0:=0
			Else 
				$0:=-1
		End case 
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($sourceObject;$sourceNumber;$sourceProcess)
		If ($sourceObject=(->hl_Columns))
			$dropPosition:=Drop position:C608  // Because we may need to change this.
			GET LIST ITEM:C378($sourceObject->;$sourceNumber;$itemRef;$itemText)
			$found:=HL_FindInListByReference (Self:C308->;$itemRef)
			If ($found="")
				If ($dropPosition>0)
					GET LIST ITEM:C378(Self:C308->;$dropPosition;$beforeItemRef;$beforeItemitemText)
					INSERT IN LIST:C625(Self:C308->;$beforeItemRef;$itemText;$itemRef)
				Else 
					APPEND TO LIST:C376(Self:C308->;$itemText;$itemRef)
				End if 
				SET LIST ITEM PROPERTIES:C386(Self:C308->;$itemRef;False:C215;Plain:K14:1;23087+Use PicRef:K28:4)
				IT_SetButtonState ((Count list items:C380(Self:C308->)>0);->bClean;->bOrder)
			End if 
		Else 
			$dropPosition:=Drop position:C608  // Because we may need to change this.
			If ($dropPosition=-1)
				$dropPosition:=Count list items:C380($sourceObject->)+1
			End if 
			$items:=Count list items:C380($sourceObject->)
			GET LIST ITEM:C378($sourceObject->;$sourceNumber;$itemRef;$itemText)
			GET LIST ITEM PROPERTIES:C631($sourceObject->;$itemRef;$enterable;$styles;$icon)
			DELETE FROM LIST:C624($sourceObject->;$itemRef)
			If ($dropPosition>$items)
				APPEND TO LIST:C376($sourceObject->;$itemText;$itemRef)
				SET LIST ITEM PROPERTIES:C386($sourceObject->;$itemRef;$enterable;$styles;$icon)
			Else 
				If ($dropPosition>Count list items:C380($sourceObject->))
					APPEND TO LIST:C376($sourceObject->;$itemText;$itemRef)
					SET LIST ITEM PROPERTIES:C386($sourceObject->;$itemRef;$enterable;$styles;$icon)
				Else 
					GET LIST ITEM:C378($sourceObject->;$dropPosition;$beforeRef;$beforeText)
					INSERT IN LIST:C625($sourceObject->;$beforeRef;$itemText;$itemRef)
					SET LIST ITEM PROPERTIES:C386($sourceObject->;$itemRef;$enterable;$styles;$icon)
				End if 
			End if 
		End if 
		_O_REDRAW LIST:C382(Self:C308->)
	: (Form event:C388=On Clicked:K2:4)
		If (Contextual click:C713)
			GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$itemRef;$itemText)
			GET LIST ITEM PROPERTIES:C631(Self:C308->;$itemRef;$enterable;$styles;$icon)
			Case of 
				: ($icon=(23087+Use PicRef:K28:4))  //orden ascendente
					$popupText:="!"+Char:C90(18)+"Orden ascendente;Orden descendente;(-;Retirar"
				: ($icon=(23086+Use PicRef:K28:4))  // orden descendiente
					$popupText:="Orden ascendente;"+"!"+Char:C90(18)+"Orden descendente;(-;Retirar"
			End case 
			$choice:=Pop up menu:C542($popupText)
			Case of 
				: ($choice=1)
					SET LIST ITEM PROPERTIES:C386(Self:C308->;$itemRef;False:C215;Plain:K14:1;23087+Use PicRef:K28:4)
				: ($choice=2)
					SET LIST ITEM PROPERTIES:C386(Self:C308->;$itemRef;False:C215;Plain:K14:1;23086+Use PicRef:K28:4)
				: ($choice=4)
					DELETE FROM LIST:C624(Self:C308->;$itemRef)
					IT_SetButtonState ((Count list items:C380(Self:C308->)>0);->bClean;->bOrder)
			End case 
			_O_REDRAW LIST:C382(Self:C308->)
		Else 
			GET MOUSE:C468($mouseX;$mouseY;$mouseButton)
			OBJECT GET COORDINATES:C663(Self:C308->;$left;$top;$right;$bottom)
			Case of 
				: (($mouseX>$left) & ($mouseX<=($left+15)))
					GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$itemRef;$itemText)
					GET LIST ITEM PROPERTIES:C631(Self:C308->;$itemRef;$enterable;$styles;$icon)
					If ($icon=(23086+Use PicRef:K28:4))
						$icon:=23087+Use PicRef:K28:4
					Else 
						$icon:=23086+Use PicRef:K28:4
					End if 
					SET LIST ITEM PROPERTIES:C386(Self:C308->;$itemRef;$enterable;$styles;$icon)
					_O_REDRAW LIST:C382(Self:C308->)
			End case 
		End if 
End case 