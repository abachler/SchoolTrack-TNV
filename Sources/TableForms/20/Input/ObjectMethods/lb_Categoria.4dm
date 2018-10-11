  // [xxSTR_Materias].Input.lb_observaciones()
  //
  //
  // creado por: Alberto Bachler Klein: 01-12-15, 12:02:57
  // -----------------------------------------------------------
C_LONGINT:C283($i)
C_POINTER:C301($y_listaCategorias;$y_objeto_categorias;$y_objeto_observaciones;$y_observaciones)

ARRAY LONGINT:C221($al_filas;0)

  //$y_listboxObservaciones:=OBJECT Get pointer(Object named;"lb_observaciones")
$y_listaCategorias:=OBJECT Get pointer:C1124(Object named:K67:5;"listaCategorias")
$y_observaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"observacion")
$y_objeto_categorias:=OBJECT Get pointer:C1124(Object named:K67:5;"objeto_Categorias")
$y_objeto_observaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"objeto_Observaciones")


Case of 
	: (Form event:C388=On Selection Change:K2:29)
		AT_Initialize ($y_observaciones)
		$y_objeto_categorias->{0}:=$y_listaCategorias->{$y_listaCategorias->}
		AT_SearchArray ($y_objeto_categorias;"=";->$al_filas)
		For ($i;1;Size of array:C274($al_filas))
			If ($y_objeto_observaciones->{$al_filas{$i}}#"")
				APPEND TO ARRAY:C911($y_observaciones->;$y_objeto_observaciones->{$al_filas{$i}})
			End if 
		End for 
		
		
End case 