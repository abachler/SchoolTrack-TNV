//%attributes = {}
  //MNU_showlog

If (USR_IsGroupMember_by_GrpID (-15001))
	$logPNum:=Process number:C372("log")
	If (Process state:C330($logPNum)>=0)
		RESUME PROCESS:C320($logPNum)
		SHOW PROCESS:C325($logPNum)
		BRING TO FRONT:C326($logPNum)
	Else 
		<>lXS_LogWindowProcessID:=New process:C317("LOG_ShowLogWindow";Pila_256K;"Log")
	End if 
Else 
	CD_Dlog (0;__ ("Sólo los usuarios del grupo administración pueden acceder al registro de actividades."))
End if 