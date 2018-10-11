//%attributes = {}
  //STWA2_ActualConections

C_LONGINT:C283($0;$conectadosSTW)
While (Semaphore:C143("$sessionManagerAccess"))
	DELAY PROCESS:C323(Current process:C322;15)
End while 
SET QUERY DESTINATION:C396(Into variable:K19:4;$conectadosSTW)
QUERY:C277([STWA2_SessionManager:290];[STWA2_SessionManager:290]Activa:7=True:C214)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
$0:=$conectadosSTW
CLEAR SEMAPHORE:C144("$sessionManagerAccess")