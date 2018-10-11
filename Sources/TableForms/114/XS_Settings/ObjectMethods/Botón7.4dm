$lastObject:=Focus object:C278
RESOLVE POINTER:C394($lastObject;$varName;$tableNum;$fieldNum)
Case of 
	: ($varName="hl_ModulePanels")
		$items:=Count list items:C380($lastObject->)
		If ($items>0)
			OK:=CD_Dlog (0;__ ("¿Retirar el panel del explorador del módulo?");__ ("");__ ("Si");__ ("No"))
			If (OK=1)
				$selected:=Selected list items:C379($lastObject->)
				GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$ModuleRef;$itemText)
				XS_RemovePanelInAllBlobs ($ModuleRef;$selected)
				$items:=Count list items:C380($lastObject->)
				Case of 
					: ($items=0)
						CLEAR LIST:C377(hl_panelColumns;*)
						hl_panelColumns:=New list:C375
						CLEAR LIST:C377(hl_RelatedFields;*)
						hl_RelatedFields:=New list:C375
					: ($items>$selected)
						SELECT LIST ITEMS BY POSITION:C381($lastObject->;$selected)
						XS_Settings ("GetPanelColumns")
					Else 
						SELECT LIST ITEMS BY POSITION:C381($lastObject->;$selected-1)
						XS_Settings ("GetPanelColumns")
				End case 
				_O_REDRAW LIST:C382($lastObject->)
			End if 
		Else 
			BEEP:C151
		End if 
		
	: ($varName="hl_PanelColumns")
		$items:=Count list items:C380($lastObject->)
		If ($items>0)
			$selected:=Selected list items:C379($lastObject->)
			GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$ModuleRef;$itemText)
			GET LIST ITEM:C378(hl_ModulePanels;Selected list items:C379(hl_ModulePanels);$mainTableRef;$mainTableName)
			XS_RemoveColumnFromAllPanelBlob ($ModuleRef;$selected;$mainTableRef)
			$items:=Count list items:C380($lastObject->)
			Case of 
				: ($items=0)
					vtVS_FieldHeader:=""
					vtVS_FieldFormat:=""
					viVS_ColumnWidth:=0
				: ($items>$selected)
					SELECT LIST ITEMS BY POSITION:C381($lastObject->;$selected)
					XS_Settings ("GetColumnProperties")
				Else 
					$items:=Count list items:C380($lastObject->)
					If ($items>0)
						SELECT LIST ITEMS BY POSITION:C381($lastObject->;$selected-1)
						XS_Settings ("GetColumnProperties")
					End if 
			End case 
			_O_REDRAW LIST:C382($lastObject->)
		Else 
			BEEP:C151
		End if 
	: ($varName="hl_QuickFindFields")
		$items:=Count list items:C380($lastObject->)
		If ($items>0)
			$selected:=Selected list items:C379($lastObject->)
			GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$ModuleRef;$itemText)
			GET LIST ITEM:C378(hl_ModulePanels;Selected list items:C379(hl_ModulePanels);$mainTableRef;$mainTableName)
			XS_RemoveQFFromAllPanelBlobs ($ModuleRef;$selected;$mainTableRef)
			$items:=Count list items:C380($lastObject->)
			Case of 
				: ($items=0)
					vtVS_QFSpecialRelationMethod:=""
					SELECT LIST ITEMS BY POSITION:C381($lastObject->;-1)
				: ($items>$selected)
					SELECT LIST ITEMS BY POSITION:C381($lastObject->;$selected)
					XS_Settings ("GetColumnProperties")
				Else 
					$items:=Count list items:C380($lastObject->)
					If ($items>0)
						SELECT LIST ITEMS BY POSITION:C381($lastObject->;$selected-1)
						XS_Settings ("GetColumnProperties")
					End if 
			End case 
			_O_REDRAW LIST:C382($lastObject->)
			XS_Settings ("GetQFRelationsProperties")
		Else 
			BEEP:C151
		End if 
End case 

