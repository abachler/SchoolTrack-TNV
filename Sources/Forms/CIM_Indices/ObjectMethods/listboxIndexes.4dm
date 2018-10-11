  // CIM_Indices.listboxIndexes()
  // Por: Alberto Bachler K.: 06-04-15, 15:31:21
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$y_listBox:=OBJECT Get pointer:C1124(Object named:K67:5;"listboxIndexes")
$l_filaSeleccionada:=LB_GetSelectedRows ($y_listBox)

OBJECT SET ENABLED:C1123(*;"reconstruirSeleccion";$l_filaSeleccionada>0)
OBJECT SET ENABLED:C1123(*;"reconstruirSeleccion";False:C215)  // inhabilitado temporalmente en v15
