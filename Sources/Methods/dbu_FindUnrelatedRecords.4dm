//%attributes = {}
  //dbu_FindUnrelatedRecords

C_POINTER:C301($1;$sourceField;$sourceTable;$2;$relatedTable;$relatedField)
C_LONGINT:C283($relatedTableNum;$sourceTableNum)
$sourceField:=$1
$sourceTableNum:=Table:C252($sourceField)
$sourceTable:=Table:C252($sourceTableNum)
$relatedField:=$2
$relatedTableNum:=Table:C252($relatedField)
$relatedTable:=Table:C252($relatedTableNum)
CREATE EMPTY SET:C140($sourceTable->;"unrelated_records")
CREATE SET:C116($sourceTable->;"records")
KRL_RelateSelection ($relatedField;$sourceField;"")
KRL_RelateSelection ($sourceField;$relatedField;"")
CREATE SET:C116($sourceTable->;"related_records")
DIFFERENCE:C122("records";"related_records";"unrelated_records")
USE SET:C118("unrelated_records")
SET_ClearSets ("records";"related_records";"unrelated_records")


