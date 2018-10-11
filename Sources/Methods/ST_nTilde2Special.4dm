//%attributes = {}
  //st_nTilde2Special 

C_TEXT:C284($1;$string;$result;$0)
$String:=$1
$result:=""
For ($j;1;Length:C16($String))
	$c:=Character code:C91($String[[$j]])
	Case of 
		: ($c=132)
			$result:=$result+"N^"
		: ($c=150)
			$result:=$result+"n´"
		Else 
			$result:=$result+$string[[$j]]
	End case 
End for 
$0:=$result