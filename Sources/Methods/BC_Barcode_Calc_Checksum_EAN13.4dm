//%attributes = {}
  //BC_Barcode_Calc_Checksum_EAN13

  // calculates the checksum for EAN-13 Barcodes
  // get's the value of each char, add it, rest of 43, 

C_TEXT:C284($1;$code;$0;$result)
C_LONGINT:C283($i;$Check)

$code:=$1

Case of 
	: (Length:C16($code)=13)  // EAN13 must be 13 char - without checksum 12!
		$result:=""
		$code:=Substring:C12($code;1;12)  // checksum already included. remove it
		
	: (Length:C16($code)=12)
		  // we have to calculate it
		$result:=""
		
	Else 
		$result:="?"
		$code:=""  // wrong length
		
End case 

If ($result="")
	$check:=0
	For ($i;0;11)
		$check:=$check+(Num:C11($code[[$i+1]])*((($i & 1)*2)+1))
	End for 
	$result:=String:C10((10-($check%10))%10)
End if 

$0:=$result

