//%attributes = {}
C_TEXT:C284($1;$uuid)

$uuid:=$1
$userID:=STWA2_Session_GetUserSTID ($uuid)
While (Semaphore:C143("$sessionManagerAccess"))
	DELAY PROCESS:C323(Current process:C322;2)
End while 
If (<>vbSTWA2_UseArrayBasedSessions)
	$sessionExists:=Find in array:C230(<>atSTWA2_Session_UUIDs;$uuid)
	If ($sessionExists#-1)
		AT_Delete ($sessionExists;1;-><>atSTWA2_Session_UUIDs;-><>alSTWA2_Session_UserID;-><>alSTWA2_Session_ProfID;-><>alSTWA2_Session_LastSeen)
	End if 
Else 
	$rn:=Find in field:C653([STWA2_SessionManager:290]Auto_UUID:1;$uuid)
	If (KRL_GotoRecord (->[STWA2_SessionManager:290];$rn;True:C214))
		KRL_DeleteRecord (->[STWA2_SessionManager:290];$rn)
	End if 
End if 
CLEAR SEMAPHORE:C144("$sessionManagerAccess")

Log_RegisterEvtSTW ("Cierre de sesión";$userID)