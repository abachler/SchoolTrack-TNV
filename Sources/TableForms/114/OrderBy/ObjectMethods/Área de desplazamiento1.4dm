Case of 
	: (Form event:C388=On Drag Over:K2:13)
		DRAG AND DROP PROPERTIES:C607($sourceObject;$sourceNumber;$sourceProcess)
		If ($sourceObject=(->hl_OrderDefinition))
			$0:=0
		Else 
			$0:=-1
		End if 
		
		
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($sourceObject;$sourceNumber;$sourceProcess)
		
		  //Allow the user to delete items from the Sort list by dragging them back.
		If ($sourceObject=(->hl_OrderDefinition))
			GET LIST ITEM:C378($sourceObject->;$sourceNumber;$itemRef;$itemText)
			DELETE FROM LIST:C624(hl_OrderDefinition;$itemRef)
			_O_REDRAW LIST:C382(hl_OrderDefinition)
			IT_SetButtonState ((Count list items:C380(hl_OrderDefinition)>0);->bClean;->bOrder)
		End if 
End case 