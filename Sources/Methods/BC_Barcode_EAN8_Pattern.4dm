//%attributes = {}
  //Barcode_EAN8_Pattern

  // converts EAN8 to Pattern
  // EAN13 barcode only contains chars 0-9
  //illegal chars are removed
  // length must be 7 + 1 (checksum)

  // $1 = Text, $0 = Pattern
C_TEXT:C284($1;$0;$code;$pattern)
C_LONGINT:C283($i;$id)
_O_C_STRING:C293(10;$digit)

$code:=""
For ($i;1;Length:C16($1))
	$digit:=$1[[$i]]
	If (($digit>="0") & ($digit<="9"))
		$code:=$code+$digit
	End if 
End for 

Case of 
	: (Length:C16($code)=8)
		  // fine 
	: (Length:C16($code)=7)  // checksum is missing
		$code:=$code+BC_Barcode_Calc_Checksum_EAN13 ("00000"+$code)
	: (Length:C16($code)=9)  // checksum duplicated?
		If ($code[[8]]=$code[[9]])
			$code:=Substring:C12($code;1;8)
		Else 
			$code:=""
		End if 
	Else 
		$code:=""  // error
End case 

If ($code#"")
	$pattern:="202"  // 2 = long line
	BC_Barcode_Create_EAN13_Array 
	
	For ($i;1;4)
		$id:=Num:C11($code[[$i]])
		$pattern:=$pattern+Barcode_Pattern{$id+10}
		  // $pattern:=$pattern+"_"  ` helps debugging
	End for 
	$pattern:=$pattern+"02020"
	For ($i;5;8)
		$id:=Num:C11($code[[$i]])
		$pattern:=$pattern+Barcode_Pattern{$id+30}
		  // $pattern:=$pattern+"_"  ` helps debugging
	End for 
	$pattern:=$pattern+"202"
Else 
	$pattern:=""
End if 
$0:=$pattern