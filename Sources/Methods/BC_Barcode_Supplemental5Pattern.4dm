//%attributes = {}
  //Barcode_Supplemental5_Pattern

  // converts Supplemental Code with 5 digits to Pattern
  // EAN13 barcode only contains chars 0-9
  //illegal chars are removed
  // length must be 5

  // $1 = Text, $0 = Pattern
C_TEXT:C284($1;$0;$code;$pattern)
C_LONGINT:C283($i;$id;$check;$result)
_O_C_STRING:C293(10;$digit)
C_TEXT:C284($helppattern)

$code:=""
For ($i;1;Length:C16($1))
	$digit:=$1[[$i]]
	If (($digit>="0") & ($digit<="9"))
		$code:=$code+$digit
	End if 
End for 

If (Length:C16($code)#5)
	$code:=""  // error
	$pattern:=""
Else 
	$pattern:="1011"
	BC_Barcode_Create_EAN13_Array 
	_O_ARRAY STRING:C218(13;$Barcode_Pattern3;10)
	$Barcode_Pattern3{0}:="00111"
	$Barcode_Pattern3{1}:="01011"
	$Barcode_Pattern3{2}:="01101"
	$Barcode_Pattern3{3}:="01110"
	$Barcode_Pattern3{4}:="10011"
	$Barcode_Pattern3{5}:="11001"
	$Barcode_Pattern3{6}:="11100"
	$Barcode_Pattern3{7}:="10101"
	$Barcode_Pattern3{8}:="10110"
	$Barcode_Pattern3{9}:="11010"
	
	$check:=0
	For ($i;0;4)
		If (($i & 1)=1)
			$check:=$check+(Num:C11($code[[$i+1]])*9)
		Else 
			$check:=$check+(Num:C11($code[[$i+1]])*3)
		End if 
	End for 
	$result:=$check%10
	
	$helppattern:=$Barcode_Pattern3{$result}
	For ($i;1;5)
		$id:=Num:C11($code[[$i]])
		If ($helppattern[[$i]]="1")
			$pattern:=$pattern+Barcode_Pattern{$id+10}
		Else 
			$pattern:=$pattern+Barcode_Pattern{$id+20}
		End if 
		  // $pattern:=$pattern+"_"
		If ($i#5)
			$pattern:=$pattern+"01"
		End if 
		  // $pattern:=$pattern+"_"
	End for 
	
End if 
$0:=$pattern