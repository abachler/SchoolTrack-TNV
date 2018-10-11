//%attributes = {}
$y_tablePointer:=$1
$l_recNum:=$2

GOTO RECORD:C242($y_tablePointer->;$l_recNum)
DUPLICATE RECORD:C225($y_tablePointer->)
PUSH RECORD:C176($y_tablePointer->)
GOTO RECORD:C242($y_tablePointer->;$l_recNum)
READ WRITE:C146($y_tablePointer->)
DELETE RECORD:C58($y_tablePointer->)
POP RECORD:C177($y_tablePointer->)
SAVE RECORD:C53($y_tablePointer->)

