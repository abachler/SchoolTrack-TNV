If ((c_RecAutFijo=1) & (vlACTcfg_SelectedItemAut#0))
	WDW_OpenPopupWindow (Self:C308;->[xxSTR_Constants:1];"ACTcfggen_RecargoMulta";2)
	DIALOG:C40([xxSTR_Constants:1];"ACTcfggen_RecargoMulta")
	CLOSE WINDOW:C154
Else 
	BEEP:C151
End if 