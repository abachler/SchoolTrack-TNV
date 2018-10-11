//%attributes = {}
  //BC_Barcode_Code128_Pattern

  // converts Code128 to Pattern
  // $1 = Text, $2 = Type (A, B, C), $0 = Pattern
  // checksum is mandatory

C_TEXT:C284($1;$code;$0;$pattern;$2;$type)
C_LONGINT:C283($i;$wert;$id)
C_TEXT:C284($curpattern)

$code:=$1
$type:=$2
$pattern:=""

BC_Barcode_Create_Code128_Array   // called already from Calc_Checksum
Case of 
	: ($type="Code128A")
		$pattern:=Barcode_Pattern{108}
		
	: ($type="Code128B")
		$pattern:=Barcode_Pattern{109}
		
	: ($type="Code128C")
		ARRAY LONGINT:C221($al_positionFN1;0)
		$code:=BC_Barcode_128C_Colombia ("Code2CalCheck";->$code;->$al_positionFN1)
		$pattern:=Barcode_Pattern{110}
		If ((Length:C16($code)%2)#0)
			$code:="0"+$code
		End if 
	Else 
		$code:=""
End case 

  //  $pattern:=$pattern+"_"   ` helps debugging

If ($type="Code128C")
	For ($i;1;Length:C16($code);2)
		$pattern:=$pattern+BC_Barcode_128C_Colombia ("InsertFN12Pattern";->$i;->$al_positionFN1)
		$wert:=Num:C11($code[[$i]]+$code[[$i+1]])
		$pattern:=$pattern+Barcode_Pattern{Barcode_Wertigkeit{$wert+1}}
	End for 
	If (dhBarcode_Element#0)
		$pattern:=$pattern+Barcode_Pattern{dhBarcode_Element}
		dhBarcode_Element:=0
	End if 
	
	  //20090608 código antiguo *****INICIO*****
	  //For ($i;1;Length($code);2)
	  //$wert:=Num($code[[$i]]+$code[[$i+1]])
	  //$pattern:=$pattern+Barcode_Pattern{Barcode_Wertigkeit{$wert+1}}
	  //  ` $pattern:=$pattern+"_"
	  //End for 
	  //20090608 código antiguo *****FIN*****
Else 
	For ($i;1;Length:C16($code))
		$id:=Character code:C91($code[[$i]])
		If ($id<128)
			$curpattern:=""
			Case of 
				: ($type="Code128A")
					$curpattern:=Barcode_Pattern{$id}
				: ($type="Code128B")
					$curpattern:=Barcode_Pattern2{$id}
				Else 
					$curpattern:=""
			End case 
			
			$pattern:=$pattern+$curpattern
		End if   // nothing for upper ascii chars
		  // $pattern:=$pattern+"_"
	End for 
End if 
$0:=$pattern+Barcode_Pattern{111}  // stop code