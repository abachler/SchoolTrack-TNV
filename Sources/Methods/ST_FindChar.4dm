//%attributes = {}
  // method: st_FindChar - finds the position of a character in a string
  // $1 - string to search
  // $2 - the character to search for
  // $0 - the position of the character, returns -1 if does not find

C_LONGINT:C283($i;$0;$length)
C_TEXT:C284($1;$2)

$length:=Length:C16($1)
$0:=-1
For ($i;1;$length)
	If ($1[[$i]]=$2)
		$0:=$i
		$i:=$length+1
	End if 
End for 