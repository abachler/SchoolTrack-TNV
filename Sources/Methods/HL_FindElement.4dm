//%attributes = {}
  //HL_FindElement

C_LONGINT:C283($1;$listReference;$itemPosition;$itemRef;$subList)
C_TEXT:C284($findString;$itemText;$2)
C_BOOLEAN:C305($3;$expanded)
$sourceList:=$1
$findString:=$2
$itemPosition:=-1
If (Count parameters:C259=3)
	$expandList:=True:C214
Else 
	$expandList:=False:C215
End if 


$listReference:=Copy list:C626($sourceList)
If (Is a list:C621($listReference))
	If ($expandList)
		HL_ExpandAll ($listReference)
	End if 
	$items:=Count list items:C380($listReference)
	For ($i;1;$items)
		GET LIST ITEM:C378($listReference;$i;$itemRef;$itemText;$sublist;$expanded)
		If ($itemText=$findString)
			$itemPosition:=$i
			$i:=Count list items:C380($listReference)+1
		End if 
	End for 
Else 
	ALERT:C41("ERROR: Lista Inexistente.")
End if 
CLEAR LIST:C377($listReference)
$0:=$itemPosition

