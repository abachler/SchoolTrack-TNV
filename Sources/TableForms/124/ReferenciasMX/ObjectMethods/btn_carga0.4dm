If (Size of array:C274(alACT_idAviso)>0)
	READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
	READ ONLY:C145([ACT_Documentos_de_Cargo:174])
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	
	QUERY WITH ARRAY:C644([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;alACT_idAviso)
	KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
	KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6;"")
	
	If (Records in selection:C76([ACT_CuentasCorrientes:175])>0)
		$newTable:=->[ACT_CuentasCorrientes:175]
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
		CD_Dlog (0;"No hay Cuentas Corrientes asociadas a la referencia: "+ST_Qte (vtACT_referencia)+".")
	End if 
End if 