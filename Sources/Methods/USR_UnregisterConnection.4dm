//%attributes = {}
  // Método: USR_UnregisterConnection
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 03/09/10, 18:16:52
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_LONGINT:C283($userID;$1)
C_TEXT:C284($login;$2)
$userID:=$1
$login:=$2

  // Código principal

If ($userID>0)
	READ WRITE:C146([xShell_UserConnections:281])
	QUERY:C277([xShell_UserConnections:281];[xShell_UserConnections:281]UserID:1;=;$userID;*)
	QUERY:C277([xShell_UserConnections:281]; & ;[xShell_UserConnections:281]Login:2=$login)
	
	QUERY SELECTION:C341([xShell_UserConnections:281];[xShell_UserConnections:281]IsAlive:14=True:C214)
	TRACE:C157
	Case of 
		: (Records in selection:C76([xShell_UserConnections:281])=0)
			
		: (Records in selection:C76([xShell_UserConnections:281])=1)
			[xShell_UserConnections:281]IsAlive:14:=False:C215
			$loginDate:=DTS_GetDate ([xShell_UserConnections:281]LastConnection_DTS:5)
			$loginTime:=DTS_GetTime ([xShell_UserConnections:281]LastConnection_DTS:5)
			If (Current time:C178(*)>$loginTime)
				$days:=Current date:C33(*)-$loginDate
				$timeOffset:=Current time:C178(*)-$loginTime
			Else 
				$days:=Current date:C33(*)-$loginDate-1
				$timeOffset:=Current time:C178(*)
			End if 
			[xShell_UserConnections:281]LastConnection_Duration:7:=($days*24*60*60)+$timeOffset
			[xShell_UserConnections:281]Connections_TotalTime:9:=[xShell_UserConnections:281]Connections_TotalTime:9+[xShell_UserConnections:281]LastConnection_Duration:7
			[xShell_UserConnections:281]Connections_History:11:=[xShell_UserConnections:281]Connections_History:11+";"+DTS_MakeFromDateTime 
			SAVE RECORD:C53([xShell_UserConnections:281])
			KRL_UnloadReadOnly (->[xShell_UserConnections:281])
			
		: (Records in selection:C76([xShell_UserConnections:281])>1)
			TRACE:C157
			
	End case 
End if 
