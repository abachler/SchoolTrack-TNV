//%attributes = {}
  //USR_SetModuleSemaphore

C_TEXT:C284($semaphore)
C_LONGINT:C283($1)

If (Count parameters:C259=1)
	$semaphore:="Module"+String:C10($1)
Else 
	$semaphore:="Module"+String:C10(<>vlXS_CurrentModuleRef)
End if 

If (Not:C34(Test semaphore:C652($semaphore)))
	$ignore:=Semaphore:C143($semaphore)
Else 
	CD_Dlog (0;__ ("Semaphore already set!!!"))
End if 