Case of 
	: (Form event:C388=On Clicked:K2:4)
		If (Record number:C243([xShell_Tables:51])>=0)
			VS_SaveTableProperties 
		End if 
		GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$ref;$text)
		READ WRITE:C146([xShell_Tables:51])
		AL_UpdateArrays (xALP_Fields;0)
		XS_LoadFields ($ref)
		AL_UpdateArrays (xALP_Fields;-2)
		VS_RelationsALPsettings ($ref)
		If (Size of array:C274(al_NumeroCampoPrincipal)>0)
			$line:=1
			$sourceField:=al_NumeroCampoPrincipal{$line}
			$relatedfieldNum:=al_NumeroCampoPrincipal{$line}
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
		$boolCond:=(Size of array:C274(al_numeroCampoRelacionado)>0)
		IT_SetButtonState ($boolCond;->bDelRelation)
		IT_SetButtonState (True:C214;->bRebuildRelations;->vi_RelatedReport;->hl_source;->hl_destination)
		OBJECT SET ENTERABLE:C238(vs_searchmethod;True:C214)
End case 