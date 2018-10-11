If ((vtACT_ItemCargo#"") & (vtACT_RegimenCargo#""))
	AL_UpdateArrays (ALP_PCargos;0)
	ACTcfg_OpcionesPagares ("InsertaLineaALPCargos")
	AL_UpdateArrays (ALP_PCargos;-2)
End if 