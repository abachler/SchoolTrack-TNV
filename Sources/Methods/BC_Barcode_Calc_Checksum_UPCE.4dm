//%attributes = {}
  //BC_Barcode_Calc_Checksum_UPCE


  // calculates the checksum for UPC-E Barcodes

  // an UPC-E is a reduced UPC-A with removed digits
  // at the end it is the 1st digits, the converted 6 digits and the original (!) check sum digit
  // this makes it a little more complicated to calculate

C_TEXT:C284($1;$code;$0;$result)
_O_C_STRING:C293(30;$manufactor;$product;$newcode)

$code:=$1

Case of 
	: (Length:C16($code)=8)
		$result:=$code  // we are done
		
	: (Length:C16($code)=12)  // fully UPC-A, we have to calculate it
		$result:=""
		
	: (Length:C16($code)=11)  //  UPC-A without checksum
		$code:=$code+BC_Barcode_Calc_Checksum_UPCA ($code)
		$result:=""
		
	Else 
		$result:="?"
		$code:=""  // wrong length
End case 

If ($result="")
	$manufactor:=Substring:C12($code;2;5)
	$product:=Substring:C12($code;7;5)
	Case of 
		: ((($manufactor="@000") | ($manufactor="@100") | ($manufactor="@200")) & ($product="00@"))
			$newcode:=Substring:C12($manufactor;1;2)+Substring:C12($product;3;3)+Substring:C12($manufactor;3;1)
			
		: (($manufactor="@00") & ($product="000@"))
			$newcode:=Substring:C12($manufactor;1;3)+Substring:C12($product;4;2)+"3"
			
		: (($manufactor="@0") & ($product="0000@"))
			$newcode:=Substring:C12($manufactor;1;4)+Substring:C12($product;5;1)+"4"
			
		: (($product>="00005") & ($product<="00009"))
			$newcode:=$manufactor+Substring:C12($product;5;1)
			
		Else 
			$newcode:="?"
	End case 
	
	If ($newcode#"?")
		$result:=$code[[1]]+$newcode+$code[[12]]
	Else 
		$result:=$newcode
	End if 
	
End if 

$0:=$result
