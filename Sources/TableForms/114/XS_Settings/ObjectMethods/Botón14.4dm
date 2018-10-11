$currentPage:=FORM Get current page:C276
Case of 
	: ($currentPage=2)
		FORM PREVIOUS PAGE:C249
		OBJECT SET VISIBLE:C603(hl_modules;False:C215)
		OBJECT SET VISIBLE:C603(hl_moduleTables;False:C215)
		OBJECT SET VISIBLE:C603(hl_AllTables;False:C215)
		OBJECT SET VISIBLE:C603(hl_modules;True:C214)
		_O_ENABLE BUTTON:C192(bNextPage)
		_O_DISABLE BUTTON:C193(bPreviousPage)
	: ($currentPage=3)
		If (Selected list items:C379(hl_modules)=0)
			SELECT LIST ITEMS BY POSITION:C381(hl_modules;1)
		End if 
		XS_Settings ("GetModuleTables")
		XS_Settings ("GetConfig&WizardsItems")
		OBJECT SET VISIBLE:C603(hl_modules;True:C214)
		OBJECT SET VISIBLE:C603(hl_moduleTables;True:C214)
		OBJECT SET VISIBLE:C603(hl_AllTables;True:C214)
		_O_REDRAW LIST:C382(hl_modules)
		_O_REDRAW LIST:C382(hl_moduleTables)
		_O_REDRAW LIST:C382(hl_AllTables)
		_O_REDRAW LIST:C382(hl_Configuration)
		_O_REDRAW LIST:C382(hl_Wizards)
		_O_REDRAW LIST:C382(hl_ServicesMenu)
		FORM PREVIOUS PAGE:C249
		_O_ENABLE BUTTON:C192(bNextPage)
		_O_ENABLE BUTTON:C192(bPreviousPage)
	: ($currentPage=4)
		FORM PREVIOUS PAGE:C249
		OBJECT SET VISIBLE:C603(hl_modules;False:C215)
		OBJECT SET VISIBLE:C603(hl_moduleTables;False:C215)
		OBJECT SET VISIBLE:C603(hl_AllTables;False:C215)
		_O_REDRAW LIST:C382(hl_modules)
		_O_REDRAW LIST:C382(hl_moduleTables)
		_O_REDRAW LIST:C382(hl_AllTables)
		OBJECT SET VISIBLE:C603(hl_modules;True:C214)
		OBJECT SET VISIBLE:C603(hl_moduleTables;True:C214)
		If (Selected list items:C379(hl_modules)=0)
			SELECT LIST ITEMS BY POSITION:C381(hl_modules;1)
		End if 
		XS_Settings ("GetModuleTables")
		XS_Settings ("GetModulePanels")
		_O_ENABLE BUTTON:C192(bNextPage)
		_O_ENABLE BUTTON:C192(bPreviousPage)
	: ($currentPage=5)
		FORM PREVIOUS PAGE:C249
		_O_REDRAW LIST:C382(hl_modules)
		_O_REDRAW LIST:C382(hl_moduleTables)
		_O_REDRAW LIST:C382(hl_AllTables)
		If (Selected list items:C379(hl_modules)=0)
			SELECT LIST ITEMS BY POSITION:C381(hl_modules;1)
		End if 
		If (Count list items:C380(hl_moduleTables)>0)
			SELECT LIST ITEMS BY POSITION:C381(hl_moduleTables;1)
			GET LIST ITEM:C378(hl_moduleTables;Selected list items:C379(hl_moduleTables);$ref;$text)
			AL_UpdateArrays (xALP_Fields;0)
			XS_LoadFields ($ref)
			AL_UpdateArrays (xALP_Fields;-2)
			AL_SetLine (xALP_Fields;0)
			VS_RelationsALPsettings ($ref)
			If (Size of array:C274(al_NumeroCampoPrincipal)>0)
				$line:=1
				$sourceField:=al_NumeroCampoPrincipal{$line}
				$relatedfieldNum:=al_numeroCampoRelacionado{$line}
				$relatedtableNum:=al_numeroTablaRelacionada{$line}
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
			$boolCond:=(Size of array:C274(al_NumeroCampoPrincipal)>0)
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
		OBJECT SET VISIBLE:C603(hl_modules;True:C214)
		OBJECT SET VISIBLE:C603(hl_moduleTables;True:C214)
		OBJECT SET VISIBLE:C603(hl_AllTables;True:C214)
		_O_ENABLE BUTTON:C192(bNextPage)
		_O_ENABLE BUTTON:C192(bPreviousPage)
End case 
vsXS_SettingsPage:=atXS_JumpMenu{$currentPage-1}