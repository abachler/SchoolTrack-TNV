//%attributes = {}
C_TEXT:C284($uuid;$1)
C_LONGINT:C283($0;$sessionElement)

$uuid:=$1

If (<>vbSTWA2_UseArrayBasedSessions)
	$sessionElement:=Find in array:C230(<>atSTWA2_Session_UUIDs;$uuid)
	If ($sessionElement#-1)
		$0:=<>alSTWA2_Session_UserID{$sessionElement}
	Else 
		$0:=0
	End if 
Else 
	$0:=KRL_GetNumericFieldData (->[STWA2_SessionManager:290]Auto_UUID:1;->$uuid;->[STWA2_SessionManager:290]User_ID:2)
End if 