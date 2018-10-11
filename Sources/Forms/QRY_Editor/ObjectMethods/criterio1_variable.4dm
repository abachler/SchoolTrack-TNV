  // _TestABK.criterio1_variable()
  //
  //
  // creado por: Alberto Bachler Klein: 20-02-16, 07:52:42
  // -----------------------------------------------------------
C_LONGINT:C283($l_elemento;$l_fila)
C_POINTER:C301($y_index)

$y_index:=OBJECT Get pointer:C1124(Object named:K67:5;"index")
$l_fila:=Num:C11(OBJECT Get name:C1087(Object current:K67:2))

  //$y_IdCriterio:=OBJECT Get pointer(Object named;"criterio"+String($l_fila)+"_Id")
$l_elemento:=Find in array:C230($y_index->;$l_fila)

If ($l_elemento>0)
	atQRY_ValorLiteral{$l_elemento}:=(OBJECT Get pointer:C1124(Object current:K67:2))->
End if 
