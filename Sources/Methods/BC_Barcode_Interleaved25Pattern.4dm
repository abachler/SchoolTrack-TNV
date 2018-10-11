//%attributes = {}
  //Barcode_Interleaved25_Pattern

  // converts Interleaved 2 of 5 to Pattern
  // Industrial 2 of 5 barcode only contains chars 0-9
  //illegal chars are removed

  // $1 = Text, $0 = Pattern

C_TEXT:C284($1;$0;$code;$pattern)
_O_C_STRING:C293(10;$digit)
C_LONGINT:C283($i;$digitvalue;$pos;$pos1;$pos2;$digitpos)
C_TEXT:C284($p1;$p2;$digitpattern)

$code:=""
For ($i;1;Length:C16($1))
	$digit:=$1[[$i]]
	If (($digit>="0") & ($digit<="9"))
		$code:=$code+$digit
	End if 
End for 

If ((Length:C16($code)%2)#0)
	$code:="0"+$code
End if 
$pattern:="1010"

BC_BarcodeCreateIndustrial25Arr   // same pattern for Interleaved

For ($i;1;Length:C16($code);2)
	$digit:=$code[[$i]]
	$digitvalue:=Num:C11($digit)
	$p1:=Barcode_Pattern{$digitvalue}
	
	$digit:=$code[[$i+1]]
	$digitvalue:=Num:C11($digit)
	$p2:=Barcode_Pattern{$digitvalue}
	
	$pos1:=1
	$pos2:=1
	$digitpos:=1
	$digitpattern:=""
	  // $pattern:=$pattern+"_"  ` helps debugging
	
	While ($pos2<12)  //  barcode has 12 lines
		If ($digitpos=1)
			While ($p1[[$pos1]]="1")
				$digitpattern:=$digitpattern+"1"
				$pos1:=$pos1+1
			End while 
			$digitpos:=2
			$pos1:=$pos1+1
		Else   //white pos filled with digit 2
			While ($p2[[$pos2]]="1")
				$digitpattern:=$digitpattern+"0"
				$pos2:=$pos2+1
			End while 
			$digitpos:=1
			$pos2:=$pos2+1
		End if 
	End while 
	$pattern:=$pattern+$digitpattern
	  // $pattern:=$pattern+"_"  ` helps debugging
	
End for 
$pattern:=$pattern+"1101"
$0:=$pattern