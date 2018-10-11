//%attributes = {}
  //HL_ExpandAll


C_BOOLEAN:C305($expanded)
C_LONGINT:C283($subList;$list;$1)
$list:=$1
$items:=Count list items:C380($list)
$i:=0
While ($i<$items)
	$i:=$i+1
	GET LIST ITEM:C378($list;$i;$itemRef;$itemText;$subList;$expanded)
	If ($subList#0)
		SET LIST ITEM:C385($list;$itemRef;$itemText;$itemRef;$subList;True:C214)
	End if 
	$items:=Count list items:C380($list)
End while 