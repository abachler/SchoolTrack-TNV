$hList:=Copy list:C626(hl_Observaciones)
HL_ExpandAll ($hList)
$nextRefObservación:=HL_GetNextItemRefNumber ($hList)

$pos:=Selected list items:C379(hl_Observaciones)
GET LIST ITEM:C378(hl_Observaciones;*;$itemRef;$itemText;$sublist)
$parentRef:=List item parent:C633(hl_Observaciones;$itemRef)
Case of 
	: ($itemRef<0)
		$parentText:=$itemText
		$parentRef:=$itemRef
	: ($itemRef>0)
		$itemRef:=$parentRef
		$parentText:=HL_FindInListByReference ($hList;$parentRef)
	Else 
		$parentText:=""
End case 



Case of 
	: (Form event:C388=On Alternative Click:K2:36)
		If ($parentText#"")
			$result:=Pop up menu:C542("En "+$parentText+";En la raíz";0)
			Case of 
				: ($result=1)
					If ($itemRef#0)
						SELECT LIST ITEMS BY REFERENCE:C630(hl_Observaciones;$parentRef)
						GET LIST ITEM:C378(hl_Observaciones;*;$parentRef;$parentText;$sublist)
						If ($subList#0)
							$addToListRef:=$sublist
						Else 
							$subList:=New list:C375
							$addToListRef:=$subList
						End if 
					Else 
						$addToListRef:=hl_Observaciones
					End if 
				: ($result=2)
					$addToListRef:=hl_Observaciones
			End case 
		Else 
			$addToListRef:=hl_Observaciones
		End if 
		
	: (Form event:C388=On Clicked:K2:4)
		$addToListRef:=hl_Observaciones
End case 


APPEND TO LIST:C376($addToListRef;"Nueva Observación";$nextRefObservación)
If ($parentRef#0)
	SET LIST ITEM:C385(hl_observaciones;$parentRef;$parentText;$parentRef;$subList;True:C214)
End if 
SELECT LIST ITEMS BY REFERENCE:C630($addToListRef;$nextRefObservación)
SET LIST ITEM PROPERTIES:C386($addToListRef;$nextRefObservación;True:C214;0;0)
_O_REDRAW LIST:C382(hl_Observaciones)
HL_ClearList ($hList)