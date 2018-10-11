AL_ExitCell (xALP_ActividadesExtra)
If (atSTR_Periodos_Nombre>0)
	If (modXcR)
		XCR_SaveEval 
		modXCR:=False:C215
	End if 
	vl_PeriodoSeleccionadoActividad:=atSTR_Periodos_Nombre
	XCR_LoadEval 
End if 