//%attributes = {}
  //xALP_ACT_Set_DesctoHijos

C_LONGINT:C283($Error)

$Error:=ALP_DefaultColSettings (xALP_DesctosHijos;1;"atACT_HijoNumero";"";75)
$Error:=ALP_DefaultColSettings (xALP_DesctosHijos;2;"arACT_DesctoPorHijo";"";75;"|Pct_4DecIfNec";0;0;1)

  //general options
ALP_SetDefaultAppareance (xALP_DesctosHijos;9;1;6;1;8)
AL_SetColOpts (xALP_DesctosHijos;1;1;1;0;0)
AL_SetRowOpts (xALP_DesctosHijos;0;1;0;0;1;1)
AL_SetCellOpts (xALP_DesctosHijos;0;1;1)
AL_SetMiscOpts (xALP_DesctosHijos;1;0;"\\";0;1)
AL_SetCallbacks (xALP_DesctosHijos;"";"xALCB_EX_cfgModBlobItemsHijos")
AL_SetMainCalls (xALP_DesctosHijos;"";"")
AL_SetScroll (xALP_DesctosHijos;0;0)
AL_SetEntryOpts (xALP_DesctosHijos;2;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_DesctosHijos;0;30;0)