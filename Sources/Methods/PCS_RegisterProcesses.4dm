//%attributes = {}
  //PCS_RegisterProcesses

$processID:=$1
$element:=Find in array:C230(<>alXS_RegisteredProcessIDs;$processID)
If ($element=-1)
	$element:=Size of array:C274(<>alXS_RegisteredProcessIDs)
	AT_Insert ($element;1;-><>alXS_RegisteredProcessIDs;-><>atXS_RegisteredProcessNames)
End if 
PROCESS PROPERTIES:C336($processID;$procName;$ProcState;$procTime)
<>alXS_RegisteredProcessIDs{$element}:=$processID
<>atXS_RegisteredProcessNames{$element}:=$procName