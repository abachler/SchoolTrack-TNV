//%attributes = {}
  //CLSV_ClearClientProcess

While (Semaphore:C143("ClientProcessArrays"))
	DELAY PROCESS:C323(Current process:C322;5)
End while 
If ($2#0)
	<>aClientProcessStatus{$1}:=-1
Else 
	<>aClientProcessStatus{$1}:=0
	<>aClientProcessName{$1}:=""
	<>aClientProcessStatus{$1}:=0
End if 
CLEAR SEMAPHORE:C144("ClientProcessArrays")
