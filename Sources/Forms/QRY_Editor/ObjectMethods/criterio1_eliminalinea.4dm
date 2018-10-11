  // _TestABK.nuevaLinea1()
  //
  //
  // creado por: Alberto Bachler Klein: 20-02-16, 07:35:53
  // -----------------------------------------------------------
C_LONGINT:C283($i;$l_abajoLB;$l_abajoW;$l_altoFila;$l_altoListbox;$l_arribaLB;$l_arribaW;$l_derechaLB;$l_derechaW;$l_elemento)
C_LONGINT:C283($l_filas;$l_indexActual;$l_izquierdaLB;$l_izquierdaW)
C_POINTER:C301($y_IdCriterio;$y_index;$y_objectCount)
C_TEXT:C284($t_nombreObjetos)

$y_objectCount:=OBJECT Get pointer:C1124(Object named:K67:5;"objectCount")
$y_index:=OBJECT Get pointer:C1124(Object named:K67:5;"index")

$l_indexActual:=Num:C11(OBJECT Get name:C1087(Object current:K67:2))
$t_nombreObjetos:="criterio"+String:C10($l_indexActual)+"@"
OBJECT SET VISIBLE:C603(*;$t_nombreObjetos;False:C215)

$y_IdCriterio:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($l_indexActual)+"_Id")

$l_elemento:=Find in array:C230($y_index->;$l_indexActual)
$l_elemento:=$l_elemento+1
For ($i;$l_elemento;Size of array:C274($y_index->))
	$t_nombreObjetos:="criterio"+String:C10($y_index->{$i})+"@"
	OBJECT MOVE:C664(*;$t_nombreObjetos;0;-30)
	  //OBJECT SET VISIBLE(*;$t_nombreObjetos;True)
End for 


$l_elemento:=Find in array:C230($y_index->;$l_indexActual)
AT_Delete ($l_elemento;1;->atQRY_NombreVirtualCampo;->ayQRY_Campos;->atQRY_Operador_Literal;->atQRY_ValorLiteral;->atQRY_Conector_Literal;->atQRY_NombreInternoCampo;->alQRY_Operador_ID;->atQRY_Conector_Simbolo;->alQRY_numeroTabla;->alQRY_numeroCampo;$y_index)
  //$l_filas:=LISTBOX Get number of rows(*;"lb_criterios")
$l_filas:=Size of array:C274($y_index->)
$l_altoFila:=LISTBOX Get rows height:C836(*;"lb_criterios")
$l_altoListbox:=$l_altoFila*$l_filas

OBJECT GET COORDINATES:C663(*;"lb_criterios";$l_izquierdaLB;$l_arribaLB;$l_derechaLB;$l_abajoLB)
OBJECT SET COORDINATES:C1248(*;"lb_criterios";$l_izquierdaLB;$l_arribaLB;$l_derechaLB;$l_arribaLB+$l_altoListbox)
GET WINDOW RECT:C443($l_izquierdaW;$l_arribaW;$l_derechaW;$l_abajoW)
  //OBJECT GET COORDINATES(*;"lb_criterios";$l_izquierdaLB;$l_arribaLB;$l_derechaLB;$l_abajoLB)
SET WINDOW RECT:C444($l_izquierdaW;$l_arribaW;$l_derechaW;$l_arribaW+$l_arribaLB+$l_altoListbox+40)

$y_objectCount->:=$y_objectCount->-1


  //If ($y_objectCount->=1)
  //$l_index:=$y_index->{1}
  //OBJECT SET ENABLED(*;"objectCount";False)
  //End if

