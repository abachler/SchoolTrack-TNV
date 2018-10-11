//%attributes = {}
  //xALSet_ACT_ItemsPagos

C_LONGINT:C283($Error)

AT_Inc (0)
$Error:=ALP_DefaultColSettings (ALP_ItemsXPagar;AT_Inc ;"apACT_ASelectedItem";__ ("Pagar/No Pagar");100;"1")
$Error:=ALP_DefaultColSettings (ALP_ItemsXPagar;AT_Inc ;"alACT_RefItem";__ ("Id Ítem");55;"######";2)
$Error:=ALP_DefaultColSettings (ALP_ItemsXPagar;AT_Inc ;"atACT_GlosaItem";__ ("Glosa del Ítem");350)
$Error:=ALP_DefaultColSettings (ALP_ItemsXPagar;AT_Inc ;"arACT_MontoXItem";__ ("Monto del Ítem");120;"|Despliegue_ACT_Pagos")
$Error:=ALP_DefaultColSettings (ALP_ItemsXPagar;AT_Inc ;"arACT_AMontoSeleccionadoXI";__ ("Monto(s) Seleccionado(s)");120;"|Despliegue_ACT_Pagos")
$Error:=ALP_DefaultColSettings (ALP_ItemsXPagar;AT_Inc ;"abACT_ASelectedItem";"")

  //general options
ALP_SetDefaultAppareance (ALP_ItemsXPagar;9;1;6;2;8)
AL_SetColOpts (ALP_ItemsXPagar;1;1;1;1;0)
AL_SetRowOpts (ALP_ItemsXPagar;0;1;0;0;1;0)
AL_SetCellOpts (ALP_ItemsXPagar;0;1;1)
AL_SetMainCalls (ALP_ItemsXPagar;"";"")
AL_SetScroll (ALP_ItemsXPagar;0;-3)
AL_SetEntryOpts (ALP_ItemsXPagar;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (ALP_ItemsXPagar;0;30;0)