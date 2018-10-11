  // [xxSTR_Materias].Input.Botón1()
  // 
  //
  // creado por: Alberto Bachler Klein: 03-12-15, 10:26:55
  // -----------------------------------------------------------


$y_Observacion:=OBJECT Get pointer:C1124(Object named:K67:5;"observacion")
$y_ListaCategorias:=OBJECT Get pointer:C1124(Object named:K67:5;"listaCategorias")
$y_objeto_categorias:=OBJECT Get pointer:C1124(Object named:K67:5;"objeto_Categorias")
$y_objeto_observaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"objeto_Observaciones")

$t_categoria:="Categoría "+String:C10(Size of array:C274($y_ListaCategorias->)+1)
APPEND TO ARRAY:C911($y_ListaCategorias->;$t_categoria)
APPEND TO ARRAY:C911($y_objeto_categorias->;$t_categoria)
APPEND TO ARRAY:C911($y_objeto_observaciones->;"")

AT_MultiLevelSort (">>";$y_objeto_categorias;$y_objeto_observaciones)


CFGstr_GuardaObsSubsectores 