C_REAL:C285($aPagarAfecto;$aPagar)
C_BOOLEAN:C305($vb_limpiar)
C_LONGINT:C283($bestWidth;$bestHeight;$diff)

If (Form event:C388=On Data Change:K2:15)
	If ((Self:C308->>=0) & (Self:C308-><vrACT_SeleccionadoAfecto))
		vrACT_MontoDesctoAfecto:=Round:C94(vrACT_MontoDesctoAfecto;<>vlACT_Decimales)
		$aPagarAfecto:=vrACT_SeleccionadoAfecto-Self:C308->
		$aPagar:=$aPagarAfecto+vrACT_SeleccionadoExento-vrACT_SaldoDisp
		Case of 
			: ($aPagar<0)
				BEEP:C151
				Self:C308->:=0
				vrACT_MontoDescto:=Self:C308->+vrACT_MontoDesctoExento
				vrACT_MontoaPagarAfecto:=vrACT_SeleccionadoAfecto-Self:C308->
				vrACT_MontoaPagar:=vrACT_MontoaPagarAfecto+vrACT_MontoaPagarExento-vrACT_SaldoDisp
				vrACT_MontoPago:=vrACT_MontoaPagar
				OBJECT SET TITLE:C194(bIngresarPago;__ ("Continuar"))
			: ($aPagar=0)
				vrACT_MontoDescto:=Self:C308->+vrACT_MontoDesctoExento
				vrACT_MontoaPagarAfecto:=vrACT_SeleccionadoAfecto-Self:C308->
				vrACT_MontoaPagar:=vrACT_MontoaPagarAfecto+vrACT_MontoaPagarExento-vrACT_SaldoDisp
				vrACT_MontoPago:=vrACT_MontoaPagar
				OBJECT SET TITLE:C194(bIngresarPago;__ ("Pagar usando saldo"))
			Else 
				vb_CondonaDescuento:=True:C214
				$continuar:=ACTcfg_OpcionesCondonacion ("SolicitaMotivo")
				If ($continuar)
					vrACT_MontoDescto:=Self:C308->+vrACT_MontoDesctoExento
					vrACT_MontoaPagarAfecto:=vrACT_SeleccionadoAfecto-Self:C308->
					vrACT_MontoaPagar:=vrACT_MontoaPagarAfecto+vrACT_MontoaPagarExento-vrACT_SaldoDisp
					vrACT_MontoPago:=vrACT_MontoaPagar
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
		vrACT_MontoDescto:=Self:C308->+vrACT_MontoDesctoExento
		vrACT_MontoaPagarAfecto:=vrACT_SeleccionadoAfecto-Self:C308->
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

  //C_REAL($aPagarAfecto;$aPagar)
  //C_LONGINT($bestWidth;$bestHeight;$diff)
  //
  //If (Form event=On Data Change )
  //If ((Self->>=0) & (Self-><vrACT_MontoAdeudadoAfecto))
  //$aPagarAfecto:=vrACT_MontoAdeudadoAfecto-Self->
  //$aPagar:=$aPagarAfecto+vrACT_MontoaPagarExento-vrACT_SaldoDisp
  //Case of 
  //: ($aPagar<0)
  //BEEP
  //Self->:=0
  //vrACT_MontoDescto:=Self->+vrACT_MontoDesctoExento
  //vrACT_MontoaPagarAfecto:=vrACT_MontoAdeudadoAfecto-Self->
  //vrACT_MontoaPagar:=vrACT_MontoaPagarAfecto+vrACT_MontoaPagarExento-vrACT_SaldoDisp
  //vrACT_MontoPago:=vrACT_MontoaPagar
  //BUTTON TEXT(bIngresarPago;"Continuar")
  //: ($aPagar=0)
  //vrACT_MontoDescto:=Self->+vrACT_MontoDesctoExento
  //vrACT_MontoaPagarAfecto:=vrACT_MontoAdeudadoAfecto-Self->
  //vrACT_MontoaPagar:=vrACT_MontoaPagarAfecto+vrACT_MontoaPagarExento-vrACT_SaldoDisp
  //vrACT_MontoPago:=vrACT_MontoaPagar
  //BUTTON TEXT(bIngresarPago;"Pagar usando saldo")
  //Else 
  //vrACT_MontoDescto:=Self->+vrACT_MontoDesctoExento
  //vrACT_MontoaPagarAfecto:=vrACT_MontoAdeudadoAfecto-Self->
  //vrACT_MontoaPagar:=vrACT_MontoaPagarAfecto+vrACT_MontoaPagarExento-vrACT_SaldoDisp
  //vrACT_MontoPago:=vrACT_MontoaPagar
  //BUTTON TEXT(bIngresarPago;"Continuar")
  //End case 
  //Else 
  //BEEP
  //Self->:=0
  //vrACT_MontoDescto:=Self->+vrACT_MontoDesctoExento
  //vrACT_MontoaPagarAfecto:=vrACT_MontoAdeudadoAfecto-Self->
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