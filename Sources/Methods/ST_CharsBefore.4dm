//%attributes = {}
  //ST_CharsBefore

  //$1: the string
  //$2: char to put before
  //$3: max length of the string
C_TEXT:C284($1)
_O_C_STRING:C293(1;$2)
C_LONGINT:C283($3)
$l:=Length:C16($1)
$prefix:=$2*($3-$l)
$0:=$prefix+$1
