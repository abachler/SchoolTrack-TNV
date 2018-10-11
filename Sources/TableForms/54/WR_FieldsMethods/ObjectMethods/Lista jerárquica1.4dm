C_BOOLEAN:C305($expanded)
C_LONGINT:C283($subList)
If (Form event:C388=On Double Clicked:K2:5)
	$itemPos:=Selected list items:C379(Self:C308->)
	If ($itemPos>0)
		GET LIST ITEM:C378(Self:C308->;$itemPos;$itemRef;$itemText)
		If ($itemRef>=0)
			$table:=Int:C8($itemRef/1000)
			$field:=Dec:C9($itemRef/1000)*1000
			WR INSERT FIELD:P12000:22 (xWrite;$table;$field)
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
		End if 
	End if 
End if 