  // 4D_ObjetosInutilizados.lb_macros()
  // Por: Alberto Bachler K.: 29-07-15, 21:47:50
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
$y_Metodos:=OBJECT Get pointer:C1124(Object current:K67:2)
Case of 
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Double Clicked:K2:5))
		METHOD OPEN PATH:C1213($y_Metodos->{$y_Metodos->};*)
End case 
