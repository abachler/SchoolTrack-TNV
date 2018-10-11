//%attributes = {}
  //ST_Num2Text_Mantisa

C_TEXT:C284($1;$vt_Number2)
$vt_Number2:=$1

C_TEXT:C284($0;$vt_Result)

C_LONGINT:C283($vl_NumDigitos)

$vl_NumDigitos:=Length:C16($vt_Number2)
Case of 
	: ($vl_NumDigitos=1)
		$vt_Result:="Unidades"
	: ($vl_NumDigitos=2)
		$vt_Result:="Decenas"
	: ($vl_NumDigitos=3)
		$vt_Result:="Centenas"
	: ($vl_NumDigitos=4)
		$vt_Result:="Miles"
	: ($vl_NumDigitos=5)
		$vt_Result:="Decenas de Mil"
	: ($vl_NumDigitos=6)
		$vt_Result:="Centenas de Mil"
	: ($vl_NumDigitos=7)
		$vt_Result:="Millones"
	: ($vl_NumDigitos=8)
		$vt_Result:="Decenas de Millon"
	: ($vl_NumDigitos=9)
		$vt_Result:="Centenas de Millon"
	: ($vl_NumDigitos=10)
		$vt_Result:="Billones"
End case 

$0:=$vt_Result