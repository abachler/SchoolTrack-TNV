//%attributes = {}
  //Barcode_Supplemental2_Pattern

  // converts Supplemental Code with 2 digits to Pattern
  // EAN13 barcode only contains chars 0-9
  //illegal chars are removed
  // length must be 2

  // $1 = Text, $0 = Pattern
C_TEXT:C284($1;$0;$code;$pattern)
C_LONGINT:C283($i;$id;$remainder)
_O_C_STRING:C293(10;$digit;$digitONE)

$code:=""
For ($i;1;Length:C16($1))
	$digit:=$1[[$i]]
	If (($digit>="0") & ($digit<="9"))
		$code:=$code+$digit
	End if 
End for 

If (Length:C16($code)#2)
	$code:=""  // error
	$pattern:=""
Else 
	$pattern:="1011"
	BC_Barcode_Create_EAN13_Array 
	
	$remainder:=Num:C11($code)%4
	Case of 
		: ($remainder=0)
			$digitONE:="11"
		: ($remainder=1)
			$digitONE:="10"
		: ($remainder=2)
			$digitONE:="01"
		: ($remainder=3)
			$digitONE:="00"
	End case 
	
	For ($i;1;2)
		$id:=Num:C11($code[[$i]])
		If ($digitONE[[$i]]="1")
			$pattern:=$pattern+Barcode_Pattern{$id+10}
		Else 
			$pattern:=$pattern+Barcode_Pattern{$id+20}
		End if 
		If ($i=1)
			$pattern:=$pattern+"01"
		End if 
	End for 
	
End if 
$0:=$pattern