//%attributes = {}
  //HL_GetItemListHierLevel

C_LONGINT:C283($subList;$ref)
C_BOOLEAN:C305($expanded)
_O_C_STRING:C293(255;$label)
$list:=$1
$level:=0
GET LIST ITEM:C378($list;Selected list items:C379($list);$ref;$label;$sublist;$expanded)
$parent:=List item parent:C633($list;$ref)
If ($parent#0)
	  //  $level:=$level+1
	  //  $pos:=List item position($list;$parent)
	  //  GET LIST ITEM($list;$pos;$ref;$label;$sublist;$expanded)  
	While ($parent#0)
		$level:=$level+1
		$pos:=List item position:C629($list;$parent)
		GET LIST ITEM:C378($list;$pos;$ref;$label;$sublist;$expanded)
		$parent:=List item parent:C633($list;$ref)
	End while 
End if 
$0:=$level