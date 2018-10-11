
vtQR_CurrentReportType:="4DWR"

$selected:=Selected list items:C379(hl_AvailableTables)
If ($selected>Count list items:C380(hl_AvailableTables))
	OBJECT GET COORDINATES:C663(Self:C308->;$left;$top;$rigth;$bottom)
	API Create Tip ("Seleccione la tabla principal para el el informe.";$left;$top;$rigth;$bottom)
Else 
	ACCEPT:C269
End if 