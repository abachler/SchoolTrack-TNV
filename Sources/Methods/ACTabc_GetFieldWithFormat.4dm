//%attributes = {}
  //ACTabc_GetFieldWithFormat

C_TEXT:C284($vt_value;$vt_tipo;$vt_relleno;$vt_alignValue;$vt_return;$0;$1;$2;$4;$5)
C_LONGINT:C283($vl_len;$3)

$vt_value:=$1
$vt_tipo:=$2
$vl_len:=$3

If (Count parameters:C259=3)
	If ($vt_tipo="A")
		$vt_relleno:=" "
		$vt_alignValue:="L"
	Else 
		$vt_relleno:="0"
		$vt_alignValue:="R"
	End if 
Else 
	$vt_relleno:=$4
	$vt_alignValue:=$5
End if 

If ($vt_alignValue="L")
	$vt_return:=ST_LeftChars ($vt_value+($vt_relleno*$vl_len);$vl_len)
Else 
	$vt_return:=ST_RigthChars (($vt_relleno*$vl_len)+$vt_value;$vl_len)
End if 

$0:=$vt_return