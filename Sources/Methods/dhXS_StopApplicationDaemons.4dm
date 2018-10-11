//%attributes = {}
  //dhXS_StopApplicationDaemons

C_LONGINT:C283(<>lSNT_CtrlProcessID)

<>stopDaemons:=True:C214
<>lSNT_CtrlProcessID:=Process number:C372("Conexión SchoolNet")
RESUME PROCESS:C320(<>lSNT_CtrlProcessID)
While (Process state:C330(<>lSNT_CtrlProcessID)>0)
	DELAY PROCESS:C323(<>lSNT_CtrlProcessID;15)
	  //CALL PROCESS(<>lSNT_CtrlProcessID)
End while 