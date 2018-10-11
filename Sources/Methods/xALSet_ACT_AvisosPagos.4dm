//%attributes = {}
  //xALSet_ACT_AvisosPagos

C_LONGINT:C283($Error)
  //20120724 RCH Lee var pagares
ACTcfg_OpcionesPagares ("LeeConfiguracion")

AT_Inc (0)
$Error:=ALP_DefaultColSettings (ALP_AvisosXPagar;AT_Inc ;"apACT_ASelectedAvisos";"";20;"1")
$Error:=ALP_DefaultColSettings (ALP_AvisosXPagar;AT_Inc ;"alACT_AIDAviso";__ ("Número\rAviso");60;"######")
  //$Error:=ALP_DefaultColSettings (ALP_AvisosXPagar;AT_Inc ;"adACT_AFechaEmision";__ ("Fecha\rde Emisión");64)
  //$Error:=ALP_DefaultColSettings (ALP_AvisosXPagar;AT_Inc ;"adACT_AFechaVencimiento";__ ("Fecha\rde Vencimiento");111)
If (cs_genPagare=0)
	$Error:=ALP_DefaultColSettings (ALP_AvisosXPagar;AT_Inc ;"adACT_AFechaEmision";__ ("Fecha\rde Emisión");91)
	$Error:=ALP_DefaultColSettings (ALP_AvisosXPagar;AT_Inc ;"adACT_AFechaVencimiento";__ ("Fecha\rde Vencimiento");92)
Else 
	$Error:=ALP_DefaultColSettings (ALP_AvisosXPagar;AT_Inc ;"adACT_AFechaEmision";__ ("Fecha\r Emisón");66)
	$Error:=ALP_DefaultColSettings (ALP_AvisosXPagar;AT_Inc ;"adACT_AFechaVencimiento";__ ("Fecha\rVencimiento");66)
	$Error:=ALP_DefaultColSettings (ALP_AvisosXPagar;AT_Inc ;"alACT_ANoPagare";__ ("Número\rPagaré");51)
End if 
$Error:=ALP_DefaultColSettings (ALP_AvisosXPagar;AT_Inc ;"arACT_ASaldoAnterior";__ ("Saldo\rAnterior");80;"|Despliegue_ACT")
$Error:=ALP_DefaultColSettings (ALP_AvisosXPagar;AT_Inc ;"arACT_AIntereses";__ ("Intereses");62;"|Despliegue_ACT_Pagos")
$Error:=ALP_DefaultColSettings (ALP_AvisosXPagar;AT_Inc ;"arACT_AMontoaPagar";__ ("Monto\rMoneda");80;"|Despliegue_ACT")
$Error:=ALP_DefaultColSettings (ALP_AvisosXPagar;AT_Inc ;"atACT_AMoneda";__ ("Moneda");100)
$Error:=ALP_DefaultColSettings (ALP_AvisosXPagar;AT_Inc ;"arACT_AMontoMoneda";__ ("Monto\ra Pagar");80;"|Despliegue_ACT_Pagos")
$Error:=ALP_DefaultColSettings (ALP_AvisosXPagar;AT_Inc ;"arACT_AMontoSeleccionado";__ ("Monto\rSeleccionado");80;"|Despliegue_ACT_Pagos")
$Error:=ALP_DefaultColSettings (ALP_AvisosXPagar;AT_Inc ;"alACT_RecNumsAvisos";"")
$Error:=ALP_DefaultColSettings (ALP_AvisosXPagar;AT_Inc ;"alACT_AIDAvisoOrder";"")
$Error:=ALP_DefaultColSettings (ALP_AvisosXPagar;AT_Inc ;"abACT_ASelectedAvisos";"")

  //general options
ALP_SetDefaultAppareance (ALP_AvisosXPagar;9;1;6;2;8)
AL_SetColOpts (ALP_AvisosXPagar;1;1;1;3;0)
AL_SetRowOpts (ALP_AvisosXPagar;0;1;0;0;1;0)
AL_SetCellOpts (ALP_AvisosXPagar;0;1;1)
AL_SetMainCalls (ALP_AvisosXPagar;"";"")
AL_SetScroll (ALP_AvisosXPagar;0;-3)
AL_SetEntryOpts (ALP_AvisosXPagar;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (ALP_AvisosXPagar;0;30;0)