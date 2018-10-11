//%attributes = {}
  //STRcal_CreaSesionesClases

$Date:=$1
$semaphore:=Semaphore:C143("CambioStatus"+String:C10($date))
AS_CreaSesiones ($date)
CLEAR SEMAPHORE:C144("CambioStatus"+String:C10($date))