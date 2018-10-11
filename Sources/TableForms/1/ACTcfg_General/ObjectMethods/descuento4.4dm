$vl_line:=AL_GetLine (ALP_Descuentos)
If ($vl_line#0)
	AL_UpdateArrays (ALP_Descuentos;0)
	ACTcfg_OpcionesPagares ("EliminaLineaALPDescuentos";->$vl_line)
	AL_UpdateArrays (ALP_Descuentos;-2)
End if 