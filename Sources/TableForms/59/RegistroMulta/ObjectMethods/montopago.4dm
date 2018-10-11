  // [BBL_Transacciones].RegistroMulta.montopagado1()
  // Por: Alberto Bachler: 23/10/13, 16:50:47
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$y_Pago:=OBJECT Get pointer:C1124(Object current:K67:2)
If (($y_Pago->#0) | (Get edited text:C655#""))
	OBJECT SET RGB COLORS:C628(*;"botonAceptar";<>vl_ColorBarraPie_BotonPrincipal;<>vl_ColorFondoBoton)
Else 
	OBJECT SET RGB COLORS:C628(*;"botonAceptar";<>vl_ColorTextoBoton_Normal;<>vl_ColorBarra_Fondo)
End if 




