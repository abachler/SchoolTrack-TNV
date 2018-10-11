//%attributes = {}
  //Barcode_EAN13_Pattern

  // converts EAN13 to Pattern
  // EAN13 barcode only contains chars 0-9
  //illegal chars are removed
  // length must be 12 + 1 (checksum)

  // $1 = Text, $0 = Pattern

C_TEXT:C284($1;$0;$code;$pattern)
C_LONGINT:C283($i;$Id)
C_TEXT:C284($digitOne)
_O_C_STRING:C293(10;$digit)

$code:=""
For ($i;1;Length:C16($1))
	$digit:=$1[[$i]]
	If (($digit>="0") & ($digit<="9"))
		$code:=$code+$digit
	End if 
End for 

Case of 
	: (Length:C16($code)=13)
		  // fine
	: (Length:C16($code)=12)  // checksum is missing
		$code:=$code+BC_Barcode_Calc_Checksum_EAN13 ($code)
		
	Else 
		$code:=""  // error
End case 

If ($code#"")
	$pattern:="202"  // 2 = long line
	
	BC_Barcode_Create_EAN13_Array 
	
	
	$digitONE:=Barcode_Pattern{Num:C11($code[[1]])}
	For ($i;1;6)
		$id:=Num:C11($code[[$i+1]])
		If ($digitONE[[$i]]="1")
			$pattern:=$pattern+Barcode_Pattern{$id+10}
		Else 
			$pattern:=$pattern+Barcode_Pattern{$id+20}
		End if 
		  // $pattern:=$pattern+"_"  ` helps debugging
	End for 
	$pattern:=$pattern+"02020"
	For ($i;8;13)
		$id:=Num:C11($code[[$i]])
		$pattern:=$pattern+Barcode_Pattern{$id+30}
		  // $pattern:=$pattern+"_"  ` helps debugging
	End for 
	$pattern:=$pattern+"202"
Else 
	$pattern:=""
End if 
$0:=$pattern