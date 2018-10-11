//%attributes = {}
  //dhBWR_OnBrowserLoad

Case of 
	: (vsBWR_CurrentModule="SchoolTrack")
		READ ONLY:C145([Asignaturas:18])
		QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=<>lUSR_RelatedTableUserID)
		If (<>bUSR_EsProfesorJefe)
			If (USR_checkRights ("L";->[Alumnos:2]))
				yBWR_currentTable:=->[Alumnos:2]
			End if 
		Else 
			If (Records in selection:C76([Asignaturas:18])#0)
				If (USR_checkRights ("L";->[Asignaturas:18]))
					yBWR_currentTable:=->[Asignaturas:18]
				End if 
			Else 
				If (USR_checkRights ("L";->[Alumnos:2]))
					yBWR_currentTable:=->[Alumnos:2]
				End if 
			End if 
		End if 
		vlBWR_SelectedTableRef:=Table:C252(yBWR_currentTable)
		SELECT LIST ITEMS BY REFERENCE:C630(vlXS_BrowserTab;vlBWR_SelectedTableRef)
		GET LIST ITEM:C378(vlXS_BrowserTab;Selected list items:C379(vlXS_BrowserTab);vlBWR_SelectedTableRef;vsBWR_selectedTableName)
		_O_REDRAW LIST:C382(vlXS_BrowserTab)
	: (vsBWR_CurrentModule="MediaTrack")
		
	: (vsBWR_CurrentModule="AccountTrack")
		
End case 