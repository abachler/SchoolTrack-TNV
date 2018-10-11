//%attributes = {}
  // STWA2_Session_MaxSessions

$0:=0
If ((Application type:C494=4D Server:K5:6) | (Application type:C494=4D Remote mode:K5:5))
	READ ONLY:C145([xShell_ApplicationData:45])
	ALL RECORDS:C47([xShell_ApplicationData:45])
	FIRST RECORD:C50([xShell_ApplicationData:45])
	If ([xShell_ApplicationData:45]Licenced_Users_STWA:32=0)
		If (LICENCIA_esModuloAutorizado (1;SchoolTrack Web Access))
			$0:=[xShell_ApplicationData:45]Licenced_Users:11
		End if 
	Else 
		$0:=[xShell_ApplicationData:45]Licenced_Users_STWA:32
	End if 
	UNLOAD RECORD:C212([xShell_ApplicationData:45])
Else 
	$0:=1
End if 