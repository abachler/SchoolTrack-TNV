//%attributes = {}
  //BC_Barcode_SetPattern

  // adds Element to Barcode_Pattern

C_LONGINT:C283($1;$ascii)
C_TEXT:C284($2;$pattern)
C_LONGINT:C283($3;$ascii2)

$ascii:=$1
$pattern:=$2
If (Count parameters:C259>2)
	$ascii2:=$3
Else 
	$ascii2:=$ascii  // used for Code128, Type B
End if 
Barcode_Pattern{$ascii}:=$pattern
Barcode_Pattern2{$ascii2}:=$pattern
AT_Insert (0;1;->Barcode_Wertigkeit)
Barcode_Wertigkeit{Size of array:C274(Barcode_Wertigkeit)}:=$ascii

  //habían problemas al imprimir utilizando code 128C. Al comentar las siguientes 4 líneas el problema se solucionó
  //If (Barcode_Pattern{0}="10100001100")  ` code128
  //AT_Insert (0;1;->Barcode_Wertigkeit)
  //Barcode_Wertigkeit{Size of array(Barcode_Wertigkeit)}:=$ascii
  //End if 