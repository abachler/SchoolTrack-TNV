$line:=AL_GetLine (xALP_CtasEspeciales)
If ($line#0)
	AL_UpdateArrays (xALP_CtasEspeciales;0)
	  //AT_Delete ($line;1;->atACT_CtasEspecialesGlosa;->asACT_CtasEspecialesCta;->asACT_CtasEspecialesCentro)
	ACTcfg_OpcionesContabilidad ("EliminaArreglosCuentasEspeciales";->alACT_idCtaEspecial{$line})
	AL_UpdateArrays (xALP_CtasEspeciales;-2)
	
	  //20121105 RCH
	  //IT_SetButtonState ((Size of array(atACT_CtasEspecialesGlosa)>0);Self)
	$line:=AL_GetLine (xALP_CtasEspeciales)
	$line:=1  // en pruebas siempre es 1
	ACTcfg_OpcionesContabilidad ("SetEstadoBotonCtasEspeciales";->$line)
	
	ACTcfg_OpcionesContabilidad ("PintaCtasEspeciales")
	
	
End if 