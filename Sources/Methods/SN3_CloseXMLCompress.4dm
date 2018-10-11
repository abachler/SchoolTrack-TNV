//%attributes = {}
  //SN3_CloseXMLCompress

C_TIME:C306($docRef)

$xmlRef:=$1
$path:=$2
$type:="dom"

If (Count parameters:C259=4)
	$type:=$3
	$docRef:=$4
End if 
$p:=IT_UThermometer (1;0;__ ("Cerrando y comprimiendo documento..."))
Case of 
	: ($type="dom")
		DOM EXPORT TO FILE:C862($xmlRef;$path)
		DOM CLOSE XML:C722($xmlRef)
	: ($type="sax")
		CLOSE DOCUMENT:C267($docRef)
End case 
SN3_CreateFile2Send ("comprimir";$path)
IT_UThermometer (-2;$p)