C_REAL:C285($aPagarExento;$aPagar)
C_BOOLEAN:C305($vb_limpiar)
C_LONGINT:C283($bestWidth;$bestHeight;$diff)

If (Form event:C388=On Data Change:K2:15)
	If ((Self:C308->>=0) & (Self:C308-><vrACT_SeleccionadoExento))
		vrACT_MontoDesctoExento:=Round:C94(vrACT_MontoDesctoExento;<>vlACT_Decimales)
		$aPagarExento:=vrACT_SeleccionadoExento-Self:C308->
		$aPagar:=vrACT_SeleccionadoAfecto+$aPagarExento-vrACT_SaldoDisp
		Case of 
			: ($aPagar<0)
				BEEP:C151
				Self:C308->:=0
				vrACT_MontoDescto:=Self:C308->+vrACT_MontoDesctoAfecto
				vrACT_MontoaPagarExento:=vrACT_SeleccionadoExento-Self:C308->
				vrACT_MontoaPagar:=vrACT_MontoaPagarAfecto+vrACT_MontoaPagarExento-vrACT_SaldoDisp
				vrACT_MontoPago:=vrACT_MontoaPagar
				vrACT_MontoAPagarApdo:=vrACT_MontoaPagar
				OBJECT SET TITLE:C194(bIngresarPago;__ ("Continuar"))
			: ($aPagar=0)
				vrACT_MontoDescto:=Self:C308->+vrACT_MontoDesctoAfecto
				vrACT_MontoaPagarExento:=vrACT_SeleccionadoExento-Self:C308->
				vrACT_MontoaPagar:=vrACT_MontoaPagarAfecto+vrACT_MontoaPagarExento-vrACT_SaldoDisp
				OBJECT SET TITLE:C194(bIngresarPago;__ ("Pagar usando saldo"))
				vrACT_MontoPago:=vrACT_MontoaPagar
				vrACT_MontoAPagarApdo:=vrACT_MontoaPagar
			Else 
				vb_CondonaDescuento:=True:C214
				$continuar:=ACTcfg_OpcionesCondonacion ("SolicitaMotivo")
				If ($continuar)
					vrACT_MontoDescto:=Self:C308->+vrACT_MontoDesctoAfecto
					vrACT_MontoaPagarExento:=vrACT_SeleccionadoExento-Self:C308->
					vrACT_MontoaPagar:=vrACT_MontoaPagarAfecto+vrACT_MontoaPagarExento-vrACT_SaldoDisp
					vrACT_MontoPago:=vrACT_MontoaPagar
					vrACT_MontoAPagarApdo:=vrACT_MontoaPagar
					OBJECT SET TITLE:C194(bIngresarPago;"Continuar")
				Else 
					$vb_limpiar:=True:C214
				End if 
		End case 
	Else 
		$vb_limpiar:=True:C214
	End if 
	If ($vb_limpiar)
		BEEP:C151
		Self:C308->:=0
		vrACT_MontoDescto:=Self:C308->+vrACT_MontoDesctoAfecto
		vrACT_MontoaPagarExento:=vrACT_SeleccionadoExento-Self:C308->
		vrACT_MontoaPagar:=vrACT_MontoaPagarAfecto+vrACT_MontoaPagarExento-vrACT_SaldoDisp
		vrACT_MontoPago:=vrACT_MontoaPagar
		OBJECT SET TITLE:C194(bIngresarPago;"Continuar")
	End if 
End if 
OBJECT GET BEST SIZE:C717(bIngresarPago;$bestWidth;$bestHeight)
OBJECT GET COORDINATES:C663(bIngresarPago;$left;$top;$right;$bottom)
$actualWidth:=$right-$left
$diff:=$bestWidth-$actualWidth
OBJECT MOVE:C664(bIngresarPago;($diff*-1)-30;0;$diff+30;0)

  //C_REAL($aPagarExento;$aPagar)
  //C_LONGINT($bestWidth;$bestHeight;$diff)
  //
  //If (Form event=On Data Change )
  //If ((Self->>=0) & (Self-><vrACT_MontoAdeudadoExento))
  //$aPagarExento:=vrACT_MontoAdeudadoExento-Self->
  //$aPagar:=vrACT_MontoaPagarAfecto+$aPagarExento-vrACT_SaldoDisp
  //Case of 
  //: ($aPagar<0)
  //BEEP
  //Self->:=0
  //vrACT_MontoDescto:=Self->+vrACT_MontoDesctoAfecto
  //vrACT_MontoaPagarExento:=vrACT_MontoAdeudadoExento-Self->
  //vrACT_MontoaPagar:=vrACT_MontoaPagarAfecto+vrACT_MontoaPagarExento-vrACT_SaldoDisp
  //vrACT_MontoPago:=vrACT_MontoaPagar
  //BUTTON TEXT(bIngresarPago;"Continuar")
  //: ($aPagar=0)
  //vrACT_MontoDescto:=Self->+vrACT_MontoDesctoAfecto
  //vrACT_MontoaPagarExento:=vrACT_MontoAdeudadoExento-Self->
  //vrACT_MontoaPagar:=vrACT_MontoaPagarAfecto+vrACT_MontoaPagarExento-vrACT_SaldoDisp
  //BUTTON TEXT(bIngresarPago;"Pagar usando saldo")
  //vrACT_MontoPago:=vrACT_MontoaPagar
  //Else 
  //vrACT_MontoDescto:=Self->+vrACT_MontoDesctoAfecto
  //vrACT_MontoaPagarExento:=vrACT_MontoAdeudadoExento-Self->
  //vrACT_MontoaPagar:=vrACT_MontoaPagarAfecto+vrACT_MontoaPagarExento-vrACT_SaldoDisp
  //vrACT_MontoPago:=vrACT_MontoaPagar
  //BUTTON TEXT(bIngresarPago;"Continuar")
  //End case 
  //Else 
  //BEEP
  //Self->:=0
  //vrACT_MontoDescto:=Self->+vrACT_MontoDesctoAfecto
  //vrACT_MontoaPagarExento:=vrACT_MontoAdeudadoExento-Self->
  //vrACT_MontoaPagar:=vrACT_MontoaPagarAfecto+vrACT_MontoaPagarExento-vrACT_SaldoDisp
  //vrACT_MontoPago:=vrACT_MontoaPagar
  //BUTTON TEXT(bIngresarPago;"Continuar")
  //End if 
  //End if 
  //BEST OBJECT SIZE(bIngresarPago;$bestWidth;$bestHeight)
  //GET OBJECT RECT(bIngresarPago;$left;$top;$right;$bottom)
  //$actualWidth:=$right-$left
  //$diff:=$bestWidth-$actualWidth
  //MOVE OBJECT(bIngresarPago;($diff*-1)-30;0;$diff+30;0)