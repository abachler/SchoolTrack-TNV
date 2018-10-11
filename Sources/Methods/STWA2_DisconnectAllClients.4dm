//%attributes = {}
  //STWA2_DisconnectAllClients

ARRAY TEXT:C222($atSTWA2_SessionUUID;0)
C_LONGINT:C283($l_rn;$i)

READ ONLY:C145([STWA2_SessionManager:290])
QUERY:C277([STWA2_SessionManager:290];[STWA2_SessionManager:290]Activa:7=True:C214)

SELECTION TO ARRAY:C260([STWA2_SessionManager:290]Auto_UUID:1;$atSTWA2_SessionUUID)

For ($i;1;Size of array:C274($atSTWA2_SessionUUID))
	$l_rn:=Find in field:C653([STWA2_SessionManager:290]Auto_UUID:1;$atSTWA2_SessionUUID{$i})
	If ($l_rn#-1)
		STWA2_Session_UnsetSession ($atSTWA2_SessionUUID{$i})
	End if 
End for 