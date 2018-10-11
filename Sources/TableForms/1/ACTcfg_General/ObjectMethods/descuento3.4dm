If ((vtACT_Item#"") & (vtACT_RegimenDcto#""))
	AL_UpdateArrays (ALP_Descuentos;0)
	ACTcfg_OpcionesPagares ("InsertaLineaALPDescuentos")
	AL_UpdateArrays (ALP_Descuentos;-2)
End if 