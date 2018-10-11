If (Self:C308->=1)
	If (INET_IntranetColegiumDisponible )
		OBJECT SET TITLE:C194(*;"reportData_estadoRepositorio";"")
		
	Else 
		Self:C308->:=0
		OBJECT SET TITLE:C194(*;"reportData_estadoRepositorio";"")
	End if 
End if 
IT_SetButtonState (Self:C308->=1;->bExample;->bUpdate)
PREF_Set (USR_GetUserID ;"LookForReportInRepository";String:C10(Self:C308->))