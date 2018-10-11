//%attributes = {}
  //ACTut_retornaValorEnMoneda

C_REAL:C285($monto;$2;$0;$1;$accion)
C_TEXT:C284($moneda;$3)
C_REAL:C285($valorMoneda)
C_REAL:C285($valorUF;$valorDivisa)
C_DATE:C307($date)
$accion:=$1
$monto:=$2
$moneda:=$3
If (Count parameters:C259=4)
	C_DATE:C307($4)
	$date:=$4
Else 
	$date:=Current date:C33(*)
End if 
Case of 
	: ($accion=1)  //monto pesos
		Case of 
			: ($moneda="UF")
				$valorUF:=ACTut_fValorUF ($date)
				$0:=Round:C94($monto*$valorUF;<>vlACT_Decimales)
			: ($moneda=<>vsACT_MonedaColegio)
				$0:=$monto
			Else 
				$valorDivisa:=ACTut_fValorDivisa ($moneda)
				$0:=Round:C94($monto*$valorDivisa;<>vlACT_Decimales)
		End case 
		  //$valorMoneda:=ACTut_fValorDivisa ($moneda)
		  //$0:=Round($monto*$valorMoneda;<>vlACT_Decimales)
		
	: ($accion=2)  //monto moneda
		Case of 
			: ($moneda="UF")
				$valorUF:=ACTut_fValorUF ($date)
				$0:=Round:C94($monto/$valorUF;<>vlACT_Decimales)
			: ($moneda=<>vsACT_MonedaColegio)
				$0:=$monto
			Else 
				$valorDivisa:=ACTut_fValorDivisa ($moneda)
				$0:=Round:C94($monto/$valorDivisa;<>vlACT_Decimales)
		End case 
		  //$valorMoneda:=ACTut_fValorDivisa ($moneda)
		  //$0:=Round($monto/$valorMoneda;<>vlACT_Decimales)
End case 