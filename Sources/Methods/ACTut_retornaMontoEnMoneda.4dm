//%attributes = {}
  //ACTut_retornaMontoEnMoneda

C_REAL:C285($1;$vr_monto;$vr_retorno;$vr_valorDivisaOrg;$vr_valorDivisaConv)
C_TEXT:C284($2;$vt_monedaOrg;$vt_monedaConversion)
C_DATE:C307($vd_fecha;$vd_fechaConv)
C_LONGINT:C283($vl_noDecimales)
C_BOOLEAN:C305($vb_decimalesPago;$6)

$vr_monto:=$1
$vt_monedaOrg:=$2
$vd_fecha:=Current date:C33(*)
$vt_monedaConversion:=<>vsACT_MonedaColegio
$vd_fechaConv:=Current date:C33(*)
Case of 
	: (Count parameters:C259=3)
		$vd_fecha:=$3
		$vd_fechaConv:=$vd_fecha
	: (Count parameters:C259=4)
		$vd_fecha:=$3
		$vt_monedaConversion:=$4
		$vd_fechaConv:=$vd_fecha
	: (Count parameters:C259=5)
		$vd_fecha:=$3
		$vt_monedaConversion:=$4
		$vd_fechaConv:=$5
	: (Count parameters:C259=6)
		$vd_fecha:=$3
		$vt_monedaConversion:=$4
		$vd_fechaConv:=$5
		$vb_decimalesPago:=$6
End case 
If ($vt_monedaConversion="")
	$vt_monedaConversion:=ST_GetWord (ACT_DivisaPais ;1;";")
End if 
If ($vb_decimalesPago)
	$vt_key:=<>gCountryCode+"."+$vt_monedaConversion
	$vl_noDecimales:=KRL_GetNumericFieldData (->[xxACT_Monedas:146]Key:10;->$vt_key;->[xxACT_Monedas:146]Numero_Decimales:8)
Else 
	$vl_noDecimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaConversion))
End if 

Case of 
	: ($vt_monedaOrg=$vt_monedaConversion)
		$vr_retorno:=$vr_monto
	Else 
		$vr_valorDivisaOrg:=ACTut_fValorDivisa ($vt_monedaOrg;$vd_fecha)
		$vr_valorDivisaConv:=ACTut_fValorDivisa ($vt_monedaConversion;$vd_fechaConv)
		If ($vr_valorDivisaConv>0)
			$vr_retorno:=$vr_monto*$vr_valorDivisaOrg/$vr_valorDivisaConv
		Else 
			$vr_retorno:=0
		End if 
End case 
$0:=Round:C94($vr_retorno;$vl_noDecimales)