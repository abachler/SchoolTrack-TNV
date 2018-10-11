$row:=AL_GetLine (xALP_Observaciones)
If ($row>0)
	AL_UpdateArrays (xALP_Observaciones;0)
	AT_Delete ($row;1;->adFechaObservacion;->atTextoObservacion;->atUsuarioObservacion;->aiIDObservacion)
	AL_UpdateArrays (xALP_Observaciones;-2)
	AL_SetLine (xALP_Observaciones;0)
	_O_DISABLE BUTTON:C193(bDelObs)
End if 
