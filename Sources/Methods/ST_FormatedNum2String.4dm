//%attributes = {}
  //ST_FormatedNum2String

C_REAL:C285($number;$1)
_O_C_STRING:C293(255;$format;$2;$0)
If (Count parameters:C259=2)
	$format:=$2
Else 
	$format:="EUR"
End if 
$number:=$1

$text:=String:C10($number;"### ### ##0,00")
If ($format="US")
	$text:=Replace string:C233($text;" ";"space")
	$text:=Replace string:C233($text;",";".")
	$text:=Replace string:C233($text;"space";",")
End if 
$0:=$text