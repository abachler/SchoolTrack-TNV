//%attributes = {}
  //SR_SetPublic

If ((<>lUSR_CurrentUserID=[xShell_Reports:54]Propietary:9) | (<>lUSR_CurrentUserID<0))
	READ WRITE:C146([xShell_Reports:54])
	LOAD RECORD:C52([xShell_Reports:54])
	[xShell_Reports:54]Public:8:=True:C214
	SAVE RECORD:C53([xShell_Reports:54])
	UNLOAD RECORD:C212([xShell_Reports:54])
End if 