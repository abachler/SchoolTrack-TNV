IT_SetButtonState ((Self:C308->=1);->bModReport)
PREF_Set (0;"ConsolaAtrasosImprimirInforme";String:C10(cbImprimirReport))
If (cbImprimirReport=1)
	If (Size of array:C274(atSTR_Modelos)>0)
		atSTR_Modelos:=1
		vtSTR_ReportModel:=atSTR_Modelos{atSTR_Modelos}
		REDRAW WINDOW:C456
	End if 
Else 
	If (Size of array:C274(atSTR_Modelos)=0)
		vtSTR_ReportModel:="No hay modelos."
	Else 
		vtSTR_ReportModel:="No hay modelo seleccionado."
	End if 
	atSTR_Modelos:=0
	REDRAW WINDOW:C456
End if 