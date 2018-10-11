//%attributes = {}
  //ST_DeleteCharsLeft

C_TEXT:C284($1;$2;$text;$char)

$text:=$1
$char:=$2
$0:=$text
For ($i;1;Length:C16($text))
	If ($text[[$i]]=$char)
		$0:=Substring:C12($text;$i+1)
	Else 
		$i:=Length:C16($text)+1
	End if 
End for 