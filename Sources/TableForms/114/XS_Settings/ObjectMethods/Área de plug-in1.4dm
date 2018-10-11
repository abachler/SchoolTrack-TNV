$line:=AL_GetLine (xALP_RelatedFields)

If ($line>0)
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
IT_SetButtonState (($line>0);->bDelRelation;->bRebuildRelations;->vi_RelatedReport;->hl_source;->hl_destination)
OBJECT SET ENTERABLE:C238(vs_searchmethod;($line>0))

