//%attributes = {}
  // creates the need arrays for Industrial 2 of 5 (also used for Interleaved 2 of 5)

_O_ARRAY STRING:C218(13;Barcode_Pattern;10)
_O_ARRAY STRING:C218(13;Barcode_Pattern2;10)  // not needed for Code39

If (Barcode_Pattern{0}#"101011011010")
	ARRAY INTEGER:C220(Barcode_Wertigkeit;0)  // used for checksum
	BC_Barcode_SetPattern (0;"101011011010")
	BC_Barcode_SetPattern (1;"110101010110")
	BC_Barcode_SetPattern (2;"101101010110")
	BC_Barcode_SetPattern (3;"110110101010")
	BC_Barcode_SetPattern (4;"101011010110")
	BC_Barcode_SetPattern (5;"110101101010")
	BC_Barcode_SetPattern (6;"101101101010")
	BC_Barcode_SetPattern (7;"101010110110")
	BC_Barcode_SetPattern (8;"110101011010")
	BC_Barcode_SetPattern (9;"101101011010")
End if 