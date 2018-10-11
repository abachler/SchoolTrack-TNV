//%attributes = {}
  //ACTio_Text2Num

  //En algunos casos los números pueden venir con separador de miles y decimal. En esos casos, si es que la configuración regional no coincide con lo
  //que viene en el archivo como separador de miles y decimal, los montos pueden ser mal obtenidos al solamente hacer un num del texto.

C_TEXT:C284($vt_entero;$vt_decimal)
C_REAL:C285($0;$vr_entero;$vr_decimal)

$vt_entero:=$1
$vt_decimal:=$2

$vt_entero:=Replace string:C233($vt_entero;".";"")
$vt_entero:=Replace string:C233($vt_entero;",";"")
$vr_entero:=Num:C11($vt_entero)
$vt_entero:=String:C10($vr_entero)

$vt_decimal:=Replace string:C233($vt_decimal;".";"")
$vt_decimal:=Replace string:C233($vt_decimal;",";"")
$vr_decimal:=Num:C11($vt_decimal)
$vt_decimal:=String:C10($vr_decimal)

$0:=Num:C11($vt_entero+<>tXS_RS_DecimalSeparator+$vt_decimal)