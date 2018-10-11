//%attributes = {}
  //ACTtrf_RemoveCheckCode

C_TEXT:C284($code;$1)
_O_C_STRING:C293(3;$chs)
C_LONGINT:C283($vl_long)

$code:=$1
$chs:=Char:C90(1)+Char:C90(1)+Char:C90(1)

$0:=Substring:C12($code;1;Position:C15($chs;$code;1;$vl_long;*)-1)
If ($0="")
	$0:=Substring:C12($code;1;Length:C16($code)-3)
End if 