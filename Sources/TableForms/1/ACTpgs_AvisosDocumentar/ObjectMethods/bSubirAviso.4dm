$line:=AL_GetLine (ALP_AvisosXPagar)
If ($line>0)
	vbACT_ModOrderAvisos:=True:C214
	  //AL_UpdateArrays (ALP_AvisosXPagar;0)
	ACTpgs_ArreglosAvisos ("SubirAviso")
	AL_UpdateArrays (ALP_AvisosXPagar;-2)
	AL_SetLine (ALP_AvisosXPagar;$line-1)
End if 
ACTpgs_OrdenaCargosAviso (0;True:C214)
ACTpgs_LimpiaVarsInterfaz ("SeteaFlechas1")