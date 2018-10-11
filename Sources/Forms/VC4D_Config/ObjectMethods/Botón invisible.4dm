  // VC4D_Config.Botón invisible()
  //
  //
  // creado por: Alberto Bachler Klein: 05-02-16, 18:55:52
  // -----------------------------------------------------------
C_LONGINT:C283($l_abajo;$l_arriba;$l_boton;$l_derecha;$l_izquierda;$l_mouseX;$l_mouseY)

GET MOUSE:C468($l_mouseX;$l_mouseY;$l_boton)

OBJECT GET COORDINATES:C663(*;"in_rectangle";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
If (($l_mouseX>$l_derecha) | ($l_mouseX<$l_izquierda) | ($l_mouseY>$l_abajo) | ($l_mouseY<$l_arriba))
	FORM GOTO PAGE:C247(1)
End if 


