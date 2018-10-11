$t_title:=OBJECT Get title:C1068(Self:C308->)

If ($t_title="Selecciona@")
	For ($i;1;Size of array:C274(ab_seleccionadoMadre))
		ab_seleccionadoMadre{$i}:=True:C214
	End for 
	
	OBJECT SET TITLE:C194(Self:C308->;"Desmarcar todos")
Else 
	For ($i;1;Size of array:C274(ab_seleccionadoMadre))
		ab_seleccionadoMadre{$i}:=False:C215
	End for 
	
	OBJECT SET TITLE:C194(Self:C308->;"Seleccionar todos")
End if 