$line:=AL_GetLine (ALP_AvisosAgrupadosXPagar)
If ($line>0)
	ACTpgs_ArreglosAgrupado ("SubirElement")
End if 
AL_SetLine (ALP_AvisosAgrupadosXPagar;$line-1)
ACTpgs_SetObjectsCargosDocument 

ACTpgs_OrdenaCargosAviso (0;True:C214)
AL_UpdateArrays (ALP_AvisosAgrupadosXPagar;-2)
ACTpgs_LimpiaVarsInterfaz ("SeteaFlechas4")