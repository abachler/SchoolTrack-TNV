//%attributes = {}
  //Barcode_Convert_Pattern

  // $Pattern := Barcode_Pattern($Barcodetype; $Code)
  // all parameters are text
  // $Pattern = "" for unknown barcodes

C_TEXT:C284($1;$2;$0)

$0:=""

If ($2#"")
	
	Case of 
		: ($1="Code39")
			$0:=BC_Barcode_Code39_Pattern ($2)
			
		: ($1="Code128@")
			$0:=BC_Barcode_Code128_Pattern ($2;$1)
			
		: ($1="Industrial 2 of 5")
			$0:=BC_Barcode_Industrial25_Pattern ($2)
			
		: ($1="Interleaved 2 of 5")
			$0:=BC_Barcode_Interleaved25Pattern ($2)
			
		: ($1="EAN13")
			$0:=BC_Barcode_EAN13_Pattern ($2)
			
		: ($1="EAN8")
			$0:=BC_Barcode_EAN8_Pattern ($2)
			
		: ($1="UPC-A")
			$0:=BC_Barcode_UPCA_Pattern ($2)
			
		: ($1="UPC-E")
			$0:=BC_Barcode_UPCE_Pattern ($2)
			
		: ($1="Supplemental2")
			$0:=BC_Barcode_Supplemental2Pattern ($2)
			
		: ($1="Supplemental5")
			$0:=BC_Barcode_Supplemental5Pattern ($2)
		Else 
			  // ALERT("Unknown Barcode Type")
			$0:=""
	End case 
Else 
	$0:=""
End if 