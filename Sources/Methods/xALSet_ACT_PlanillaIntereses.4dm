//%attributes = {}
  //xALSet_ACT_PlanillaIntereses

AL_RemoveArrays (xALP_PlanillaIntereses;1;14)

AT_Inc (0)
$error:=ALP_DefaultColSettings (xALP_PlanillaIntereses;AT_Inc ;"alACT_IntAvisoID";__ ("No Aviso");70;"######")
$error:=ALP_DefaultColSettings (xALP_PlanillaIntereses;AT_Inc ;"adACT_IntFecha";__ ("Fecha de Emisión");90)
$error:=ALP_DefaultColSettings (xALP_PlanillaIntereses;AT_Inc ;"adACT_IntFechaV";__ ("Fecha de Vencimiento");130)
$error:=ALP_DefaultColSettings (xALP_PlanillaIntereses;AT_Inc ;"atACT_IntGlosa";__ ("Glosa");170)
$error:=ALP_DefaultColSettings (xALP_PlanillaIntereses;AT_Inc ;"arACT_IntMonto";__ ("Monto");80;"|Despliegue_ACT")
$error:=ALP_DefaultColSettings (xALP_PlanillaIntereses;AT_Inc ;"arACT_IntSaldo";__ ("Saldo");80;"|Despliegue_ACT")
$error:=ALP_DefaultColSettings (xALP_PlanillaIntereses;AT_Inc ;"alACT_IntCargoID";"")
$error:=ALP_DefaultColSettings (xALP_PlanillaIntereses;AT_Inc ;"alACT_IntRecNum";"")

  //general options
ALP_SetDefaultAppareance (xALP_PlanillaIntereses;9;1;6;1;8)
AL_SetColOpts (xALP_PlanillaIntereses;1;1;1;2;0)
AL_SetRowOpts (xALP_PlanillaIntereses;0;1;0;0;1;0)
AL_SetCellOpts (xALP_PlanillaIntereses;0;1;1)
AL_SetMainCalls (xALP_PlanillaIntereses;"";"")
AL_SetScroll (xALP_PlanillaIntereses;0;-3)
AL_SetEntryOpts (xALP_PlanillaIntereses;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_PlanillaIntereses;0;30;0)