

$l_FilaSeleccionada:=AL_GetLine (xALP_Fields)
If ($l_FilaSeleccionada=0)
	CD_Dlog (0;__ ("Seleccione primero el campo por favor."))
Else 
	XSvs_ActualizaLocalizacionCampo (alXS_Fields_RecNums{$l_FilaSeleccionada})
End if 