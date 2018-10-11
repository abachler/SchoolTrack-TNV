C_POINTER:C301($y_orden;$y_nombre;$y_codigo;$y_id)

$y_orden:=OBJECT Get pointer:C1124(Object named:K67:5;"alACT_CatOrden")
$y_nombre:=OBJECT Get pointer:C1124(Object named:K67:5;"atACT_CatlNombre")
$y_codigo:=OBJECT Get pointer:C1124(Object named:K67:5;"atACT_CatCodigo")
$y_id:=OBJECT Get pointer:C1124(Object named:K67:5;"alACT_CatID")

READ ONLY:C145([xxACT_ItemsCategorias:98])
ALL RECORDS:C47([xxACT_ItemsCategorias:98])
ORDER BY:C49([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]Posicion:3;>)

SELECTION TO ARRAY:C260([xxACT_ItemsCategorias:98]Posicion:3;$y_orden->;*)
SELECTION TO ARRAY:C260([xxACT_ItemsCategorias:98]Nombre:1;$y_nombre->;*)
SELECTION TO ARRAY:C260([xxACT_ItemsCategorias:98]Codigo:5;$y_codigo->;*)
SELECTION TO ARRAY:C260([xxACT_ItemsCategorias:98]ID:2;$y_id->;*)
SELECTION TO ARRAY:C260

OBJECT SET ENABLED:C1123(*;"alACT_CatOrden";False:C215)

FORM GOTO PAGE:C247(2)
