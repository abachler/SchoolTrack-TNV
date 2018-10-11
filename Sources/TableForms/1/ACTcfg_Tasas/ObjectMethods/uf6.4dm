$lineMoneda:=AL_GetLine (xALP_Divisas)
If ($lineMoneda>0)
	AL_UpdateArrays (xALP_UF;0)
	$vl_idMoneda:=alACT_IdRegistro{$lineMoneda}
	ACTcfgmyt_OpcionesGenerales ("CargaValoresTabla";->$vl_idMoneda)
	AL_UpdateArrays (xALP_UF;-2)
End if 