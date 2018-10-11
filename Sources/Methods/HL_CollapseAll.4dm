//%attributes = {}
  //HL_CollapseAll


C_BOOLEAN:C305($expanded)
C_LONGINT:C283($subList;$list;$1)
$list:=$1
$items:=Count list items:C380($list)
$i:=0
While ($i<$items)
	$i:=$i+1
	GET LIST ITEM:C378($list;$i;$itemRef;$itemText;$subList;$expanded)
	SET LIST ITEM:C385($list;$itemRef;$itemText;$itemRef;$subList;False:C215)
	$items:=Count list items:C380($list)
End while 