//%attributes = {}
  //ACTxml_GetValidText

C_TEXT:C284($1;$0)
$string:=$1

ARRAY TEXT:C222($at_chars;0)
ARRAY TEXT:C222($at_charsRep;0)
APPEND TO ARRAY:C911($at_chars;Char:C90(38))  //AMP
APPEND TO ARRAY:C911($at_charsRep;"&amp")
APPEND TO ARRAY:C911($at_chars;Char:C90(34))  //QUOT
APPEND TO ARRAY:C911($at_charsRep;"&quot")
APPEND TO ARRAY:C911($at_chars;Char:C90(60))  // LT <
APPEND TO ARRAY:C911($at_charsRep;"&lt")
APPEND TO ARRAY:C911($at_chars;Char:C90(62))  //GT >
APPEND TO ARRAY:C911($at_charsRep;"&gt")
APPEND TO ARRAY:C911($at_chars;Char:C90(39))  //apos
APPEND TO ARRAY:C911($at_charsRep;"&apos")

If ($string#"")
	$i:=1
	  //For ($i;1;$vl_for)
	While ($i<=Length:C16($string))
		$vl_pos:=Find in array:C230($at_chars;$string[[$i]])
		If ($vl_pos>0)
			$string:=Substring:C12($string;1;$i-1)+$at_charsRep{$vl_pos}+Substring:C12($string;$i+1)
		End if 
		  //End for 
		$i:=$i+1
	End while 
End if 
$0:=$string