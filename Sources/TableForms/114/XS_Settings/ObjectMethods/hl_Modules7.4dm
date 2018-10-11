C_LONGINT:C283($styles;$icon)
C_BOOLEAN:C305($enterable)
Case of 
	: (Form event:C388=On Drop:K2:12)
		RESOLVE POINTER:C394(Self:C308;$varName;$tableNum;$FieldNum)
		XS_Settings ("HandleDrag";$varName)
	: (Form event:C388=On Clicked:K2:4)
		If (Contextual click:C713)
			$listElements:=Count list items:C380(Self:C308->)
			GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$itemRef;$itemText)
			If ($listElements<=1)
				$choice:=Pop up menu:C542("Agregar Módulo;-;(Retirar "+$itemText+";-;Seleccionar ícono...;Referencia ícono en librería...")
			Else 
				$choice:=Pop up menu:C542("Agregar Módulo;-;Retirar "+$itemText+";-;Seleccionar ícono...;Referencia ícono en librería...")
			End if 
			Case of 
				: ($choice=1)
					APPEND TO LIST:C376(Self:C308->;"Module Name";$listElements+1)
					SAVE LIST:C384(Self:C308->;"XS_Modules")
				: ($choice=3)
					GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$ref;$text)
					DELETE FROM LIST:C624(Self:C308->;$ref)
					SAVE LIST:C384(Self:C308->;"XS_Modules")
				: ($choice=5)
					SET LIST PROPERTIES:C387(Self:C308->;1;0;96)
					GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$ref;$text)
					GET LIST ITEM PROPERTIES:C631(Self:C308->;$itemRef;$enterable;$styles;$icon)
					C_PICTURE:C286($pictureVar)
					READ PICTURE FILE:C678("";$pictureVar)
					
					If (Macintosh option down:C545 | Windows Alt down:C563)
						PICT_ScalePicture (->$pictureVar;64;64)
					End if 
					
					If ($icon=0)
						$icon:=Use PicRef:K28:4+PICT_Append2Library (->$pictureVar;"Module "+$itemText)
					Else 
						SET PICTURE TO LIBRARY:C566($pictureVar;$icon-Use PicRef:K28:4;"Module "+$itemText)
					End if 
					SET LIST ITEM PROPERTIES:C386(Self:C308->;$itemRef;True:C214;0;$icon)
					SAVE LIST:C384(Self:C308->;"XS_Modules")
					
				: ($choice=6)
					$l_referenciaIcono:=Num:C11(Request:C163("Referencia del ícono en la librería..."))
					GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$itemRef;$text)
					GET LIST ITEM PROPERTIES:C631(Self:C308->;$itemRef;$enterable;$styles;$icon)
					SET LIST ITEM PROPERTIES:C386(Self:C308->;$itemRef;True:C214;0;Use PicRef:K28:4+$l_referenciaIcono)
					SAVE LIST:C384(Self:C308->;"XS_Modules")
					
			End case 
			_O_REDRAW LIST:C382(Self:C308->)
		Else 
			XS_Settings ("GetModuleTables")
			XS_Settings ("GetModuleExecutables")
			XS_Settings ("GetModuleRestrictedMethods")
			XS_Settings ("GetConfig&WizardsItems")
		End if 
	: (Form event:C388=On Losing Focus:K2:8)
		SAVE LIST:C384(Self:C308->;"XS_Modules")
End case 
