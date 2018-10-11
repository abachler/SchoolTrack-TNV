  // [xxSTR_Materias].Input.Botón1()
  // 
  //
  // creado por: Alberto Bachler Klein: 03-12-15, 10:26:55
  // -----------------------------------------------------------

C_LONGINT:C283($l_posicion;$l_position)
C_POINTER:C301($y_ListaCategorias;$y_objeto_categorias;$y_objeto_observaciones;$y_Observacion)

ARRAY LONGINT:C221($al_filas;0)

$y_Observacion:=OBJECT Get pointer:C1124(Object named:K67:5;"observacion")
$y_ListaCategorias:=OBJECT Get pointer:C1124(Object named:K67:5;"listaCategorias")
$y_objeto_categorias:=OBJECT Get pointer:C1124(Object named:K67:5;"objeto_Categorias")
$y_objeto_observaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"objeto_Observaciones")

If ($y_ListaCategorias->>0)
	$y_objeto_categorias->{0}:=$y_ListaCategorias->{$y_ListaCategorias->}
	$l_encontrados:=AT_MultiArraySearch (False:C215;->$al_filas;$y_objeto_categorias)
	
	DELETE FROM ARRAY:C228($y_ListaCategorias->;$y_ListaCategorias->)
	
	If (Size of array:C274($al_filas)>0)
		SORT ARRAY:C229($al_filas;<)
		For ($l_position;1;Size of array:C274($al_filas))
			If ($al_filas{$l_position}>0)
				DELETE FROM ARRAY:C228($y_objeto_categorias->;$al_filas{$l_position})
				DELETE FROM ARRAY:C228($y_objeto_observaciones->;$al_filas{$l_position})
			End if 
		End for 
	End if 
	
	
	CFGstr_GuardaObsSubsectores 
	Case of 
		: ($y_ListaCategorias->=0)
			$l_filaSeleccionada:=0
		: ($y_ListaCategorias->>Size of array:C274($y_ListaCategorias->))
			$l_filaSeleccionada:=$y_ListaCategorias->-1
		Else 
			$l_filaSeleccionada:=$y_ListaCategorias->
	End case 
	
	CFGstr_LeeObsSubsectores 
	
	
	LISTBOX SELECT ROW:C912(*;"lb_Categoria";$l_filaSeleccionada;lk replace selection:K53:1)
	
	AT_Initialize ($y_Observacion)
	$y_objeto_categorias->{0}:=$y_listaCategorias->{$y_listaCategorias->}
	AT_SearchArray ($y_objeto_categorias;"=";->$al_filas)
	For ($i;1;Size of array:C274($al_filas))
		If ($y_objeto_observaciones->{$al_filas{$i}}#"")
			APPEND TO ARRAY:C911($y_Observacion->;$y_objeto_observaciones->{$al_filas{$i}})
		End if 
	End for 
	
	
End if 