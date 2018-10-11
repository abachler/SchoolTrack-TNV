//%attributes = {}
  //HL_getSublistItems

C_LONGINT:C283($list;$0;$sublist;$ref;$pos;$2;$1)
C_BOOLEAN:C305($expanded)
_O_C_STRING:C293(255;$label)
C_POINTER:C301($3;$array)
$list:=$1
$pos:=$2
$array:=$3
GET LIST ITEM:C378($list;$pos;$ref;$label;$sublist;$expanded)
If ($subList>0)
	$sublistName:=$label
	SET LIST ITEM:C385($list;$ref;$label;$ref;$sublist;True:C214)
	AT_Initialize ($array)
	HL_CopyReferencedListToArray ($subList;$array)
End if 