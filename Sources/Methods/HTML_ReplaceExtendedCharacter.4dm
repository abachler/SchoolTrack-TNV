//%attributes = {}
  //HTML_ReplaceExtendedCharacter

C_TEXT:C284($text;$1;$0;$3;$CharEntity)
C_LONGINT:C283($2;$ascii2compare)
$text:=$1
$ascii2compare:=$2
$CharEntity:=$3
$i:=1
$textTemp:=""
While ($i<=Length:C16($text))
	$asciiofchar:=Character code:C91($text[[$i]])
	If ($asciiofchar=$ascii2compare)
		$textTemp:=$textTemp+$CharEntity
	Else 
		$textTemp:=$textTemp+$text[[$i]]
	End if 
	$i:=$i+1
End while 

$0:=$textTemp