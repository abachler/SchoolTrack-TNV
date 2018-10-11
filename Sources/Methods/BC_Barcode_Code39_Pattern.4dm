//%attributes = {}
  //BC_Barcode_Code39_Pattern
  //Barcode_Code39_Pattern

  // converts Code39 to Pattern
  // A Code39 barcode only contains chars 0-9, A-Z, -. $/+%
  //illegal chars are removed

  // $1 = Text, $0 = Pattern

C_TEXT:C284($1;$0;$code;$pattern)
C_LONGINT:C283($i;$id)

$code:=$1
$pattern:=""

BC_Barcode_Create_Code39_Array 

If ($code#"*@")
	$code:="*"+$code
End if 
If ($code#"@*")
	$code:=$code+"*"
End if 
If (Length:C16($code)>32)  // code 39 has a limit of 30 characters
	$code:=Substring:C12($code;1;31)+"*"
End if 

For ($i;1;Length:C16($code))
	$id:=Character code:C91($code[[$i]])
	If ($id<128)
		$pattern:=$pattern+Barcode_Pattern{$id}
	End if   // nothing for upper ascii chars
End for 
$0:=$pattern