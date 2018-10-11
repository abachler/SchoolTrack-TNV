//%attributes = {}
  //ACT_CloseACT

C_LONGINT:C283($1;$ClientNum)
$ClientNum:=$1
FLUSH CACHE:C297
$ProcessNum:=Process number:C372("Explorador AccountTrack")
$ProcessState:=Process state:C330($ProcessNum)
$sem:=Semaphore:C143("ClosingACT"+String:C10($ClientNum))
If (($ProcessState#-1) & ($ProcessState#-100))
	$thermoID:=IT_UThermometer (1;0;__ ("Cerrando AccountTrack a petición del Administrador..."))
	BRING TO FRONT:C326($ProcessNum)
	POST KEY:C465(27;0;$ProcessNum)
	DELAY PROCESS:C323(Current process:C322;15)
	While (Find in array:C230(<>alXS_RegisteredProcessIDs;$ProcessNum)#-1)
		DELAY PROCESS:C323(Current process:C322;15)
	End while 
	CLEAR SEMAPHORE:C144("ClosingACT"+String:C10($ClientNum))
	IT_UThermometer (-2;$thermoID)
Else 
	CLEAR SEMAPHORE:C144("ClosingACT"+String:C10($ClientNum))
End if 