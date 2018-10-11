//%attributes = {}
  //xALSet_ACT_IngresoPagos

C_BOOLEAN:C305(vbACT_IngresandoPagos)


AL_RemoveArrays (ALP_CargosXPagar;1;14)

AT_Inc (0)
If (vbACT_IngresandoPagos)
	$error:=ALP_DefaultColSettings (ALP_CargosXPagar;AT_Inc ;"apACT_ASelectedCargo";"";20;"1")
	$vl_ResizeCol:=10
Else 
	$vl_ResizeCol:=0
End if 
$error:=ALP_DefaultColSettings (ALP_CargosXPagar;AT_Inc ;"adACT_CFechaEmision";__ ("Emisión");70-$vl_ResizeCol;"7";2;2;0)
$error:=ALP_DefaultColSettings (ALP_CargosXPagar;AT_Inc ;"adACT_CFechaVencimiento";__ ("Vencimiento");85-$vl_ResizeCol;"7";2;2;0)
$error:=ALP_DefaultColSettings (ALP_CargosXPagar;AT_Inc ;"atACT_CAlumno";__ ("Alumno");180;"";0;2;0)
$error:=ALP_DefaultColSettings (ALP_CargosXPagar;AT_Inc ;"atACT_CGlosa";__ ("Glosa");180;"";0;2;0)
$error:=ALP_DefaultColSettings (ALP_CargosXPagar;AT_Inc ;"atACT_MonedaSimbolo";__ ("Monto Moneda");86;"|Despliegue_ACT";3;2;0)
$error:=ALP_DefaultColSettings (ALP_CargosXPagar;AT_Inc ;"arACT_CMontoNeto";__ ("Monto Neto");70;"|Despliegue_ACT";0;2;0)
  //$error:=ALP_DefaultColSettings (ALP_CargosXPagar;AT_Inc ;"arACT_CIntereses";"Intereses";60;"|Despliegue_ACT";0;2;0)
$error:=ALP_DefaultColSettings (ALP_CargosXPagar;AT_Inc ;"arACT_CSaldo";__ ("Saldo");60;"|Despliegue_ACT";0;2;0)
$error:=ALP_DefaultColSettings (ALP_CargosXPagar;AT_Inc ;"alACT_RecNumsCargos";"";0;"0";0;2;0)
$error:=ALP_DefaultColSettings (ALP_CargosXPagar;AT_Inc ;"alACT_CRefs";"";0;"0";0;2;0)
$error:=ALP_DefaultColSettings (ALP_CargosXPagar;AT_Inc ;"alACT_CIDCtaCte";"";0;"0";0;2;0)
$error:=ALP_DefaultColSettings (ALP_CargosXPagar;AT_Inc ;"asACT_Marcas";"";0;"0";0;2;0)
$error:=ALP_DefaultColSettings (ALP_CargosXPagar;AT_Inc ;"atACT_MonedaCargo";"";0;"0";0;2;0)
$error:=ALP_DefaultColSettings (ALP_CargosXPagar;AT_Inc ;"arACT_MontoMoneda";"";0;"0";0;2;0)
If (vbACT_IngresandoPagos)
	$error:=ALP_DefaultColSettings (ALP_CargosXPagar;AT_Inc ;"abACT_ASelectedCargo";"";0;"0";0;2;0)
	$vl_ResizeCol:=1
Else 
	$vl_ResizeCol:=0
End if 

  //general options
ALP_SetDefaultAppareance (ALP_CargosXPagar;9;1;6;1;8)
AL_SetColOpts (ALP_CargosXPagar;1;1;1;6+$vl_ResizeCol;0)
  //If (vbACT_IngresandoPagos)
AL_SetRowOpts (ALP_CargosXPagar;0;1;0;0;1;0)
  //Else 
  //AL_SetRowOpts (ALP_CargosXPagar;1;1;0;0;1;0)
  //End if 
AL_SetCellOpts (ALP_CargosXPagar;0;1;1)
AL_SetMainCalls (ALP_CargosXPagar;"";"")
AL_SetScroll (ALP_CargosXPagar;0;0)
AL_SetEntryOpts (ALP_CargosXPagar;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (ALP_CargosXPagar;0;30;0)

  //dragging options

AL_SetDrgSrc (ALP_CargosXPagar;1;"";"";"")
AL_SetDrgSrc (ALP_CargosXPagar;2;"";"";"")
AL_SetDrgSrc (ALP_CargosXPagar;3;"";"";"")
AL_SetDrgDst (ALP_CargosXPagar;1;"";"";"")
AL_SetDrgDst (ALP_CargosXPagar;1;"";"";"")
AL_SetDrgDst (ALP_CargosXPagar;1;"";"";"")