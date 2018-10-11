  // 4D_ObjetosInutilizados.uso_Referencias()
  //
  //
  // creado por: Alberto Bachler Klein: 09-01-17, 09:32:56
  // -----------------------------------------------------------
C_POINTER:C301($y_ruta)


If (Form event:C388=On Double Clicked:K2:5)
	$y_ruta:=OBJECT Get pointer:C1124(Object named:K67:5;"usoRuta")
	METHOD OPEN PATH:C1213($y_ruta->{$y_ruta->})
End if 