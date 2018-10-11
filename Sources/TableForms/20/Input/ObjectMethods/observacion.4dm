  // [xxSTR_Materias].Input.observacion()
  //
  //
  // creado por: Alberto Bachler Klein: 02-12-15, 16:56:36
  // -----------------------------------------------------------
C_LONGINT:C283($i;$l_encontrados;$l_position)
C_POINTER:C301($y_categoria_actual;$y_listaCategorias;$y_objeto_categorias;$y_objeto_observaciones;$y_Observacion;$y_observacion_actual)

ARRAY LONGINT:C221($al_filas;0)

$y_objeto_categorias:=OBJECT Get pointer:C1124(Object named:K67:5;"objeto_Categorias")
$y_objeto_observaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"objeto_Observaciones")
$y_categoria_actual:=OBJECT Get pointer:C1124(Object named:K67:5;"categoriaActual")
$y_observacion_actual:=OBJECT Get pointer:C1124(Object named:K67:5;"observacionActual")
$y_listaCategorias:=OBJECT Get pointer:C1124(Object named:K67:5;"listaCategorias")
$y_Observacion:=OBJECT Get pointer:C1124(Object named:K67:5;"observacion")

Case of 
	: (Form event:C388=On Clicked:K2:4)
		$y_observacion_actual->:=$y_Observacion->{$y_Observacion->}
	: (Form event:C388=On Before Data Entry:K2:39)
		$y_observacion_actual->:=$y_Observacion->{$y_Observacion->}
	: (Form event:C388=On Data Change:K2:15)
		$y_objeto_categorias->{0}:=$y_listaCategorias->{$y_listaCategorias->}
		$y_objeto_observaciones->{0}:=$y_Observacion->{$y_Observacion->}
		$l_encontrados:=AT_MultiArraySearch (False:C215;->$al_filas;$y_objeto_categorias;$y_objeto_observaciones)
		If ($l_encontrados>0)
			ModernUI_Notificacion (__ ("Edición de observación predefinida");__ ("Ya existe una observación con el mismo texto en la misma categoría");"OK")
			$y_Observacion->{$y_Observacion->}:=$y_Observacion->{0}
			$y_observacion_actual->:=$y_Observacion->{0}
		Else 
			If ($y_observacion_actual->#$y_Observacion->{$y_Observacion->})
				For ($i;1;Size of array:C274($y_objeto_observaciones->))
					If ($y_categoria_actual->=$y_objeto_categorias->{$i})
						$y_objeto_observaciones->{$i}:=Replace string:C233($y_objeto_observaciones->{$i};$y_observacion_actual->;$y_objeto_observaciones->{$y_objeto_observaciones->})
					End if 
				End for 
				$y_observacion_actual->:=$y_Observacion->{$y_Observacion->}
				AT_MultiLevelSort (">>";$y_objeto_categorias;$y_objeto_observaciones)
				CFGstr_GuardaObsSubsectores 
			End if 
		End if 
End case 


