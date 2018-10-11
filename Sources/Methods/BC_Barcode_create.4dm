//%attributes = {}
  //  Creates a picture for a barcode
  // $pict := GetBarcode(barcodetype;code;createchecksum;showchecksum;printcode)
  // the barcode variables MUST be set before!
  //***********************
  //20140515 ASM Por el cambio de componente para trabajar los codigos de barra, Reintegre los metodos que se utilizaban en 10.4 hasta 11.4 que funcionaban con 4Dchart
  //Todos los metodos que integre comienzan con la sigla "BC_"  para poder indentificarlos facilmente.
  //  utilizar solo para los códigos de los informes de avisos de cobranza.

  //***********************

C_PICTURE:C286($0;$barcode)
_O_C_STRING:C293(21;$1;$barcodetype)
_O_C_STRING:C293(255;$2;$code)
C_BOOLEAN:C305($3;$createchecksum)
C_BOOLEAN:C305($4;$showchecksum)
C_BOOLEAN:C305($5;$printcode)
C_LONGINT:C283($6;$barchart)

C_LONGINT:C283($scale)
C_BOOLEAN:C305($localinit)
_O_C_STRING:C293(10;$checksum)
C_TEXT:C284($pattern)

$barcodetype:=$1
$code:=$2
$createchecksum:=$3
$showchecksum:=$4
$printcode:=$5
If (Count parameters:C259>5)
	$barchart:=$6
Else 
	$barchart:=0
End if 

C_LONGINT:C283(Barcode_Width)  // only for interpreted usage
barcode_width:=0  // ABK
dhBarcode_Element:=0  //se utiliza en la generacion del 128c. Cuando el resto de la division retorma mas de 99 se llena esta variable...
If (Barcode_Width=0)
	$LocalInit:=True:C214
	$scale:=1  //  create the picture bigger, increase readability for inkjet printers
	If ($barcodetype="Supplemental@")
		Barcode_Height:=25*$scale
	Else 
		Barcode_Height:=40*$scale
	End if 
	Barcode_Width:=1*$scale
	Barcode_Add:=3*$scale
	Barcode_Font:="Arial"
	Barcode_FontSize:=9*$scale
	Barcode_FontOffset:=5*$scale
Else 
	$LocalInit:=False:C215
End if 

If (($barcodetype="UPC@") | ($barcodetype="EAN@"))  // handling of GTIN numbers
	If ((Length:C16($code)=13) | (Length:C16($code)=14))
		Case of 
			: (($barcodetype="EAN8") & ($code="000000@"))
				$code:=Substring:C12($code;7)
			: (($barcodetype="EAN13") & ($code="0@"))
				$code:=Substring:C12($code;2)
			: (($barcodetype="UPC-A") & ($code="00@"))
				$code:=Substring:C12($code;3)
			: (($barcodetype="UPC-E") & ($code="000000@"))
				$code:=Substring:C12($code;7)
		End case 
	End if 
End if 

If ($barcodetype="UPC-E")
	$checksum:=""
	$code:=BC_Barcode_Calc_Checksum_UPCE ($code;$barcodetype)
Else 
	If ($createchecksum)
		$checksum:=BC_Barcode_Calc_Checksum ($barcodetype;$code)
		Case of 
			: ($barcodetype="EAN8")
				If (Length:C16($code)=8)
					If ($checksum=$code[[8]])
						$checksum:=""
					End if 
				End if 
			: ($barcodetype="EAN13")
				If (Length:C16($code)=13)
					If ($checksum=$code[[13]])
						$checksum:=""
					End if 
				End if 
			: ($barcodetype="UPC-A")
				If (Length:C16($code)=12)
					If ($checksum=$code[[12]])
						$checksum:=""
					End if 
				End if 
		End case 
	Else 
		$checksum:=""
	End if 
End if 

$pattern:=BC_Barcode_Convert_Pattern ($barcodetype;$code+$checksum)

If ($pattern#"")
	If ($printcode)
		If ($showchecksum)
			$code:=$code+$checksum
		End if 
		$code:=BC_Barcode_128C_Colombia ("Code2Print";->$barcodetype;->$code)
	Else 
		$code:=""
	End if 
	If (Application version:C493<="14@")
		  //If ($barchart#0)
		  //$barcode:=BC_Barcode_PatternToPict ($pattern;$code;$barcodetype;$barchart)
		  //Else 
		  //$barcode:=BC_Barcode_PatternToPict ($pattern;$code;$barcodetype)
		  //End if 
	Else 
		$barcode:=$barcode*0
	End if 
End if 

If ($LocalInit)
	
	  //********* CODIGO ORIGINAL ********
	Barcode_Width:=0  // reset
	$barcode:=$barcode | $barcode  // convert to bitmap
	$barcode:=$barcode*(1/$scale)  // scale back to original size
	  //********* CODIGO ORIGINAL ********
Else 
	  //$barcode:=$barcode | $barcode  ` convert to bitmap ` ABK
End if 


$0:=$barcode