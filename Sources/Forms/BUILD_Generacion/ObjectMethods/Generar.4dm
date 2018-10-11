
FORM GET OBJECTS:C898($at_objetos;$ay_variables;$al_paginas;Form current page:K67:6)
For ($i;1;Size of array:C274($at_objetos))
	OBJECT SET ENABLED:C1123(*;$at_objetos{$i};False:C215)
End for 
OBJECT SET ENABLED:C1123(*;"Generar1";True:C214)
OBJECT SET ENABLED:C1123(*;"showLog";True:C214)
OBJECT SET ENABLED:C1123(*;"executeTasks";True:C214)
OBJECT SET ENABLED:C1123(*;"compilador";True:C214)

POST KEY:C465(Character code:C91("0");Command key mask:K16:1+Option key mask:K16:7)
REDRAW WINDOW:C456

