//%attributes = {}
  //HL_CopyReferencedListToArray

C_POINTER:C301($textarray;$2;$LongintArray;$3)
C_LONGINT:C283($listRef;$1)

If (Count parameters:C259=3)
	$listRef:=$1
	$textarray:=$2
	$LongintArray:=$3
	AT_DimArrays (Count list items:C380($listRef);$textarray;$LongintArray)
	For ($i;1;Count list items:C380($listRef))
		GET LIST ITEM:C378($listRef;$i;$itemRef;$itemText)
		$textarray->{$i}:=$itemText
		$LongintArray->{$i}:=$itemRef
	End for 
Else 
	$listRef:=$1
	$textarray:=$2
	AT_DimArrays (Count list items:C380($listRef);$textarray)
	For ($i;1;Count list items:C380($listRef))
		GET LIST ITEM:C378($listRef;$i;$itemRef;$itemText)
		$textarray->{$i}:=$itemText
	End for 
End if 