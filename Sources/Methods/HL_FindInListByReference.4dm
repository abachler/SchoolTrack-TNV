//%attributes = {}
  //HL_FindInListByReference

C_LONGINT:C283($1;$listReference;$2;$itemReference)
C_TEXT:C284($itemText;$foundedItem;$0)
C_BOOLEAN:C305($3;$expandList)
$listReference:=$1
$itemReference:=$2
If (Count parameters:C259=3)
	$expandList:=$3
Else 
	$expandList:=False:C215
End if 


If (Is a list:C621($listReference))
	If ($expandList)
		HL_ExpandAll ($listReference)
	End if 
	For ($i;1;Count list items:C380($listReference))
		GET LIST ITEM:C378($listReference;$i;$ref;$itemText)
		If ($2=$ref)
			$foundedItem:=$itemText
			$i:=Count list items:C380($listReference)+1
		End if 
	End for 
Else 
	$itemText:=""
	ALERT:C41("ERROR: Lista Inexistente")
End if 

$0:=$foundedItem

