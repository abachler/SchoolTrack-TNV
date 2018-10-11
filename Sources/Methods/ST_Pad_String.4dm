//%attributes = {}
  //ST_Pad_String

C_POINTER:C301($1;$txtPtr)
C_LONGINT:C283($2;$3;$length;$asciiChar)
C_BOOLEAN:C305($4;$where2Pad)

$txtPtr:=$1
$length:=$2
$asciiChar:=$3
If (Count parameters:C259=4)
	$where2Pad:=$4
Else 
	$where2Pad:=False:C215
End if 

If (Length:C16($txtPtr->)<$length)
	$numChars:=$length-Length:C16($txtPtr->)
	If ($where2Pad)
		$txtPtr->:=$txtPtr->+(Char:C90($asciiChar)*$numChars)
	Else 
		$txtPtr->:=(Char:C90($asciiChar)*$numChars)+$txtPtr->
	End if 
End if 