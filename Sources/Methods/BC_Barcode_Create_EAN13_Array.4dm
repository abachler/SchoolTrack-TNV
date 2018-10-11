//%attributes = {}
  //Barcode_Create_EAN13_Array

_O_ARRAY STRING:C218(13;Barcode_Pattern;40)
_O_ARRAY STRING:C218(13;Barcode_Pattern2;40)  // not needed for EAN13

If (Barcode_Pattern{0}#"111111")
	
	Barcode_Pattern{0}:="111111"
	ARRAY INTEGER:C220(Barcode_Wertigkeit;0)  // not needed for EAN13
	
	  //  array holds 4 blocks, each 0-9 (10-19, etc)
	  // a = odd/even table for 1st digit to select table
	  // b = 1st digit block, odd
	  // c = 1st digit block, even
	  // d = 2nd digit block
	
	Barcode_Pattern{0}:="111111"
	Barcode_Pattern{1}:="110100"
	Barcode_Pattern{2}:="110010"
	Barcode_Pattern{3}:="110001"
	Barcode_Pattern{4}:="101100"
	Barcode_Pattern{5}:="100110"
	Barcode_Pattern{6}:="100011"
	Barcode_Pattern{7}:="101010"
	Barcode_Pattern{8}:="101001"
	Barcode_Pattern{9}:="100101"
	
	Barcode_Pattern{10}:="0001101"
	Barcode_Pattern{11}:="0011001"
	Barcode_Pattern{12}:="0010011"
	Barcode_Pattern{13}:="0111101"
	Barcode_Pattern{14}:="0100011"
	Barcode_Pattern{15}:="0110001"
	Barcode_Pattern{16}:="0101111"
	Barcode_Pattern{17}:="0111011"
	Barcode_Pattern{18}:="0110111"
	Barcode_Pattern{19}:="0001011"
	
	Barcode_Pattern{20}:="0100111"
	Barcode_Pattern{21}:="0110011"
	Barcode_Pattern{22}:="0011011"
	Barcode_Pattern{23}:="0100001"
	Barcode_Pattern{24}:="0011101"
	Barcode_Pattern{25}:="0111001"
	Barcode_Pattern{26}:="0000101"
	Barcode_Pattern{27}:="0010001"
	Barcode_Pattern{28}:="0001001"
	Barcode_Pattern{29}:="0010111"
	
	Barcode_Pattern{30}:="1110010"
	Barcode_Pattern{31}:="1100110"
	Barcode_Pattern{32}:="1101100"
	Barcode_Pattern{33}:="1000010"
	Barcode_Pattern{34}:="1011100"
	Barcode_Pattern{35}:="1001110"
	Barcode_Pattern{36}:="1010000"
	Barcode_Pattern{37}:="1000100"
	Barcode_Pattern{38}:="1001000"
	Barcode_Pattern{39}:="1110100"
	
End if 