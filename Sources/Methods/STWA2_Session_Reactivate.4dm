//%attributes = {}
$uuid:=$1

While (Semaphore:C143("$sessionManagerAccess"))
	DELAY PROCESS:C323(Current process:C322;2)
End while 
$session:=Find in field:C653([STWA2_SessionManager:290]Auto_UUID:1;$uuid)
If (KRL_GotoRecord (->[STWA2_SessionManager:290];$session;True:C214))
	[STWA2_SessionManager:290]Activa:7:=True:C214
	SAVE RECORD:C53([STWA2_SessionManager:290])
	KRL_UnloadReadOnly (->[STWA2_SessionManager:290])
End if 
CLEAR SEMAPHORE:C144("$sessionManagerAccess")

$userID:=STWA2_Session_GetUserSTID ($uuid)
Log_RegisterEvtSTW ("Reactivación de sesión";$userID)

USR_RegisterUserEvent (UE_ModuleStart;0;"";"SchoolTrack Web Access";$userID)