//%attributes = {}
  //KRL_FixNANs

C_LONGINT:C283($fieldType;$fieldLength)
C_BOOLEAN:C305($indexed;$rebuildIndex)


$tablePointer:=$1
$fieldPointer:=$2

ARRAY LONGINT:C221($aRecNums;0)

ALL RECORDS:C47($tablePointer->)
LONGINT ARRAY FROM SELECTION:C647($tablePointer->;$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146($tablePointer->)
	GOTO RECORD:C242($tablePointer->;$aRecNums{$i})
	If (String:C10($fieldPointer->)="")
		$rebuildIndex:=True:C214
		$fieldPointer->:=0
		SAVE RECORD:C53($tablePointer->)
	End if 
End for 
KRL_UnloadReadOnly ($tablePointer)
ALL RECORDS:C47($tablePointer->)
GET FIELD PROPERTIES:C258($fieldPointer;$fieldType;$fieldLength;$indexed)

If ($indexed)
	SET INDEX:C344($fieldPointer->;False:C215)
	SET INDEX:C344($fieldPointer->;True:C214;50)
End if 