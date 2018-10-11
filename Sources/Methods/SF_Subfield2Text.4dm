//%attributes = {}
  //SF_Subfield2Text

C_TEXT:C284($0;$text)
C_POINTER:C301($1;$2)

If (Count parameters:C259=3)
	$concatChar:=$3
Else 
	$concatChar:=", "
End if 

_O_FIRST SUBRECORD:C61($1->)
$type:=Type:C295($2->)
For ($i;1;_O_Records in subselection:C7($1->))
	Case of 
		: (($type=8) & ($type#9) & ($type=1))
			$text:=$text+String:C10($2->)+$concatChar
		: (($type=0) | ($type=2))
			$text:=$text+$2->+$concatChar
		: ($type=4)
			$text:=$text+String:C10($2->;7)+$concatChar
	End case 
	_O_NEXT SUBRECORD:C62($1->)
End for 
$0:=Substring:C12($text;1;Length:C16($text)-2)
