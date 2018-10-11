//%attributes = {}
  //Barcode_Create_Code39_Array

  // creates the need arrays for Code39

_O_ARRAY STRING:C218(13;Barcode_Pattern;127)
_O_ARRAY STRING:C218(13;Barcode_Pattern2;127)  // not needed for Code39

If (Barcode_Pattern{0}#"Code39")
	ARRAY INTEGER:C220(Barcode_Wertigkeit;0)  // used for checksum
	
	Barcode_Pattern{0}:="Code39"
	
	BC_Barcode_SetPattern (Character code:C91("0");"1010011011010")
	BC_Barcode_SetPattern (Character code:C91("1");"1101001010110")
	BC_Barcode_SetPattern (Character code:C91("2");"1011001010110")
	BC_Barcode_SetPattern (Character code:C91("3");"1101100101010")
	BC_Barcode_SetPattern (Character code:C91("4");"1010011010110")
	BC_Barcode_SetPattern (Character code:C91("5");"1101001101010")
	BC_Barcode_SetPattern (Character code:C91("6");"1011001101010")
	BC_Barcode_SetPattern (Character code:C91("7");"1010010110110")
	BC_Barcode_SetPattern (Character code:C91("8");"1101001011010")
	BC_Barcode_SetPattern (Character code:C91("9");"1011001011010")
	BC_Barcode_SetPattern (Character code:C91("A");"1101010010110")
	BC_Barcode_SetPattern (Character code:C91("B");"1011010010110")
	BC_Barcode_SetPattern (Character code:C91("C");"1101101001010")
	BC_Barcode_SetPattern (Character code:C91("D");"1010110010110")
	BC_Barcode_SetPattern (Character code:C91("E");"1101011001010")
	BC_Barcode_SetPattern (Character code:C91("F");"1011011001010")
	BC_Barcode_SetPattern (Character code:C91("G");"1010100110110")
	BC_Barcode_SetPattern (Character code:C91("H");"1101010011010")
	BC_Barcode_SetPattern (Character code:C91("I");"1011010011010")
	BC_Barcode_SetPattern (Character code:C91("J");"1010110011010")
	BC_Barcode_SetPattern (Character code:C91("K");"1101010100110")
	BC_Barcode_SetPattern (Character code:C91("L");"1011010100110")
	BC_Barcode_SetPattern (Character code:C91("M");"1101101010010")
	BC_Barcode_SetPattern (Character code:C91("N");"1010110100110")
	BC_Barcode_SetPattern (Character code:C91("O");"1101011010010")
	BC_Barcode_SetPattern (Character code:C91("P");"1011011010010")
	BC_Barcode_SetPattern (Character code:C91("Q");"1010101100110")
	BC_Barcode_SetPattern (Character code:C91("R");"1101010110010")
	BC_Barcode_SetPattern (Character code:C91("S");"1011010110010")
	BC_Barcode_SetPattern (Character code:C91("T");"1010110110010")
	BC_Barcode_SetPattern (Character code:C91("U");"1100101010110")
	BC_Barcode_SetPattern (Character code:C91("V");"1001101010110")
	BC_Barcode_SetPattern (Character code:C91("W");"1100110101010")
	BC_Barcode_SetPattern (Character code:C91("X");"1001011010110")
	BC_Barcode_SetPattern (Character code:C91("Y");"1100101101010")
	BC_Barcode_SetPattern (Character code:C91("Z");"1001101101010")
	BC_Barcode_SetPattern (Character code:C91("-");"1001010110110")
	BC_Barcode_SetPattern (Character code:C91(".");"1100101011010")
	BC_Barcode_SetPattern (Character code:C91(" ");"1001101011010")
	BC_Barcode_SetPattern (Character code:C91("$");"1001001001010")
	BC_Barcode_SetPattern (Character code:C91("/");"1001001010010")
	BC_Barcode_SetPattern (Character code:C91("+");"1001010010010")
	BC_Barcode_SetPattern (Character code:C91("%");"1010010010010")
	BC_Barcode_SetPattern (Character code:C91("*");"1001011011010")
	
End if 