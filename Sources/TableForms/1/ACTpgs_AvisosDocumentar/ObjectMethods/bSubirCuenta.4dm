$line:=AL_GetLine (ALP_AlumnosXPagar)
If ($line>0)
	ACTpgs_ArreglosCuentas ("SubirElemento")
End if 
AL_SetLine (ALP_AlumnosXPagar;$line-1)
ACTpgs_SetObjectsCargosDocument 
ACTpgs_OrdenaCargosAviso (0;True:C214)
AL_UpdateArrays (ALP_AlumnosXPagar;-2)
ACTpgs_LimpiaVarsInterfaz ("SeteaFlechas3")