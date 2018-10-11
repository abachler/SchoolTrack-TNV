//%attributes = {}
  // ModernUI_EventosBotonBarra()
  // Por: Alberto Bachler: 08/10/13, 10:51:18
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_POINTER:C301($y_objeto)
C_TEXT:C284($t_nombreObjeto)

$t_nombreObjeto:=OBJECT Get name:C1087(Object current:K67:2)
$y_objeto:=OBJECT Get pointer:C1124(Object current:K67:2)
Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT SET RGB COLORS:C628(*;$t_nombreObjeto;<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
		
	: (Form event:C388=On Clicked:K2:4)
		OBJECT SET RGB COLORS:C628(*;"botonBarra@";<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
		OBJECT SET RGB COLORS:C628(*;$t_nombreObjeto;<>vl_ColorTextoBoton_Azul;<>vl_ColorFondoBoton)
		$l_pagina:=Num:C11($t_nombreObjeto)
		FORM GOTO PAGE:C247($l_pagina)
		
	: ((Form event:C388=On Mouse Enter:K2:33) & ($y_objeto->=0))
		OBJECT SET RGB COLORS:C628(*;$t_nombreObjeto;<>vl_ColorTextoBoton_MouseOn;<>vl_ColorBarra_Fondo)
		
	: ((Form event:C388=On Mouse Leave:K2:34) & ($y_objeto->=0))
		OBJECT SET RGB COLORS:C628(*;$t_nombreObjeto;<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
		
End case 

