C_LONGINT:C283(vForma)
vForma:=0
WDW_OpenDialogInDrawer (->[ACT_Pagos:172];"FormadePago")
If (vForma#0)
	ACTpgs_IngresarPagosVR (vForma)
End if 