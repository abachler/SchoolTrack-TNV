C_BOOLEAN:C305($enterable)
C_LONGINT:C283($styles)


Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		$itemPos:=Selected list items:C379(Self:C308->)
		$pos:=HL_FindElement (hl_PaisesSistema;"cl: Chile")
		If ($itemPos>0)
			If ($itemPos=$pos)
				BEEP:C151
			Else 
				GET LIST ITEM PROPERTIES:C631(Self:C308->;*;$enterable;$styles;$icon)
				$icon:=$icon-Use PicRef:K28:4
				If ($icon=2077)
					SET LIST ITEM PROPERTIES:C386(Self:C308->;*;$enterable;$styles;Use PicRef:K28:4+2078)
				Else 
					SET LIST ITEM PROPERTIES:C386(Self:C308->;*;$enterable;$styles;Use PicRef:K28:4+2077)
				End if 
				_O_REDRAW LIST:C382(Self:C308->)
			End if 
		End if 
		GET LIST ITEM PROPERTIES:C631(Self:C308->;*;$enterable;$styles;$icon)
		$icon:=$icon-Use PicRef:K28:4
		IT_SetButtonState (($icon=2078);->bDelPaisSistema)
	: (Form event:C388=On Clicked:K2:4)
		$itemPos:=Selected list items:C379(Self:C308->)
		If ($itemPos>0)
			GET LIST ITEM PROPERTIES:C631(Self:C308->;*;$enterable;$styles;$icon)
			$icon:=$icon-Use PicRef:K28:4
			IT_SetButtonState (($icon=2078);->bDelPaisSistema)
		Else 
			_O_DISABLE BUTTON:C193(bDelPaisSistema)
		End if 
End case 