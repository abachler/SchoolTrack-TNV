//%attributes = {}
  //HL_ReReferenceList

C_LONGINT:C283($0;$1;$list)
C_POINTER:C301($2;$IconRefs)
C_LONGINT:C283($offset)
C_TEXT:C284($3;$IconType)

$list:=$1
$IconType:="PICL"
Case of 
	: (Count parameters:C259=2)
		$IconRefs:=$2
	: (Count parameters:C259=3)
		$IconRefs:=$2
		$IconType:=$3
End case 
Case of 
	: ($IconType="cicn")
		$offset:=0
	: ($IconType="PICT")
		$offset:=65536
	: ($IconType="PICL")
		$offset:=Use PicRef:K28:4
End case 

ARRAY TEXT:C222($array;0)
ARRAY LONGINT:C221($array2;0)
If (Is a list:C621($list))
	SAVE LIST:C384($list;"HL_Rereferencer")
	HL_CopyReferencedListToArray ($list;->$array;->$array2)
	For ($i;1;Size of array:C274($array))
		$array2{$i}:=$i
	End for 
	AT_Array2ReferencedList (->$array;->$array2;$list)
	SAVE LIST:C384($list;"HL_Rereferencer")
	CLEAR LIST:C377($list)
	$list:=Load list:C383("HL_Rereferencer")
	If (Not:C34(Is nil pointer:C315($IconRefs)))
		For ($i;1;Count list items:C380($list))
			GET LIST ITEM:C378($list;$i;$itemRef;$itemText)
			GET LIST ITEM PROPERTIES:C631($list;$ItemRef;$enterable;$styles)
			SET LIST ITEM PROPERTIES:C386($list;$ItemRef;$enterable;$styles;$IconRefs->{$i}+$offset)
		End for 
	End if 
	$0:=$list
End if 