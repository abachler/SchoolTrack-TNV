$line:=AL_GetLine (ALP_AlumnosXPagar)
If ($line>0)
	ACTpgs_ArreglosCuentas ("BajarElemento")
	AL_UpdateArrays (ALP_AlumnosXPagar;0)
	ACTpgs_OrdenaCargosAviso ($line;True:C214)
	AL_UpdateArrays (ALP_AlumnosXPagar;-2)
End if 
AL_SetLine (ALP_AlumnosXPagar;$line+1)
ACTpgs_LimpiaVarsInterfaz ("SeteaFlechas3")