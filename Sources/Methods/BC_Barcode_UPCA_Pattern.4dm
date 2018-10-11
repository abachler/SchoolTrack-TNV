//%attributes = {}
  //Barcode_UPCA_Pattern

  // converts UPCA to Pattern
  // UPCA barcode only contains chars 0-9
  //illegal chars are removed
  // length must be 11 + 1 (checksum)
  // pattern in similar to EAN-13, leading 0 must be added

  // $1 = Text, $0 = Pattern

C_TEXT:C284($1;$0;$code;$pattern)
C_LONGINT:C283($i)
_O_C_STRING:C293(10;$digit)

$code:=""
For ($i;1;Length:C16($1))
	$digit:=$1[[$i]]
	If (($digit>="0") & ($digit<="9"))
		$code:=$code+$digit
	End if 
End for 

Case of 
	: (Length:C16($code)=12)
		  // fine
	: (Length:C16($code)=11)  // checksum is missing
		$code:=$code+BC_Barcode_Calc_Checksum_UPCA ($code)
		
	Else 
		$code:=""  // error
End case 

If ($code#"")
	$pattern:=BC_Barcode_EAN13_Pattern ("0"+$code)
Else 
	$pattern:=""
End if 
$0:=$pattern