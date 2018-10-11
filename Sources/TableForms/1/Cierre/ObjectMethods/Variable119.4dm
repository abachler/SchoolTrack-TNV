ARRAY TEXT:C222($aUsers;0)
ARRAY LONGINT:C221($aMethods;0)
GET REGISTERED CLIENTS:C650($aUsers;$aMethods)
If (Size of array:C274($aUsers)>1)
	$ignore:=CD_Dlog (0;__ ("El cierre del año escolar no puede ser ejecutado mientras otros usuarios estén conectados."))
Else 
	ACCEPT:C269
End if 