Case of 
	: (Form event:C388=On Load:K2:1)
		ACTdte_setPruebasOpcionesGen ("CargaListado")
		ACTdte_setPruebasOpcionesGen ("InitVars")
		
		AT_Inc (0)
		
		C_LONGINT:C283(vlACTdte_MesIEV;vlACTdte_MesIEC;vlACTdte_YearIEV;vlACTdte_YearIEC)
		C_TEXT:C284(vtACTdte_MesIEV;vtACTdte_MesIEC)
		
		vlACTdte_MesIEV:=Month of:C24(Current date:C33(*))
		vtACTdte_MesIEV:=<>atXS_MonthNames{vlACTdte_MesIEV}
		
		vlACTdte_MesIEC:=Month of:C24(Current date:C33(*))
		vtACTdte_MesIEC:=<>atXS_MonthNames{vlACTdte_MesIEC}
		
		vlACTdte_YearIEV:=Year of:C25(Current date:C33(*))
		vlACTdte_YearIEC:=Year of:C25(Current date:C33(*))
		
		$b_valor:=False:C215
		AT_Populate (->lb_listadoSet;->$b_valor)
		
End case 