//%attributes = {}
C_LONGINT:C283($1;$userID)

$userID:=$1

While (Semaphore:C143("$sessionManagerAccess"))
	DELAY PROCESS:C323(Current process:C322;2)
End while 
READ WRITE:C146([STWA2_SessionManager:290])
QUERY:C277([STWA2_SessionManager:290];[STWA2_SessionManager:290]User_ID:2=$userID;*)
QUERY:C277([STWA2_SessionManager:290]; & ;[STWA2_SessionManager:290]Persistente:5=True:C214)
APPLY TO SELECTION:C70([STWA2_SessionManager:290];[STWA2_SessionManager:290]Activa:7:=False:C215)
QUERY:C277([STWA2_SessionManager:290];[STWA2_SessionManager:290]User_ID:2=$userID;*)
QUERY:C277([STWA2_SessionManager:290]; & ;[STWA2_SessionManager:290]Activa:7=True:C214)
DELETE SELECTION:C66([STWA2_SessionManager:290])
KRL_UnloadReadOnly (->[STWA2_SessionManager:290])
CLEAR SEMAPHORE:C144("$sessionManagerAccess")