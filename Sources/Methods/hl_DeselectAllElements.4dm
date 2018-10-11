//%attributes = {}
  //hl_DeselectAllElements

C_LONGINT:C283($1;$listRef)
$listRef:=$1

If (Is a list:C621($listRef))
	$items:=Count list items:C380($listRef)
	SELECT LIST ITEMS BY POSITION:C381($listRef;$items+1)
End if 