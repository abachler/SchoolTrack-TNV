//%attributes = {}
  //SN3_AssignNewIDs

C_POINTER:C301($fieldPtr;$tablePtr;$1)

$fieldPtr:=$1
$tablePtr:=Table:C252(Table:C252($fieldPtr))

$p:=IT_UThermometer (1;0;__ ("Actualizando identificadores..."))
READ WRITE:C146($tablePtr->)
QUERY:C277($tablePtr->;$fieldPtr->=0)
ARRAY LONGINT:C221($ids;Records in selection:C76($tablePtr->))
For ($i;1;Size of array:C274($ids))
	$ids{$i}:=SQ_SeqNumber ($fieldPtr)
End for 
ARRAY TO SELECTION:C261($ids;$fieldPtr->)
KRL_UnloadReadOnly ($tablePtr)
SQ_getLastID ($fieldPtr)
IT_UThermometer (-2;$p)