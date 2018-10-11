//%attributes = {}
  //PCS_UnRegisterProcess

$processID:=$1
$element:=Find in array:C230(<>alXS_RegisteredProcessIDs;$processID)
If ($element>0)
	AT_Delete ($element;1;-><>alXS_RegisteredProcessIDs;-><>atXS_RegisteredProcessNames)
End if 