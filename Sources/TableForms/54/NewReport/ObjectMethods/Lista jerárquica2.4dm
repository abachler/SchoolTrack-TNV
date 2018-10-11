C_LONGINT:C283(vl_TableNumber)
C_TEXT:C284($tableName)
If (vtQR_CurrentReportType="")
	OBJECT GET COORDINATES:C663(Self:C308->;$left;$top;$rigth;$bottom)
	API Create Tip ("Seleccione el tipo de informe que desea imprimir.";$left;$top;$rigth;$bottom)
Else 
	GET LIST ITEM:C378(hl_AvailableTables;*;vlQR_SelectedMainTableNumber;$tableName)
	If ((vlQR_SelectedMainTableNumber>0) & (vtQR_CurrentReportType#""))
		ACCEPT:C269
	End if 
End if 