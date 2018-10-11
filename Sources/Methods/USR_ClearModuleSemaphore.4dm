//%attributes = {}
  //USR_ClearModuleSemaphore

C_TEXT:C284($semaphore)
C_LONGINT:C283($1)

If (Count parameters:C259=1)
	$semaphore:="Module"+String:C10($1)
Else 
	$semaphore:="Module"+String:C10(<>vlXS_CurrentModuleRef)
End if 
CLEAR SEMAPHORE:C144($semaphore)