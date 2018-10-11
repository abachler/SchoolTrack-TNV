  // GeneracionAplicacion.showLog()
  //
  //
  // creado por: Alberto Bachler Klein: 18-08-16, 15:46:03
  // -----------------------------------------------------------
FORM GET OBJECTS:C898($at_objetos;$ay_variables;$al_paginas;Form current page:K67:6)
For ($i;1;Size of array:C274($at_objetos))
	OBJECT SET ENABLED:C1123(*;$at_objetos{$i};False:C215)
End for 
REDRAW WINDOW:C456