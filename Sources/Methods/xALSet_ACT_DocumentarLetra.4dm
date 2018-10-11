//%attributes = {}
  //xALSet_ACT_DocumentarLetra

C_LONGINT:C283($Error)

AT_Inc (0)
$Error:=ALP_DefaultColSettings (xALP_DocumentarLC;AT_Inc ;"arACT_LCFolio";__ ("Folio");60;"#######0";0;0;1)
$Error:=ALP_DefaultColSettings (xALP_DocumentarLC;AT_Inc ;"atACT_LCRut";__ ("Rut");85;"###.###.###-#";0;0;0)
$Error:=ALP_DefaultColSettings (xALP_DocumentarLC;AT_Inc ;"atACT_LCAceptante";__ ("Aceptante");230;"";0;0;0)
$Error:=ALP_DefaultColSettings (xALP_DocumentarLC;AT_Inc ;"adACT_LCEmision";__ ("Fecha Emisión");100;"";0;0;0)
$Error:=ALP_DefaultColSettings (xALP_DocumentarLC;AT_Inc ;"adACT_LCVencimiento";__ ("Fecha Vencimiento");100;"";0;0;1)
$Error:=ALP_DefaultColSettings (xALP_DocumentarLC;AT_Inc ;"arACT_LCMonto";__ ("Monto");85;"|Despliegue_ACT";0;0;1)
$Error:=ALP_DefaultColSettings (xALP_DocumentarLC;AT_Inc ;"arACT_LCImpuesto";__ ("Impuesto");80;"|Despliegue_ACT";0;0;0)
$Error:=ALP_DefaultColSettings (xALP_DocumentarLC;AT_Inc ;"abACT_LCModificados";"")
$filter:="&"+ST_Qte ("0-9;"+<>tXS_RS_DecimalSeparator)
AL_SetFilter (xALP_DocumentarLC;6;$filter)

  //general options
ALP_SetDefaultAppareance (xALP_DocumentarLC;9;1;6;1;8)
AL_SetColOpts (xALP_DocumentarLC;0;1;1;1)
AL_SetRowOpts (xALP_DocumentarLC;0;1;0;0;1;0)
AL_SetCellOpts (xALP_DocumentarLC;0;1;1)
AL_SetMainCalls (xALP_DocumentarLC;"";"")
AL_SetCallbacks (xALP_DocumentarLC;"xALP_CBIN_ACT_DocumentarLC";"xALP_CB_ACT_DocumentarLC")
AL_SetScroll (xALP_DocumentarLC;0;-3)
AL_SetEntryOpts (xALP_DocumentarLC;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_DocumentarLC;0;30;0)