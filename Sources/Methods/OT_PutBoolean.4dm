//%attributes = {}
  //OT_PutBoolean

C_BOOLEAN:C305($3)
C_LONGINT:C283($otRef;$1)
C_TEXT:C284($2;$objectName)
$otref:=$1
$value:=Num:C11($3)
$objectName:=$2
OT PutLong ($otref;$objectName;$value)