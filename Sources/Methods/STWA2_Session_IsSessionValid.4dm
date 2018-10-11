//%attributes = {}
$uuid:=$1

While (Semaphore:C143("$sessionManagerAccess"))
	DELAY PROCESS:C323(Current process:C322;2)
End while 
If (<>vbSTWA2_UseArrayBasedSessions)
	$exists:=Find in array:C230(<>atSTWA2_Session_UUIDs;$uuid)
	$0:=($exists#-1)
Else 
	$exists:=Find in field:C653([STWA2_SessionManager:290]Auto_UUID:1;$uuid)
	If ($exists#-1)
		If (KRL_GotoRecord (->[STWA2_SessionManager:290];$exists;False:C215))
			If ([STWA2_SessionManager:290]Persistente:5=False:C215)
				$0:=[STWA2_SessionManager:290]Activa:7
			Else 
				$0:=True:C214
			End if 
		Else 
			$0:=False:C215
		End if 
	Else 
		$0:=False:C215
	End if 
End if 
CLEAR SEMAPHORE:C144("$sessionManagerAccess")