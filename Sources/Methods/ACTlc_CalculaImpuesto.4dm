//%attributes = {}
  //ACTlc_CalculaImpuesto

C_DATE:C307($1;$fechaEm;$2;$fechaVenc)
C_REAL:C285($3;$monto;$0;$factor)
C_LONGINT:C283($dias;$año;$meses)

$monto:=$3
$fechaEm:=$1
$fechaVenc:=$2
$dias:=$fechaVenc-$fechaEm
If ($dias=0)  //20150805 RCH 147932
	$dias:=1
End if 
If ($dias>0)
	$meses:=ACTlc_retornaNumMeses ($fechaEm;$fechaVenc)
	$año:=Year of:C25($fechaEm)
	$tasaMensual:=ACTlc_retornaTasa (1;$año)
	$tasaMaxima:=ACTlc_retornaTasa (2;$año)
	
	  //20141212 RCH Con estas lineas la tasa maxima no se utiliza. Se cambio por el Alicante. Ticket 138140.
	  //If ($meses>12)
	  //$meses:=12
	  //End if 
	$factor:=$tasaMensual*$meses
	
	If ($factor>$tasaMaxima)
		$factor:=$tasaMaxima
	End if 
	$0:=Round:C94(($monto*$factor)/100;<>vlACT_Decimales)
Else 
	$0:=0
End if 