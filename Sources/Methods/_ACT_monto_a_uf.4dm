//%attributes = {}
  //_ACT_monto_a_uf

C_REAL:C285($vr_monto;$0)
C_DATE:C307($vd_fecha)
C_TEXT:C284($vt_moneda)
$vr_monto:=$1
$vt_moneda:=$2
If (Count parameters:C259>=3)
	$vd_fecha:=$3
End if 
If ($vd_fecha=!00-00-00!)
	$vd_fecha:=Current date:C33(*)
End if 
$0:=ACTut_retornaMontoEnMoneda ($vr_monto;$vt_moneda;$vd_fecha;"UF")