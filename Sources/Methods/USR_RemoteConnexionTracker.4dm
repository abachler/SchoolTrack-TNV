//%attributes = {}
  // Método: USR_RemoteConnexionTracker
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 03/09/10, 16:14:24
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BOOLEAN:C305(<>stopDaemons)

  // Código principal
While (Not:C34(<>stopDaemons))
	READ ONLY:C145(*)
	QUERY:C277([xShell_UserConnections:281];[xShell_UserConnections:281]IsAlive:14=True:C214)
	
	ARRAY LONGINT:C221($aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([xShell_UserConnections:281];$aRecNums;"")
	For ($i;1;Size of array:C274($aRecNums))
		ARRAY TEXT:C222($aConnexions;0)
		ARRAY TEXT:C222($aMethods;0)
		GET REGISTERED CLIENTS:C650($aConnexions;$methods)
		KRL_GotoRecord (->[xShell_UserConnections:281];$aRecNums{$i};True:C214)
		
		  //si la conexión esta en estado activa pero ya no está en la lista de conexiones en 4D server se registra como conexíón abortada
		If (Find in array:C230($aConnexions;[xShell_UserConnections:281]LastConnection_CNXname:12)<0)
			KRL_GotoRecord (->[xShell_UserConnections:281];$aRecNums{$i};True:C214)
			[xShell_UserConnections:281]IsAlive:14:=False:C215
			[xShell_UserConnections:281]Connections_History:11:=[xShell_UserConnections:281]Connections_History:11+";"+"Broken connexion detected at: "+DTS_MakeFromDateTime 
		End if 
		$loginDate:=DTS_GetDate ([xShell_UserConnections:281]LastConnection_DTS:5)
		$loginTime:=DTS_GetTime ([xShell_UserConnections:281]LastConnection_DTS:5)
		If ((Current time:C178(*)>$loginTime) & (Current date:C33(*)=$loginDate))
			$days:=0
			$timeOffset:=Current time:C178(*)-$loginTime
		Else 
			$days:=Current date:C33(*)-$loginDate-1
			If ($days>0)
				$timeOffset:=($days*24)+Current time:C178(*)*60*60
			Else 
				$timeOffset:=Current time:C178(*)
			End if 
		End if 
		[xShell_UserConnections:281]LastConnection_Duration:7:=$timeOffset
		[xShell_UserConnections:281]Connections_TotalTime:9:=[xShell_UserConnections:281]Connections_TotalTime:9+[xShell_UserConnections:281]LastConnection_Duration:7
		SAVE RECORD:C53([xShell_UserConnections:281])
		KRL_UnloadReadOnly (->[xShell_UserConnections:281])
	End for 
	DELAY PROCESS:C323(Current process:C322;60*60)
End while 