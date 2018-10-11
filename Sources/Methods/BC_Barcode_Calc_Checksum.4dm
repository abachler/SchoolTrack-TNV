//%attributes = {}
  //BC_Barcode_Calc_Checksum

  // $Checksum := Calc_Checksum($Barcodetype; $Code)
  // all parameters are text
  // $Checksum = "?" for unknown barcodes

C_TEXT:C284($1;$2;$0)

If ($2#"")
	
	Case of 
		: ($1="Code39")
			$0:=BC_Barcode_Calc_Checksum_Code39 ($2)
			
		: ($1="Code128@")
			$0:=BC_Barcode_Calc_ChecksumCode128 ($2;$1)
			
		: (($1="Industrial 2 of 5") | ($1="Interleaved 2 of 5"))
			$0:=BC_Barcode_Calc_ChcksumIndustri ($2;$1)
			
		: ($1="EAN13")
			$0:=BC_Barcode_Calc_Checksum_EAN13 ($2)
			
		: ($1="EAN8")
			$0:=BC_Barcode_Calc_Checksum_EAN13 ("00000"+$2)
			
		: ($1="UPC-A")
			$0:=BC_Barcode_Calc_Checksum_UPCA ($2)
			
		: ($1="UPC-E")
			$0:=""
			  // nothing can be done here, this needs to replace the whole code
			
		Else 
			$0:="?"
	End case 
	
Else 
	$0:=""
End if 
