ARRAY INTEGER:C220(<>aStrIndex;iItems)
ARRAY TEXT:C222(<>aStrText;iItems)
For ($i;1;iItems)
	<>aStrIndex{$i}:=$i
	<>aStrText{$i}:=""
End for 
BLOB_Variables2Blob (->[xxSTR_TextosInformesNotas:56]xAleman:11;0;-><>aStrIndex;-><>aStrText)
BLOB_Variables2Blob (->[xxSTR_TextosInformesNotas:56]xCastellano:8;0;-><>aStrIndex;-><>aStrText)
BLOB_Variables2Blob (->[xxSTR_TextosInformesNotas:56]xFrances:10;0;-><>aStrIndex;-><>aStrText)
BLOB_Variables2Blob (->[xxSTR_TextosInformesNotas:56]xIngles:9;0;-><>aStrIndex;-><>aStrText)
BLOB_Variables2Blob (->[xxSTR_TextosInformesNotas:56]xItaliano:12;0;-><>aStrIndex;-><>aStrText)
ARRAY INTEGER:C220(<>aStrIndex;0)
ARRAY TEXT:C222(<>aStrText;0)
