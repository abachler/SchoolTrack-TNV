//%attributes = {}
If (USR_GetMethodAcces (Current method name:C684))
	WDW_OpenFormWindow (->[BBL_Prestamos:60];"transferencia_de_prestamos";0;4;__ ("Baja Masiva de Volúmenes"))
	DIALOG:C40([BBL_Prestamos:60];"transferencia_de_prestamos")
	CLOSE WINDOW:C154
End if 