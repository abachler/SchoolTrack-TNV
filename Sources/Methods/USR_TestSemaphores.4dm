//%attributes = {}
  //USR_TestSemaphores

$0:=False:C215
$Semtobetested:="Module"+String:C10(vlBWR_CurrentModuleRef)
$0:=Test semaphore:C652($Semtobetested)