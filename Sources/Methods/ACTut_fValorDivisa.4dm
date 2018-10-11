//%attributes = {}
  //ACTut_fValorDivisa

C_REAL:C285($valorMoneda;$0)
C_TEXT:C284($moneda;$1)
C_DATE:C307($vd_date)
Case of 
	: (Count parameters:C259=2)
		$moneda:=$1
		$vd_date:=$2
	Else 
		$moneda:=$1
		$vd_date:=Current date:C33(*)
End case 
$0:=ACTmon_ObtieneValor ($moneda;$vd_date)
