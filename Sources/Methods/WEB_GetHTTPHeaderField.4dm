//%attributes = {}
  //WEB_GetHTTPHeaderField

C_LONGINT:C283($el)
C_TEXT:C284($0;$1;$field;$result)
ARRAY TEXT:C222($aNames;0)
ARRAY TEXT:C222($aValues;0)

$field:=$1

WEB GET HTTP HEADER:C697($aNames;$aValues)
$el:=Find in array:C230($aNames;$field)
If ($el>0)
	$result:=$aValues{$el}
End if 
$0:=$result