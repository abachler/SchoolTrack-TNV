  // _TestABK.criterio1_campo()
  //
  //
  // creado por: Alberto Bachler Klein: 20-02-16, 07:49:23
  // -----------------------------------------------------------
C_LONGINT:C283($l_elemento;$l_fila)
C_POINTER:C301($y_campo;$y_col1;$y_IdCriterio;$y_index)
C_TEXT:C284($t_name)

$y_index:=OBJECT Get pointer:C1124(Object named:K67:5;"index")
$t_name:=OBJECT Get name:C1087(Object current:K67:2)
$y_campo:=OBJECT Get pointer:C1124(Object current:K67:2)
$y_col1:=OBJECT Get pointer:C1124(Object named:K67:5;"col1")
$l_fila:=Num:C11($t_name)

$y_IdCriterio:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($l_fila)+"_Id")
$l_elemento:=Find in array:C230($y_index->;$y_IdCriterio->)

If ($l_elemento>0)
	$y_col1->{$l_elemento}:=$y_campo->{$y_campo->}
End if 

