Case of 
	: (Form event:C388=On Drop:K2:12)
		RESOLVE POINTER:C394(Self:C308;$varName;$tableNum;$FieldNum)
		XS_Settings ("HandleDrag";$varName)
		
	: (Form event:C388=On Clicked:K2:4)
		If (Contextual click:C713)
			$listElements:=Count list items:C380(Self:C308->)
			GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$itemRef;$itemText)
			If ($listElements<=1)
				$choice:=Pop up menu:C542("(Retirar "+$itemText+" del Módulo")
			Else 
				$choice:=Pop up menu:C542("Retirar "+$itemText+" del Módulo")
			End if 
			Case of 
				: ($choice=1)
					DELETE FROM LIST:C624(Self:C308->;$itemRef)
					XS_Settings ("SaveModuleTables")
			End case 
			_O_REDRAW LIST:C382(Self:C308->)
		End if 
End case 
