  // [xxSTR_Materias].Input.Botón1()
  //
  //
  // creado por: Alberto Bachler Klein: 03-12-15, 10:26:55
  // -----------------------------------------------------------
C_LONGINT:C283($i;$l_encontrados;$l_posicion;$l_position)
C_POINTER:C301($y_ListaCategorias;$y_objeto_categorias;$y_objeto_observaciones;$y_Observacion)

ARRAY LONGINT:C221($al_filas;0)

$y_Observacion:=OBJECT Get pointer:C1124(Object named:K67:5;"observacion")
$y_ListaCategorias:=OBJECT Get pointer:C1124(Object named:K67:5;"listaCategorias")
$y_objeto_categorias:=OBJECT Get pointer:C1124(Object named:K67:5;"objeto_Categorias")
$y_objeto_observaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"objeto_Observaciones")


If (($y_ListaCategorias->>0) & ($y_Observacion->>0))
	$y_objeto_categorias->{0}:=$y_ListaCategorias->{$y_ListaCategorias->}
	$y_objeto_observaciones->{0}:=$y_Observacion->{$y_Observacion->}
	$l_encontrados:=AT_MultiArraySearch (False:C215;->$al_filas;$y_objeto_categorias;$y_objeto_observaciones)
	
	DELETE FROM ARRAY:C228($y_Observacion->;$y_Observacion->)
	
	If ($l_encontrados>=1)
		SORT ARRAY:C229($al_filas;<)
		For ($i;1;Size of array:C274($al_filas))
			DELETE FROM ARRAY:C228($y_objeto_categorias->;$al_filas{$i})
			DELETE FROM ARRAY:C228($y_objeto_observaciones->;$al_filas{$i})
		End for 
	End if 
	
	CFGstr_GuardaObsSubsectores 
	Case of 
		: ($y_Observacion->=0)
			LISTBOX SELECT ROW:C912(*;"lb_observaciones";0;lk replace selection:K53:1)
		: ($y_Observacion->>Size of array:C274($y_Observacion->))
			LISTBOX SELECT ROW:C912(*;"lb_observaciones";$y_Observacion->-1;lk replace selection:K53:1)
		Else 
			LISTBOX SELECT ROW:C912(*;"lb_observaciones";$y_Observacion->;lk replace selection:K53:1)
	End case 
End if 
