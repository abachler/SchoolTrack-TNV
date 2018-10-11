//%attributes = {}
  //ADT_ActualizaComoLlego

C_TEXT:C284($1;$text)

$text:=$1

For ($i;1;Count list items:C380(hl_comoLlego))
	GET LIST ITEM:C378(hl_comoLlego;$i;$ref;$texto)
	
	If ($text=$texto)
		SET LIST ITEM PROPERTIES:C386(hl_comoLlego;$ref;False:C215;Bold:K14:2;0;0x00FF)
	Else 
		SET LIST ITEM PROPERTIES:C386(hl_comoLlego;$ref;False:C215;Plain:K14:1;0;0x00FF)
	End if 
End for 
_O_REDRAW LIST:C382(hl_comoLlego)

