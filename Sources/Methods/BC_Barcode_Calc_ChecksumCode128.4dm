//%attributes = {}
  //BC_Barcode_Calc_ChecksumCode128


  // Creates Checksum for Code 128
  // the checksum is mandatory !!!
C_TEXT:C284($1;$code;$2;$type;$0;$result)
  // Type = 128A, B or C
  // the first char must be the Codetype, it is part of the checksum
  // add all chars, use the double value for the 2nd char, trippe for 3rd and so on
  // use mod 103 for the checksum

C_LONGINT:C283($Check;$i;$wert;$checksum)

$code:=$1
$type:=$2
BC_Barcode_Create_Code128_Array 

$check:=0
Case of 
	: ($type="Code128A")
		$check:=103
		
	: ($type="Code128B")
		$check:=104
		
	: ($type="Code128C")
		$check:=105
		ARRAY LONGINT:C221($al_positionFN1;0)
		$code:=BC_Barcode_128C_Colombia ("Code2CalCheck";->$code;->$al_positionFN1)
		If ((Length:C16($code)%2)#0)
			$code:="0"+$code
		End if 
	Else 
		$code:=""
End case 

Case of 
	: ($type="Code128C")
		$ponderador:=-1
		For ($i;1;Length:C16($code);2)
			If ((Find in array:C230($al_positionFN1;$i)>0) | (Find in array:C230($al_positionFN1;$i-1)>0))
				$ponderador:=$ponderador+2
				$check:=$check+(102*(($ponderador+1)/2))
			End if 
			$ponderador:=$ponderador+2
			$wert:=Num:C11($code[[$i]]+$code[[$i+1]])
			$check:=$check+($wert*(($ponderador+1)/2))
		End for 
		
		  //código antiguo
		  //For ($i;1;Length($code);2)
		  //$wert:=Num($code[[$i]]+$code[[$i+1]])
		  //$check:=$check+($wert*(($i+1)/2))
		  //End for 
		
	: ($type="Code128B")
		For ($i;1;Length:C16($code))
			  // we cannot use Find in array because we need to decide between uppercase and lowercase
			$wert:=Find in array:C230(Barcode_Wertigkeit2;Character code:C91($code[[$i]]))-1  // array starts with element 1
			$check:=$check+($wert*$i)
		End for 
	Else   // 128A, this is easy, we can use Find in array, it will be faster interpreted
		For ($i;1;Length:C16($code))
			$wert:=Find in array:C230(Barcode_Wertigkeit;Character code:C91($code[[$i]]))-1  // array starts with element 1
			$check:=$check+($wert*$i)
		End for 
End case 


$checksum:=$check%103  // checksum
dhBarcode_Element:=0
Case of 
	: ($type="Code128A")
		$result:=Char:C90(Barcode_Wertigkeit{$checksum+1})
		
	: ($type="Code128B")
		$result:=Char:C90(Barcode_Wertigkeit2{$checksum+1})
		
	: ($type="Code128C")
		  //$result:=String($checksum;"00")
		If (Length:C16(String:C10($checksum))<=2)
			$result:=String:C10($checksum;"00")
		Else 
			Case of 
				: ($checksum=100)
					dhBarcode_Element:=105
				: ($checksum=101)
					dhBarcode_Element:=106
				: ($checksum=102)
					dhBarcode_Element:=107
			End case 
		End if 
	Else 
		$code:=""
End case 


$0:=$result
