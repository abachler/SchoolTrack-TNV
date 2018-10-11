//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 28-07-17, 09:23:43
  // ----------------------------------------------------
  // Método: QRY_OcultaObjetosBuscador
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_POINTER:C301($y_index)

$y_indice:=$1

For ($i;1;Size of array:C274($y_indice->))
	  //acá se deben eliminar los objetos de busquedas no utilizados
	OBJECT SET VISIBLE:C603(*;"criterio"+String:C10($y_indice->{$i})+"@";False:C215)
	OBJECT MOVE:C664(*;"criterio"+String:C10($y_indice->{$i})+"@";0;-30)
End for 

$y_index:=OBJECT Get pointer:C1124(Object named:K67:5;"index")
$l_filas:=Size of array:C274($y_index->)
$l_altoFila:=LISTBOX Get rows height:C836(*;"lb_criterios")
$l_altoListbox:=$l_altoFila*$l_filas

OBJECT GET COORDINATES:C663(*;"lb_criterios";$l_izquierdaLB;$l_arribaLB;$l_derechaLB;$l_abajoLB)
OBJECT SET COORDINATES:C1248(*;"lb_criterios";$l_izquierdaLB;$l_arribaLB;$l_derechaLB;$l_arribaLB+$l_altoListbox)
GET WINDOW RECT:C443($l_izquierdaW;$l_arribaW;$l_derechaW;$l_abajoW)
SET WINDOW RECT:C444($l_izquierdaW;$l_arribaW;$l_derechaW;$l_arribaW+$l_arribaLB+$l_altoListbox+40)
