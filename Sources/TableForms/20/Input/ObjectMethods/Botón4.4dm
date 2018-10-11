  // [xxSTR_Materias].Input.Botón1()
  //
  //
  // creado por: Alberto Bachler Klein: 03-12-15, 10:26:55
  // -----------------------------------------------------------
C_LONGINT:C283($l_encontrados;$l_posicion)
C_POINTER:C301($y_ListaCategorias;$y_objeto_categorias;$y_objeto_observaciones;$y_Observacion)
C_TEXT:C284($t_observacion)

ARRAY LONGINT:C221($al_filas;0)

$y_Observacion:=OBJECT Get pointer:C1124(Object named:K67:5;"observacion")
$y_ListaCategorias:=OBJECT Get pointer:C1124(Object named:K67:5;"listaCategorias")
$y_objeto_categorias:=OBJECT Get pointer:C1124(Object named:K67:5;"objeto_Categorias")
$y_objeto_observaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"objeto_Observaciones")


If ($y_ListaCategorias->>0)
	$t_observacion:="Observación "+String:C10(Size of array:C274($y_Observacion->)+1)
	APPEND TO ARRAY:C911($y_Observacion->;$t_observacion)
	
	$y_objeto_categorias->{0}:=Choose:C955($y_ListaCategorias->{$y_ListaCategorias->}=__ ("[sin categoria]");"none";$y_ListaCategorias->{$y_ListaCategorias->})
	$y_objeto_observaciones->{0}:=""
	
	$l_encontrados:=AT_MultiArraySearch (False:C215;->$al_filas;$y_objeto_categorias;$y_objeto_observaciones)
	If ($l_encontrados>=1)
		$y_objeto_observaciones->{$al_filas{1}}:=$t_observacion
	Else 
		APPEND TO ARRAY:C911($y_objeto_categorias->;$y_ListaCategorias->{$y_ListaCategorias->})
		APPEND TO ARRAY:C911($y_objeto_observaciones->;$t_observacion)
	End if 
	
	AT_MultiLevelSort (">>";$y_objeto_categorias;$y_objeto_observaciones)
	CFGstr_GuardaObsSubsectores 
End if 