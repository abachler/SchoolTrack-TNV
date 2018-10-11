//%attributes = {}
  //ST_ReplaceCharByAsciiCode

C_TEXT:C284($1;$0)
_O_C_STRING:C293(1;$2;$3)
$string:=$1

If ($string#"")
	$ascii2Replace:=Character code:C91($2)
	$replacementChar:=$3
	For ($i;1;Length:C16($string))
		If (Character code:C91($string[[$i]])=$ascii2Replace)
			$string:=Substring:C12($string;1;$i-1)+$replacementChar+Substring:C12($string;$i+1)
		End if 
	End for 
End if 
$0:=$string