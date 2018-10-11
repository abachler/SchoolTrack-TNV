//%attributes = {}
  //xALSet_CC_ACT_AreaTerceros

C_LONGINT:C283($Error)
AT_Inc (0)
$error:=ALP_DefaultColSettings (xAL_ACTter_TercerosAsociados;AT_Inc ;"atACT_TerceroNombre";__ ("Nombre");200;"";0;0;0)
$error:=ALP_DefaultColSettings (xAL_ACTter_TercerosAsociados;AT_Inc ;"atACT_TerceroTipo";__ ("Tipo");90;"";0;0;0)
$error:=ALP_DefaultColSettings (xAL_ACTter_TercerosAsociados;AT_Inc ;"atACT_TerceroRUT";__ ("RUT");68;"";0;0;0)
$error:=ALP_DefaultColSettings (xAL_ACTter_TercerosAsociados;AT_Inc ;"alACT_TerceroRecNum";"RecNum";75;"";0;0;0)
ALP_SetDefaultAppareance (xAL_ACTter_TercerosAsociados;9;1;2;1;8)
AL_SetColOpts (xAL_ACTter_TercerosAsociados;0;1;0;1;0)
AL_SetRowOpts (xAL_ACTter_TercerosAsociados;1;1;0;0;1;0)
AL_SetScroll (xAL_ACTter_TercerosAsociados;0;-3)
  //AL_SetCellOpts (xAL_ACTter_TercerosAsociados;0;1;1)
  //AL_SetMainCalls (xAL_ACTter_TercerosAsociados;"";"")
  //AL_SetCallbacks (xAL_ACTter_TercerosAsociados;"";"")
  //AL_SetEntryOpts (xAL_ACTter_TercerosAsociados;3;0;0;0;0;<>tXS_RS_DecimalSeparator)
  //AL_SetDrgOpts (xAL_ACTter_TercerosAsociados;0;30;0)