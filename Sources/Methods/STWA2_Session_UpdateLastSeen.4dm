//%attributes = {}
C_TEXT:C284($1;$uuid)
C_BOOLEAN:C305($0)

$uuid:=$1

While (Semaphore:C143("$sessionManagerAccess"))
	DELAY PROCESS:C323(Current process:C322;2)
End while 
If (<>vbSTWA2_UseArrayBasedSessions)
	$sessionExists:=Find in array:C230(<>atSTWA2_Session_UUIDs;$uuid)
	If ($sessionExists#-1)
		<>alSTWA2_Session_LastSeen{$sessionExists}:=Current time:C178*1
		$0:=True:C214
	Else 
		$0:=False:C215
	End if 
Else 
	$sessionExists:=Find in field:C653([STWA2_SessionManager:290]Auto_UUID:1;$uuid)
	If ($sessionExists#-1)
		KRL_GotoRecord (->[STWA2_SessionManager:290];$sessionExists;True:C214)
		If ([STWA2_SessionManager:290]Activa:7)
			[STWA2_SessionManager:290]Last_Seen:4:=Current time:C178*1
			SAVE RECORD:C53([STWA2_SessionManager:290])
			KRL_UnloadReadOnly (->[STWA2_SessionManager:290])
			$0:=True:C214
		Else 
			$0:=False:C215
		End if 
	Else 
		$0:=False:C215
	End if 
End if 
CLEAR SEMAPHORE:C144("$sessionManagerAccess")