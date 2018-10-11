$vl_line:=AL_GetLine (ALP_PCargos)
If ($vl_line#0)
	AL_UpdateArrays (ALP_PCargos;0)
	ACTcfg_OpcionesPagares ("EliminaLineaALPCargos";->$vl_line)
	AL_UpdateArrays (ALP_PCargos;-2)
End if 