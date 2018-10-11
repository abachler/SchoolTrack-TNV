//%attributes = {}
  //Barcode_Create_UPCE_Array

_O_ARRAY STRING:C218(13;Barcode_Pattern;40)
_O_ARRAY STRING:C218(13;Barcode_Pattern2;40)  // not needed for UPCE
ARRAY INTEGER:C220(Barcode_Wertigkeit;0)  // not needed for UPCE

If (Barcode_Pattern{0}#"000111")
	
	Barcode_Pattern{0}:="000111"
	
	  //  array holds 4 blocks, each 0-9 (10-19, etc)
	  // a = odd/even table if 1st digit is 0  (odd = 1, even = 0)
	  // b = odd/even table if 1st digit is 1
	  // c = 1st digit block, odd
	  // d = 1st digit block, even
	
	Barcode_Pattern{0}:="000111"
	Barcode_Pattern{1}:="001011"
	Barcode_Pattern{2}:="001101"
	Barcode_Pattern{3}:="001110"
	Barcode_Pattern{4}:="010011"
	Barcode_Pattern{5}:="011001"
	Barcode_Pattern{6}:="011100"
	Barcode_Pattern{7}:="010101"
	Barcode_Pattern{8}:="010110"
	Barcode_Pattern{9}:="011010"
	
	Barcode_Pattern{10}:="111000"
	Barcode_Pattern{11}:="110100"
	Barcode_Pattern{12}:="110010"
	Barcode_Pattern{13}:="110001"
	Barcode_Pattern{14}:="101100"
	Barcode_Pattern{15}:="100110"
	Barcode_Pattern{16}:="100011"
	Barcode_Pattern{17}:="101010"
	Barcode_Pattern{18}:="101001"
	Barcode_Pattern{19}:="100101"
	
	Barcode_Pattern{20}:="0001101"
	Barcode_Pattern{21}:="0011001"
	Barcode_Pattern{22}:="0010011"
	Barcode_Pattern{23}:="0111101"
	Barcode_Pattern{24}:="0100011"
	Barcode_Pattern{25}:="0110001"
	Barcode_Pattern{26}:="0101111"
	Barcode_Pattern{27}:="0111011"
	Barcode_Pattern{28}:="0110111"
	Barcode_Pattern{29}:="0001011"
	
	Barcode_Pattern{30}:="0100111"
	Barcode_Pattern{31}:="0110011"
	Barcode_Pattern{32}:="0011011"
	Barcode_Pattern{33}:="0100001"
	Barcode_Pattern{34}:="0011101"
	Barcode_Pattern{35}:="0111001"
	Barcode_Pattern{36}:="0000101"
	Barcode_Pattern{37}:="0010001"
	Barcode_Pattern{38}:="0001001"
	Barcode_Pattern{39}:="0010111"
End if 