If (Record number:C243([BU_Rutas:26])#-3)
	READ WRITE:C146([BU_Rutas:26])
	QUERY:C277([BU_Rutas:26];[BU_Rutas:26]Patente_Bus:11;=;[Buses_escolares:57]Patente:1)
	$err:=Records in selection:C76([BU_Rutas:26])
	If ($err>0)
		FIRST RECORD:C50([BU_Rutas:26])
		While (Not:C34(End selection:C36([BU_Rutas:26])))
			[BU_Rutas:26]Cupo_Total:3:=[Buses_escolares:57]Capacidad:11
			SAVE RECORD:C53([BU_Rutas:26])
			NEXT RECORD:C51([BU_Rutas:26])
		End while 
	End if 
End if 