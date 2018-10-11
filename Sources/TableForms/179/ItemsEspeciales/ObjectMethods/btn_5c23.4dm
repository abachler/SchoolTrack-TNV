WDW_OpenFormWindow (->[ACT_Cuentas_Contables:286];"CentrosCostoPorNivel";0;4;"Centros de costo")
DIALOG:C40([ACT_Cuentas_Contables:286];"CentrosCostoPorNivel")
CLOSE WINDOW:C154

If (ok=1)
	ACTitems_GuardaCCostoXNivel 
End if 