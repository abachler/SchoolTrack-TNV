AL_ExitCell (xALP_CtasEspeciales)

AL_UpdateArrays (xALP_CtasEspeciales;0)
  //AT_Insert (1;1;->atACT_CtasEspecialesGlosa;->asACT_CtasEspecialesCta;->asACT_CtasEspecialesCentro)
$vl_id:=Num:C11(ACTcfg_OpcionesContabilidad ("InsertaArreglosCuentasEspeciales"))

AL_UpdateArrays (xALP_CtasEspeciales;-2)

GOTO OBJECT:C206(xALP_CtasEspeciales)
  //AL_GotoCell (xALP_CtasEspeciales;1;1)
$vl_pos:=Find in array:C230(alACT_idCtaEspecial;$vl_id)
AL_GotoCell (xALP_CtasEspeciales;1;$vl_pos)

  //20121105 RCH
ACTcfg_OpcionesContabilidad ("PintaCtasEspeciales")
ACTcfg_OpcionesContabilidad ("SetEstadoBotonCtasEspeciales";->$vl_pos)