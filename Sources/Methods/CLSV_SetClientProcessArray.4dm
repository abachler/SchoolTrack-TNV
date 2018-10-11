//%attributes = {}
  //CLSV_SetClientProcessArray

While (Semaphore:C143("ClientProcessArrays"))
	DELAY PROCESS:C323(Current process:C322;5)
End while 
$currentProcessPosition:=Size of array:C274(<>aClientProcessName)+1
$processID:=String:C10(Current process:C322)+":"+$1+":"+$2
$pos:=Find in array:C230(<>aClientProcessName;$processID)
If ($pos<0)
	AT_Insert ($currentProcessPosition;1;-><>aClientProcessName;-><>aClientProcessProgress;-><>aClientProcessStatus)
Else 
	$currentProcessPosition:=$pos
End if 
<>aClientProcessName{$currentProcessPosition}:=$processID
<>aClientProcessProgress{$currentProcessPosition}:=0
<>aClientProcessStatus{$currentProcessPosition}:=1
CLEAR SEMAPHORE:C144("ClientProcessArrays")
$0:=$currentProcessPosition

