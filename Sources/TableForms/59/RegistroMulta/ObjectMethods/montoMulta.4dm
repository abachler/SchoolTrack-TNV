  // [BBL_Transacciones].RegistroMulta.montoMulta()
  // Por: Alberto Bachler: 23/10/13, 16:47:52
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$y_multa:=OBJECT Get pointer:C1124(Object current:K67:2)
If (($y_multa->#0) | (Get edited text:C655#""))
	OBJECT SET RGB COLORS:C628(*;"botonAceptar";<>vl_ColorBarraPie_BotonPrincipal;<>vl_ColorFondoBoton)
Else 
	OBJECT SET RGB COLORS:C628(*;"botonAceptar";<>vl_ColorTextoBoton_Normal;<>vl_ColorBarra_Fondo)
End if 

$t_textoEditado:=Get edited text:C655
If ($t_textoEditado#"-")
	$y_multa->:=Num:C11($t_textoEditado)
	
	
	Case of 
		: ($y_multa-><=0)
			$y_pago:=OBJECT Get pointer:C1124(Object named:K67:5;"montoPagado")
			$y_pago->:=0
			OBJECT SET VISIBLE:C603(*;"montoPagado@";False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*;"montoPagado@";True:C214)
	End case 
Else 
	OBJECT SET VISIBLE:C603(*;"montoPagado@";False:C215)
End if 





