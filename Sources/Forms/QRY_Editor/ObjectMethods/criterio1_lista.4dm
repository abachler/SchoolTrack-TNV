  // _TestABK.criterio1_lista()
  // 
  //
  // creado por: Alberto Bachler Klein: 22-02-16, 10:50:35
  // -----------------------------------------------------------

$l_fila:=Num:C11(OBJECT Get name:C1087(Object current:K67:2))
$y_menuLista:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($l_fila)+"_lista")
$y_index:=OBJECT Get pointer:C1124(Object named:K67:5;"index")
$l_posicion:=Find in array:C230($y_index->;$l_fila)

If ($y_menuLista->>0)
	If (Type:C295(ayQRY_Campos{$l_posicion}->)=Is boolean:K8:9)
		atQRY_ValorLiteral{$l_posicion}:=Choose:C955($y_menuLista->=1;"True";"False")
		  //atQRY_ValorLiteral{$l_fila}:=Choose($y_menuLista->=1;"True";"False")
	Else 
		  //atQRY_ValorLiteral{$l_fila}:=$y_menuLista->{$y_menuLista->}
		atQRY_ValorLiteral{$l_posicion}:=$y_menuLista->{$y_menuLista->}
	End if 
End if 


