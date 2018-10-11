Case of 
	: (Form event:C388=On Clicked:K2:4)
		XS_Settings ("GetModuleTables")
		XS_Settings ("GetModuleExecutables")
		XS_Settings ("GetModuleRestrictedMethods")
		XS_Settings ("GetConfig&WizardsItems")
		If (Count list items:C380(hl_moduleTables)>0)
			SELECT LIST ITEMS BY POSITION:C381(hl_moduleTables;1)
			
			
			GET LIST ITEM:C378(hl_moduleTables;Selected list items:C379(hl_moduleTables);$ref;$text)
			AL_UpdateArrays (xALP_Fields;0)
			XS_LoadFields ($ref)
			
			AL_UpdateArrays (xALP_Fields;-2)
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
			IT_SetButtonState (True:C214;->bRebuildRelations;->vi_RelatedReport;->hl_source;->hl_destination;->bAddRelation)
			OBJECT SET ENTERABLE:C238(vs_searchmethod;$boolCond)
		Else 
			IT_SetButtonState (False:C215;->bDelRelation;->bAddRelation;->bRebuildRelations;->vi_RelatedReport;->hl_source;->hl_destination)
			OBJECT SET ENTERABLE:C238(vs_searchmethod;False:C215)
			REDUCE SELECTION:C351([xShell_Tables:51];0)
			REDUCE SELECTION:C351([xShell_Fields:52];0)
		End if 
		OBJECT SET ENTERABLE:C238(vtXS_TableAlias;(Count list items:C380(hl_moduleTables)>0))
		OBJECT SET ENTERABLE:C238([xShell_Tables:51]PosicionEnExplorador:16;(Count list items:C380(hl_moduleTables)>0))
		SELECT LIST ITEMS BY REFERENCE:C630(hl_Modules2;[xShell_Tables:51]ReferenciaModulo:36)
		_O_REDRAW LIST:C382(hl_Modules2)
		
		
	: (Form event:C388=On Losing Focus:K2:8)
		SAVE LIST:C384(Self:C308->;"XS_Modules")
End case 
