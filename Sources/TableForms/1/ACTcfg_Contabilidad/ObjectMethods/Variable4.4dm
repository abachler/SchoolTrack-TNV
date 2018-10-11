AL_UpdateArrays (xALP_Centros;0)
  //AT_Insert (1;1;-><>asACT_Centro)
$vl_id:=Num:C11(ACTcfg_OpcionesContabilidad ("InsertaArreglosCentrosCosto"))

AL_UpdateArrays (xALP_Centros;-2)
  //20121105 RCH
  //AL_SetEnterable (xALP_CtasEspeciales;3;2;<>asACT_Centro)
GOTO OBJECT:C206(xALP_Centros)
  //AL_GotoCell (xALP_Centros;1;1)
$vl_pos:=Find in array:C230(<>alACT_idCentro;$vl_id)
AL_GotoCell (xALP_Centros;1;$vl_pos)