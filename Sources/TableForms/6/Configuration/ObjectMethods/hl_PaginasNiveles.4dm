C_TEXT:C284($itemText)
GET LIST ITEM:C378(Self:C308->;*;$itemRef;$itemText)

If ($itemRef=5)
	If (<>vtXS_CountryCode="cl")
		vl_LastPageNiveles:=$itemRef
	Else 
		vl_LastPageNiveles:=6
	End if 
Else 
	vl_LastPageNiveles:=$itemRef
End if 
FORM GOTO PAGE:C247(vl_LastPageNiveles)