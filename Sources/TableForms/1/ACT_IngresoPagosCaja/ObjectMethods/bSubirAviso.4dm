$line:=AL_GetLine (ALP_AvisosXPagar)
If ($line>0)
	vbACT_ModOrderAvisos:=True:C214
	ACTpgs_ArreglosAvisos ("SubirAviso")
	AL_UpdateArrays (ALP_AvisosXPagar;-2)
	AL_SetLine (ALP_AvisosXPagar;$line-1)
	ACTpgs_OrdenaCargosAviso ($line;True:C214)
	ACTpgs_LimpiaVarsInterfaz ("SeteaFlechas1")
End if 