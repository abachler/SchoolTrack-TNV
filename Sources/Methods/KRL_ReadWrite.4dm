//%attributes = {}
  //KRL_ReadWrite

$tablePointer:=$1
READ WRITE:C146($tablePointer->)
LOAD RECORD:C52($tablePointer->)
$0:=Locked:C147($tablePointer->)