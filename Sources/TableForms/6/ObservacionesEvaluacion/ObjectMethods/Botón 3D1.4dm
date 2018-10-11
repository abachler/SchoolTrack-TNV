$nextCategoriaID:=0
For ($i;1;Count list items:C380(hl_observaciones))
	GET LIST ITEM:C378(hl_observaciones;$i;$ref;$text)
	If ($ref<$nextCategoriaID)
		$nextCategoriaID:=$ref
	End if 
End for 
$nextCategoriaID:=$nextCategoriaID-1
APPEND TO LIST:C376(hl_Observaciones;"Nueva Categoría";$nextCategoriaID)
SET LIST ITEM PROPERTIES:C386(hl_observaciones;$nextCategoriaID;True:C214;1;0)
_O_REDRAW LIST:C382(hl_Observaciones)