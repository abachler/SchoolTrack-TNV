AL_UpdateArrays (ALP_CargosXPagar;0)
AL_UpdateArrays (ALP_CargosXPagarO;0)
ACTcfg_OpcionesImportCargos ("OrdenaCargos")
AL_UpdateArrays (ALP_CargosXPagarO;-2)
AL_UpdateArrays (ALP_CargosXPagar;-2)

line:=AL_GetLine (ALP_CargosXPagar)
AL_SetLine (ALP_CargosXPagar;line-1)
line:=AL_GetLine (ALP_CargosXPagar)

If ((line=0) | (line=1))
	_O_DISABLE BUTTON:C193(bSubir)
Else 
	_O_ENABLE BUTTON:C192(bSubir)
End if 

If ((line=0) | (line=Size of array:C274(al_idItems)))
	_O_DISABLE BUTTON:C193(bBajar)
Else 
	_O_ENABLE BUTTON:C192(bBajar)
End if 

line:=AL_GetLine (ALP_CargosXPagarO)
AL_SetLine (ALP_CargosXPagarO;line-1)
line:=AL_GetLine (ALP_CargosXPagarO)

If ((line=0) | (line=1))
	_O_DISABLE BUTTON:C193(bSubir2)
Else 
	_O_ENABLE BUTTON:C192(bSubir2)
End if 

If ((line=0) | (line=Size of array:C274(al_refItemsT)))
	_O_DISABLE BUTTON:C193(bBajar2)
Else 
	_O_ENABLE BUTTON:C192(bBajar2)
End if 