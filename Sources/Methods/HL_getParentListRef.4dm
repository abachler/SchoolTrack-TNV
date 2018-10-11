//%attributes = {}
  //HL_getParentListRef

C_LONGINT:C283($list;$0;$sublist;$ref)
C_BOOLEAN:C305($expanded)
_O_C_STRING:C293(255;$label)

$list:=$1
$parentListRef:=0
GET LIST ITEM:C378($list;Selected list items:C379($list);$ref;$label;$sublist;$expanded)
$itemLabel:=$label
$parent:=List item parent:C633($list;$ref)
Case of 
	: ($parent#0)
		$parentListRef:=$parent
		$pos:=List item position:C629($list;$parent)
		GET LIST ITEM:C378($list;$pos;$ref;$label;$sublist;$expanded)
		$parentListRef:=$sublist
	: ($sublist>0)
		$parentListRef:=$sublist
End case 
$0:=$parentListRef