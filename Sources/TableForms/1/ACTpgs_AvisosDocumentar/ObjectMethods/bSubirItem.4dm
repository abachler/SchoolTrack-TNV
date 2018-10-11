$line:=AL_GetLine (ALP_ItemsXPagar)
If ($line>0)
	ACTpgs_ArreglosItems ("SubirElemento")
End if 
AL_SetLine (ALP_ItemsXPagar;$line-1)
ACTpgs_SetObjectsCargosDocument 
ACTpgs_OrdenaCargosAviso (0;True:C214)
AL_UpdateArrays (ALP_ItemsXPagar;-2)
ACTpgs_LimpiaVarsInterfaz ("SeteaFlechas2")