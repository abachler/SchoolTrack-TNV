C_BOOLEAN:C305($expanded)
C_LONGINT:C283($subList)
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