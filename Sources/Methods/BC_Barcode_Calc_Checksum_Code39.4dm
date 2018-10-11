//%attributes = {}
  //Barcode_Calc_Checksum_Code39

  // calculates the checksum for Code 39 Barcodes
  // get's the value of each char, add it, rest of 43, 

C_TEXT:C284($1;$code;$0;$result)
C_LONGINT:C283($i;$wert;$check;$checksum)

$code:=$1
If ($code="*@")
	$code:=Substring:C12($code;2)
End if 
If ($code="@*")
	$code:=Substring:C12($code;1;Length:C16($code)-1)
End if 
If (Length:C16($code)>29)  // code 39 has a limit of 30 char including checksum
	$code:=Substring:C12($code;1;29)
End if 

BC_Barcode_Create_Code39_Array 

$check:=0
For ($i;1;Length:C16($code))
	$wert:=Find in array:C230(Barcode_Wertigkeit;Character code:C91($code[[$i]]))-1  // array starts with element 1
	$check:=$check+$wert
End for 
$checksum:=$check%43  // checksum
If (($checksum>0) & ($checksum<Size of array:C274(Barcode_Wertigkeit)))
	$result:=Char:C90(Barcode_Wertigkeit{$checksum+1})
Else 
	$result:=Char:C90(0)
End if 
$0:=$result

