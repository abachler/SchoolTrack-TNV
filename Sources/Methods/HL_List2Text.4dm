//%attributes = {}
  //HL_List2Text

$listName:=$1
If (Count parameters:C259=2)
	$delim:=$2
Else 
	$delim:=";"
End if 
$text:=""
$listRef:=Load list:C383($listName)
For ($i;1;Count list items:C380($listRef))
	GET LIST ITEM:C378($listRef;$i;$ItemRef;$ItemText)
	$text:=$text+$ItemText+$delim
End for 
$0:=Substring:C12($text;1;Length:C16($text)-1)