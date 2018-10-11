If (Size of array:C274(alACT_idAviso)>0)
	READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
	READ ONLY:C145([Personas:7])
	
	QUERY WITH ARRAY:C644([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;alACT_idAviso)
	KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;"")
	
	If (Records in selection:C76([Personas:7])>0)
		$newTable:=->[Personas:7]
		AL_RemoveArrays (xALP_Browser;1;30)
		yBWR_currentTable:=$newTable
		CREATE SET:C116(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
		SELECT LIST ITEMS BY REFERENCE:C630(vlXS_BrowserTab;Table:C252($newTable))
		$tab:=Selected list items:C379(vlXS_BrowserTab)
		GET LIST ITEM:C378(vlXS_BrowserTab;$tab;vlBWR_SelectedTableRef;vsBWR_selectedTableName)
		BWR_PanelSettings 
		BWR_SelectTableData 
		XS_SetInterface 
		ALP_SetInterface (xALP_Browser)
		_O_REDRAW LIST:C382(vlXS_BrowserTab)
		
		ACCEPT:C269
	Else 
		CD_Dlog (0;"No hay Apoderados asociados a la referencia: "+ST_Qte (vtACT_referencia)+".")
	End if 
End if 