//%attributes = {}
  //BC_Barcode_Calc_Checksum_UPCA

  // calculates the checksum for UPC-A Barcodes
  // identical to EAN-13, just one digit less

C_TEXT:C284($1;$code;$0;$result)

$code:=$1

Case of 
	: (Length:C16($code)=12)  // UPC-A must be 12 char - without checksum 11!
		$code:=Substring:C12($code;1;11)  // checksum already included. Remove it
		$result:=""
		
	: (Length:C16($code)=11)
		  // we have to calculate it
		$result:=""
		
	Else 
		$result:="?"
		$code:=""  // wrong length
		
End case 

If ($result="")
	$result:=BC_Barcode_Calc_Checksum_EAN13 ("0"+$code)
End if 

$0:=$result

