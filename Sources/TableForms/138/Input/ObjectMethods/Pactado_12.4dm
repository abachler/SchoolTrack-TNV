C_LONGINT:C283($vl_return)
$vl_return:=ACTter_fSave 

If ($vl_return#-1)
	WDW_OpenFormWindow (->[ACT_Terceros_Pactado:139];"ACT_StudSelection";9;4;__ ("Selección de cuentas");"wdw_CloseDlog")
	DIALOG:C40([ACT_Terceros_Pactado:139];"ACT_StudSelection")
	CLOSE WINDOW:C154
	ACTter_PagePactado 
End if 
ACTter_SetObjects 