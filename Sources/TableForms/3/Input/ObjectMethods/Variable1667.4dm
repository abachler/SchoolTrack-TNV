C_LONGINT:C283($ref)
C_TEXT:C284($text)
Case of 
	: (Form event:C388=On Clicked:K2:4)
		GET LIST ITEM:C378(hl_jornada;Selected list items:C379(hl_jornada);$ref;$text)
		If ($ref>0)
			[Cursos:3]Jornada:32:=$ref
		End if 
End case 