//%attributes = {}
  //xALSet_ACT_ConfigImpuestoTimbre

C_LONGINT:C283($Error)

AT_Inc (0)
$Error:=ALP_DefaultColSettings (xALP_Impuesto;AT_Inc ;"alACT_AñoTasaImpuesto";__ ("Año");50;"###0";0;0;1)
$Error:=ALP_DefaultColSettings (xALP_Impuesto;AT_Inc ;"arACT_TasaMesImpuesto";__ ("Tasa \rMensual");70;"0,######";0;0;1)
$Error:=ALP_DefaultColSettings (xALP_Impuesto;AT_Inc ;"arACT_TasaMaximaImpuesto";__ ("Tasa \rMáxima");70;"0,######";0;0;1)

ALP_SetDefaultAppareance (xALP_Impuesto;9;1;6;2;8)
AL_SetColOpts (xALP_Impuesto;1;1;1;0;0)
AL_SetRowOpts (xALP_Impuesto;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Impuesto;0;1;1)
AL_SetMainCalls (xALP_Impuesto;"";"")
  //AL_SetCallbacks (xALP_Impuesto;"";"xALP_ACT_CB_Impuestos")
  //20110804 AS. no se necesita callbacks de salida.
AL_SetCallbacks (xALP_Impuesto;"";"")
AL_SetScroll (xALP_Impuesto;0;-3)
AL_SetEntryOpts (xALP_Impuesto;3;0;0;1;2;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Impuesto;0;30;0)