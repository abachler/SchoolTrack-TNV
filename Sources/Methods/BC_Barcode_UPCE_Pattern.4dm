//%attributes = {}
  //Barcode_UPCE_Pattern

  // converts UPC-E to Pattern
  // UPC-E barcode only contains chars 0-9
  //illegal chars are removed
  // length must be 8

  // $1 = Text, $0 = Pattern
C_TEXT:C284($1;$0;$code;$pattern;$helppattern)
C_LONGINT:C283($i;$id;$index)
_O_C_STRING:C293(10;$digit)

$code:=""
For ($i;1;Length:C16($1))
	$digit:=$1[[$i]]
	If (($digit>="0") & ($digit<="9"))
		$code:=$code+$digit
	End if 
End for 

If ($code#"")
	If (($code[[1]]#"0") & ($code[[1]]#"1"))  // UPCE must start with 0 or 1
		$code:=""
	End if 
End if 

If (Length:C16($code)#8)
	$code:=""  // error
	$pattern:=""
Else 
	$pattern:="202"  // 2 = long line
	BC_Barcode_Create_UPCE_Array 
	
	If ($code[[1]]="0")
		$index:=0
	Else 
		$index:=10
	End if 
	$index:=$index+Num:C11($code[[8]])  // first digit gives table, check sum gives position in table
	
	$helppattern:=Barcode_Pattern{$index}
	
	For ($i;2;7)
		$id:=Num:C11($code[[$i]])
		If ($helppattern[[$i-1]]="0")
			$pattern:=$pattern+Barcode_Pattern{$id+30}
		Else 
			$pattern:=$pattern+Barcode_Pattern{$id+20}
		End if 
		  // $pattern:=$pattern+"_"  ` helps debugging
	End for 
	
	$pattern:=$pattern+"020202"
End if 
$0:=$pattern