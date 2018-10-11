//%attributes = {}
  //ST_num2String

C_TEXT:C284($2)
C_REAL:C285($1;$number)
$Number:=$1
If (Count parameters:C259=2)
	$format:=$2
Else 
	$format:=""
End if 

If (Undefined:C82(<>tXS_RS_DecimalSeparator))
	<>tXS_RS_DecimalSeparator:=Substring:C12(String:C10(2/3);2;1)
End if 

If (Undefined:C82(<>vs_AppDecimalSeparator))
	<>vs_AppDecimalSeparator:=<>tXS_RS_DecimalSeparator
End if 

If (<>tXS_RS_DecimalSeparator#<>vs_AppDecimalSeparator)
	$format:=Replace string:C233($format;<>vs_AppDecimalSeparator;<>tXS_RS_DecimalSeparator)
	$string:=String:C10($number;$format)
	$string:=Replace string:C233($string;<>tXS_RS_DecimalSeparator;<>vs_AppDecimalSeparator)
Else 
	$string:=String:C10($number;$format)
End if 

$0:=$string