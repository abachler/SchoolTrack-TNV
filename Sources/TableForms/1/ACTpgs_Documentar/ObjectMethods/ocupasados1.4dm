C_LONGINT:C283($bestWidth;$bestHeight;$left;$top;$right;$bottom;$actualWidth;$diff)

If (Self:C308->=1)
	oldSaldoDisp:=vrACT_SaldoDisp
	vrACT_SaldoDisp:=vrACT_OtrosSaldosDisp
Else 
	vrACT_SaldoDisp:=oldSaldoDisp
	oldSaldoDisp:=vrACT_SaldoDisp
End if 
vrACT_MontoDescto:=vrACT_MontoDesctoAfecto+vrACT_MontoDesctoExento
vrACT_MontoaPagarAfecto:=vrACT_MontoAdeudadoAfecto-vrACT_MontoDesctoAfecto
vrACT_MontoaPagarExento:=vrACT_MontoAdeudadoExento-vrACT_MontoDesctoExento
vrACT_MontoaPagar:=vrACT_MontoaPagarAfecto+vrACT_MontoaPagarExento-vrACT_SaldoDisp
vrACT_MontoPago:=vrACT_MontoaPagar
If (vrACT_MontoaPagar<=0)
	vrACT_MontoaPagarApdo:=0
	OBJECT SET TITLE:C194(bIngresarPago;__ ("Pagar usando saldo"))
Else 
	vrACT_MontoaPagarApdo:=vrACT_MontoaPagar
	OBJECT SET TITLE:C194(bIngresarPago;__ ("Ingresar"))
End if 
OBJECT GET BEST SIZE:C717(bIngresarPago;$bestWidth;$bestHeight)
OBJECT GET COORDINATES:C663(bIngresarPago;$left;$top;$right;$bottom)
$actualWidth:=$right-$left
$diff:=$bestWidth-$actualWidth
OBJECT MOVE:C664(bIngresarPago;($diff*-1)-30;0;$diff+30;0)