//%attributes = {}
  //BC_Barcode_Calc_ChcksumIndustri 

  // calculates the checksum for Industrial Barcodes
  // multpli last digit with 3, previous with 1, previous with 3 and so on
  // sum mod 10, if 10 be 0

C_TEXT:C284($1;$2;$type;$code;$0;$result)
C_LONGINT:C283($i;$check;$checksum;$multi;$digitvalue)
C_TEXT:C284($digit)

$code:=""
For ($i;1;Length:C16($1))
	$digit:=$1
	If (($digit>="0") & ($digit<="9"))
		$code:=$code+$digit
	End if 
End for 
$type:=$2

BC_BarcodeCreateIndustrial25Arr 


If ($type="Interleaved@")
	If ((Length:C16($code)%2)#0)
		$code:="0"+$code
	End if 
End if 

$check:=0
$multi:=3
For ($i;Length:C16($code);1;-1)
	$digit:=$code[[$i]]
	$digitvalue:=Num:C11($digit)
	$check:=$check+($digitvalue*$multi)
	If ($multi=3)
		$multi:=1
	Else 
		$multi:=3
	End if 
End for 

$checksum:=(10-($check%10))%10
$result:=String:C10($checksum)

$0:=$result

