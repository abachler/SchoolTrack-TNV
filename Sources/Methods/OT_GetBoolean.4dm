//%attributes = {}
  //OT GetBoolean

C_LONGINT:C283($1;$otRef)
C_BOOLEAN:C305($boolean;$0)
C_TEXT:C284($2;$itemName)

$otRef:=$1
$itemName:=$2
$boolean:=(OT GetLong ($otRef;$itemName)=1)
$0:=$boolean


