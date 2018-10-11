GET LIST ITEM:C378(hl_langages;Selected list items:C379(hl_langages);$itemRef;$langage)
vtXS_Langage:=$langage
vtXS_LangageCode:=ST_GetWord ($langage;1;":")
$currentPage:=FORM Get current page:C276
Case of 
	: ($currentPage=2)
		If (Selected list items:C379(hl_modules)=0)
			SELECT LIST ITEMS BY POSITION:C381(hl_modules;1)
		End if 
		HL_ClearList (hl_ModuleTables)
		hl_ModuleTables:=New list:C375
		GET LIST ITEM:C378(hl_modules;Selected list items:C379(hl_modules);$itemRef;$itemText)
		QUERY:C277([xShell_Tables:51];[xShell_Tables:51]ReferenciaModulo:36=$itemRef)
		SELECTION TO ARRAY:C260([xShell_Tables:51]NombreDeTabla:1;$tableName;[xShell_Tables:51]NumeroDeTabla:5;$tableNumbers)
		For ($i;1;Size of array:C274($tableName))
			APPEND TO LIST:C376(hl_ModuleTables;$tableName{$i};$tableNumbers{$i})
		End for 
		SORT LIST:C391(hl_ModuleTables;>)
		_O_REDRAW LIST:C382(hl_ModuleTables)
		SET LIST PROPERTIES:C387(hl_moduleTables;1;0;16)
		XS_Settings ("GetConfig&WizardsItems")
		_O_REDRAW LIST:C382(hl_modules)
		_O_REDRAW LIST:C382(hl_moduleTables)
		_O_REDRAW LIST:C382(hl_AllTables)
		_O_REDRAW LIST:C382(hl_Configuration)
		_O_REDRAW LIST:C382(hl_Wizards)
		_O_REDRAW LIST:C382(hl_ServicesMenu)
	: ($currentPage=3)
		_O_REDRAW LIST:C382(hl_modules)
		_O_REDRAW LIST:C382(hl_moduleTables)
		_O_REDRAW LIST:C382(hl_AllTables)
		If (Selected list items:C379(hl_modules)=0)
			SELECT LIST ITEMS BY POSITION:C381(hl_modules;1)
		End if 
		XS_Settings ("GetModuleTables")
		XS_Settings ("GetModulePanels")
	: ($currentPage=4)
		_O_REDRAW LIST:C382(hl_modules)
		_O_REDRAW LIST:C382(hl_moduleTables)
		_O_REDRAW LIST:C382(hl_AllTables)
		If (Selected list items:C379(hl_modules)=0)
			SELECT LIST ITEMS BY POSITION:C381(hl_modules;1)
		End if 
		If (Count list items:C380(hl_moduleTables)>0)
			If (Selected list items:C379(hl_moduleTables)=0)
				SELECT LIST ITEMS BY POSITION:C381(hl_moduleTables;1)
			End if 
			GET LIST ITEM:C378(hl_moduleTables;Selected list items:C379(hl_moduleTables);$ref;$text)
			AL_UpdateArrays (xALP_Fields;0)
			XS_LoadFields ($ref)
			AL_UpdateArrays (xALP_Fields;-2)
			VS_RelationsALPsettings ($ref)
			
			If (Size of array:C274(aInt1)>0)
				$line:=1
				$sourceField:=aInt1{$line}
				$relatedfieldNum:=aInt3{$line}
				$relatedtableNum:=aInt2{$line}
				$listItemRef:=Num:C11(String:C10($relatedtableNum)+String:C10($relatedfieldNum;"000"))
				SELECT LIST ITEMS BY REFERENCE:C630(hl_destination;$listItemRef)
				$listItemRef:=Num:C11(String:C10([xShell_Tables:51]NumeroDeTabla:5)+String:C10($sourceField;"000"))
				SELECT LIST ITEMS BY REFERENCE:C630(hl_Source;$listItemRef)
				_O_REDRAW LIST:C382(hl_destination)
				_O_REDRAW LIST:C382(hl_Source)
			Else 
				SELECT LIST ITEMS BY POSITION:C381(hl_destination;0)
				SELECT LIST ITEMS BY POSITION:C381(hl_Source;0)
				_O_REDRAW LIST:C382(hl_destination)
				_O_REDRAW LIST:C382(hl_Source)
			End if 
			$boolCond:=(Size of array:C274(aInt1)>0)
			IT_SetButtonState ($boolCond;->bDelRelation)
			IT_SetButtonState (True:C214;->bRebuildRelations;->vi_RelatedReport;->hl_source;->hl_destination)
			OBJECT SET ENTERABLE:C238(vs_searchmethod;$boolCond)
		Else 
			IT_SetButtonState (False:C215;->bDelRelation;->bAddRelation;->bRebuildRelations;->vi_RelatedReport;->hl_source;->hl_destination)
			REDUCE SELECTION:C351([xShell_Tables:51];0)
			REDUCE SELECTION:C351([xShell_Fields:52];0)
		End if 
		OBJECT SET ENTERABLE:C238(vtXS_TableAlias;(Count list items:C380(hl_moduleTables)>0))
		OBJECT SET ENTERABLE:C238([xShell_Tables:51]PosicionEnExplorador:16;(Count list items:C380(hl_moduleTables)>0))
	: ($currentPage=5)
		XS_Settings ("GetModuleExecutables")
End case 