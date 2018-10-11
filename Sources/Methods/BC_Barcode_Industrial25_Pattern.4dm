//%attributes = {}
  //Barcode_Industrial25_Pattern

  // converts Industrial 2 of 5 to Pattern
  // Industrial 2 of 5 barcode only contains chars 0-9
  //illegal chars are removed

  // $1 = Text, $0 = Pattern

C_TEXT:C284($1;$0;$Code;$pattern)
C_LONGINT:C283($i;$digitvalue)
_O_C_STRING:C293(10;$digit)

$code:=$1
$pattern:="11011010"

BC_BarcodeCreateIndustrial25Arr 


For ($i;1;Length:C16($code))
	$digit:=$code[[$i]]
	If (($digit>="0") & ($digit<="9"))
		$digitvalue:=Num:C11($digit)
		$pattern:=$pattern+Barcode_Pattern{$digitvalue}
	End if 
End for 
$pattern:=$pattern+"11010110"
$0:=$pattern