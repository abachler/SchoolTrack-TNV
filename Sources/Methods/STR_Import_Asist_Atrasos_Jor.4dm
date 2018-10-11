//%attributes = {}
If (USR_GetMethodAcces (Current method name:C684))
	WDW_OpenFormWindow (->[Alumnos_Inasistencias:10];"STR_Importador_Asist_Atrasos";0;4;__ ("Importador de Inasistencias y Atrasos"))
	DIALOG:C40([Alumnos_Inasistencias:10];"STR_Importador_Asist_Atrasos")
	CLOSE WINDOW:C154
End if 