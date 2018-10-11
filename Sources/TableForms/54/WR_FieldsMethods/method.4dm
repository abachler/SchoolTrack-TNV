C_BOOLEAN:C305($expanded)
C_TEXT:C284(XSWR_RefVariable)
C_LONGINT:C283($subList;XSWR_RefTable;XSWR_RefField)
Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		If ((XSWR_RefTable#0) & (XSWR_RefField#0))
			$ref:=Num:C11(String:C10(XSWR_RefTable)+String:C10(XSWR_RefField;"000"))
			SELECT LIST ITEMS BY REFERENCE:C630(hl_TablesFields;$ref)
		Else 
			SELECT LIST ITEMS BY POSITION:C381(hl_TablesFields;-1)
		End if 
		$pos:=HL_FindElement (hl_Methods;XSWR_RefMethod)
		SELECT LIST ITEMS BY POSITION:C381(hl_Methods;$pos)
		asWRVariables{0}:=XSWR_RefVariable
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->asWRVariables;"@";->$DA_Return)
		If (Size of array:C274($DA_Return)=1)
			SELECT LIST ITEMS BY REFERENCE:C630(hl_Variables;$DA_Return{1})
		Else 
			SELECT LIST ITEMS BY POSITION:C381(hl_Variables;-1)
		End if 
		
		_O_REDRAW LIST:C382(hl_TablesFields)
		_O_REDRAW LIST:C382(hl_Methods)
		_O_REDRAW LIST:C382(hl_Variables)
		OBJECT SET ENTERABLE:C238(hl_TablesFields;False:C215)
		OBJECT SET ENTERABLE:C238(hl_Methods;False:C215)
		OBJECT SET ENTERABLE:C238(hl_Variables;False:C215)
	: (Form event:C388=On Close Box:K2:21)
		$items:=Count list items:C380(hl_TablesFields)
		$i:=0
		While ($i<$items)
			$i:=$i+1
			GET LIST ITEM:C378(hl_TablesFields;$i;$itemRef;$itemText;$subList;$expanded)
			SET LIST ITEM:C385(hl_TablesFields;$itemRef;$itemText;$itemRef;$subList;False:C215)
			$items:=Count list items:C380(hl_TablesFields)
		End while 
		_O_REDRAW LIST:C382(hl_TablesFields)
		$items:=Count list items:C380(hl_Variables)
		$i:=0
		While ($i<$items)
			$i:=$i+1
			GET LIST ITEM:C378(hl_Variables;$i;$itemRef;$itemText;$subList;$expanded)
			SET LIST ITEM:C385(hl_Variables;$itemRef;$itemText;$itemRef;$subList;False:C215)
			$items:=Count list items:C380(hl_Variables)
		End while 
		_O_REDRAW LIST:C382(hl_Variables)
		CANCEL:C270
End case 