//%attributes = {}
  //ACTcc_AsignNewIDApdo

C_POINTER:C301($1;$2;$3;$4)
C_POINTER:C301($array;$table;$field;$var)

C_BOOLEAN:C305($5)
C_BOOLEAN:C305($stopTrigger)

$array:=$1
$table:=$2
$field:=$3
$var:=$4

$stopTrigger:=False:C215
If (Count parameters:C259=5)
	$stopTrigger:=$5
End if 
SET_ClearSets ("lockedSet")  //20110408 RCH cuando se hace un array to selection cuando no hay registros en la tabla el set no se limpia
ARRAY LONGINT:C221($array->;0)
ARRAY LONGINT:C221($array->;Records in selection:C76($table->))
AT_Populate ($array;$var)
If ($stopTrigger)
	  //0xDev_AvoidTriggerExecution (True)
	ARRAY TO SELECTION:C261($array->;$field->)
	  //0xDev_AvoidTriggerExecution (False)
Else 
	ARRAY TO SELECTION:C261($array->;$field->)
End if 
$0:=Records in set:C195("lockedSet")
AT_Initialize ($array)
KRL_UnloadReadOnly ($table)