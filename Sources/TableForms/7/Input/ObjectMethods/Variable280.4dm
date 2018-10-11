C_TEXT:C284($text)
C_LONGINT:C283($ref)
GET LIST ITEM:C378(hlTab_STR_personas;Selected list items:C379(hlTab_STR_personas);$ref;$text)

Case of 
	: ($ref=1)
		FORM GOTO PAGE:C247(1)
	: ($ref=2)
		FORM GOTO PAGE:C247(2)
End case 
