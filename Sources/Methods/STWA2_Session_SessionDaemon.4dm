//%attributes = {}
C_REAL:C285($l_Timeout)

If (<>vbSTWA2_UseArrayBasedSessions)
	While (Not:C34(<>stopDaemons))
		While (Semaphore:C143("$sessionManagerAccess"))
			DELAY PROCESS:C323(Current process:C322;2)
		End while 
		If (Size of array:C274(<>atSTWA2_Session_UUIDs)>0)
			For ($i;1;Size of array:C274(<>atSTWA2_Session_UUIDs))
				$l_UsuarioID:=<>alSTWA2_Session_UserID{$i}
				$l_Timeout:=STWA2_ManejaTiempoDeSesion ("cargaVariableTimeout";$l_UsuarioID)
				If ((Current time:C178-<>alSTWA2_Session_LastSeen{$i})>$l_Timeout)
					DELETE FROM ARRAY:C228(<>atSTWA2_Session_UUIDs;$i;1)
					DELETE FROM ARRAY:C228(<>alSTWA2_Session_UserID;$i;1)
					DELETE FROM ARRAY:C228(<>alSTWA2_Session_LastSeen;$i;1)
				End if 
			End for 
		End if 
		CLEAR SEMAPHORE:C144("$sessionManagerAccess")
		DELAY PROCESS:C323(Current process:C322;60*<>vlSTWA_SessionDaemonCycle)
	End while 
Else 
	While (Not:C34(<>stopDaemons))
		While (Semaphore:C143("$sessionManagerAccess"))
			DELAY PROCESS:C323(Current process:C322;2)
		End while 
		$currTime:=Current time:C178*1
		READ WRITE:C146([STWA2_SessionManager:290])
		
		QUERY:C277([STWA2_SessionManager:290];[STWA2_SessionManager:290]Persistente:5=False:C215)
		SELECTION TO ARRAY:C260([STWA2_SessionManager:290];$al_recNumSession)
		
		For ($l_indice;1;Size of array:C274($al_recNumSession))
			GOTO RECORD:C242([STWA2_SessionManager:290];$al_recNumSession{$l_indice})
			$l_UsuarioID:=[STWA2_SessionManager:290]User_ID:2
			$l_Timeout:=STWA2_ManejaTiempoDeSesion ("cargaVariableTimeout";$l_UsuarioID)
			$l_lastSeen:=STWA2_Session_CalcRemaining ($currTime;[STWA2_SessionManager:290]Last_Seen:4)
			If ($l_lastSeen>$l_Timeout)
				Log_RegisterEvtSTW ("Cierre de sesión por timeout";[STWA2_SessionManager:290]User_ID:2)
				DELETE RECORD:C58([STWA2_SessionManager:290])
			End if 
			
		End for 
		
		QUERY:C277([STWA2_SessionManager:290];[STWA2_SessionManager:290]Activa:7=True:C214;*)
		QUERY:C277([STWA2_SessionManager:290]; & ;[STWA2_SessionManager:290]Persistente:5=True:C214)
		SELECTION TO ARRAY:C260([STWA2_SessionManager:290];$al_recNumSession)
		
		For ($l_indice;1;Size of array:C274($al_recNumSession))
			GOTO RECORD:C242([STWA2_SessionManager:290];$al_recNumSession{$l_indice})
			$l_Timeout:=STWA2_ManejaTiempoDeSesion ("cargaVariableTimeout";[STWA2_SessionManager:290]User_ID:2)
			$l_lastSeen:=STWA2_Session_CalcRemaining ($currTime;[STWA2_SessionManager:290]Last_Seen:4)
			If ($l_lastSeen>$l_Timeout)
				[STWA2_SessionManager:290]Activa:7:=False:C215
				Log_RegisterEvtSTW ("Cierre de sesión por timeout";[STWA2_SessionManager:290]User_ID:2)
				SAVE RECORD:C53([STWA2_SessionManager:290])
			End if 
			
		End for 
		
		KRL_UnloadReadOnly (->[STWA2_SessionManager:290])
		CLEAR SEMAPHORE:C144("$sessionManagerAccess")
		
		  //buscar change pass requests vencidos y eliminarlos...
		QUERY:C277([xShell_Users:47];[xShell_Users:47]passRegenerationCode:23#"")
		ARRAY LONGINT:C221($rns;0)
		LONGINT ARRAY FROM SELECTION:C647([xShell_Users:47];$rns;"")
		For ($i;1;Size of array:C274($rns))
			KRL_GotoRecord (->[xShell_Users:47];$rns{$i};False:C215)
			$expiration_ts:=ST_RigthChars ([xShell_Users:47]passRegenerationCode:23;14)
			$ts:=DTS_MakeFromDateTime 
			If ($expiration_ts<$ts)
				KRL_ReloadInReadWriteMode (->[xShell_Users:47])
				[xShell_Users:47]passRegenerationCode:23:=""
				SAVE RECORD:C53([xShell_Users:47])
			End if 
		End for 
		KRL_UnloadReadOnly (->[xShell_Users:47])
		DELAY PROCESS:C323(Current process:C322;60*<>vlSTWA_SessionDaemonCycle)
	End while 
End if 