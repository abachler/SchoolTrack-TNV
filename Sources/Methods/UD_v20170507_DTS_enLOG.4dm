//%attributes = {"executedOnServer":true}
  // Método: UD_v20170507_DTS_enLOG
  //
  // 
  // por Alberto Bachler Klein
  // creación 07/05/17, 10:39:45
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

MESSAGES ON:C181
READ WRITE:C146([xShell_Logs:37])
ALL RECORDS:C47([xShell_Logs:37])
APPLY TO SELECTION:C70([xShell_Logs:37];[xShell_Logs:37]DTS:12:=String:C10([xShell_Logs:37]Event_Date:3;ISO date:K1:8;[xShell_Logs:37]Event_Time:4))
UNLOAD RECORD:C212([xShell_Logs:37])
READ ONLY:C145([xShell_Logs:37])
MESSAGES OFF:C175

