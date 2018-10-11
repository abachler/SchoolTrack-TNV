C_POINTER:C301($y_punteroCol2)

$y_punteroCol2:=OBJECT Get pointer:C1124(Object named:K67:5;"lb_IngresaValorCol2")
If (($y_punteroCol2->{Self:C308->}<0) | ($y_punteroCol2->{Self:C308->}>100))
	$y_punteroCol2->{Self:C308->}:=$y_punteroCol2->{0}
End if 
