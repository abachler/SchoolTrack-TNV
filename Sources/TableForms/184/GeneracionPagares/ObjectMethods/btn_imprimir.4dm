If ((cs_imprimirPagareC=1) | (cs_genContratoC=1))
	If (cs_imprimirPagareC=1)
		If (Records in selection:C76([ACT_Pagares:184])=1)
			ACTcfg_OpcionesPagares ("Print";->vtACTp_ModPagare)
		Else 
			BEEP:C151
		End if 
	End if 
	If (cs_genContratoC=1)
		ACTcfg_OpcionesPagares ("Print";->vtACTp_ModContrato)
	End if 
Else 
	BEEP:C151
End if 