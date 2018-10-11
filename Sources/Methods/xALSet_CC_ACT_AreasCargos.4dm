//%attributes = {}
  //xALSet_CC_ACT_AreasCargos

C_LONGINT:C283($Error)

AT_Inc (0)
$error:=ALP_DefaultColSettings (xALP_Documentos;AT_Inc ;"aACT_CtasDCNoComprobante";__ ("Nº Aviso");106;"|Long";0;2;0)
$error:=ALP_DefaultColSettings (xALP_Documentos;AT_Inc ;"aACT_CtasDCFechaEmision";__ ("Fecha emisión");106;"7";0;2;0)
$error:=ALP_DefaultColSettings (xALP_Documentos;AT_Inc ;"aACT_CtasDCNeto";__ ("Neto");106;"|Despliegue_ACT";0;2;0)
$error:=ALP_DefaultColSettings (xALP_Documentos;AT_Inc ;"aACT_CtasDCIntereses";__ ("Intereses");107;"|Despliegue_ACT";0;2;0)
$error:=ALP_DefaultColSettings (xALP_Documentos;AT_Inc ;"aACT_CtasDCSaldo";__ ("Saldo");107;"|Despliegue_ACT";0;2;0)
$error:=ALP_DefaultColSettings (xALP_Documentos;AT_Inc ;"aACT_CtasDCMoneda";__ ("Moneda");107;"";0;2;0)
$error:=ALP_DefaultColSettings (xALP_Documentos;AT_Inc ;"aACT_CtasDCID";"ID";0;"";0;2;0)

  //general options
ALP_SetDefaultAppareance (xALP_Documentos;9;1;6;1;8)
AL_SetColOpts (xALP_Documentos;1;1;1;1;0)
AL_SetRowOpts (xALP_Documentos;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Documentos;0;1;1)
AL_SetMiscOpts (xALP_Documentos;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Documentos;"";"")
AL_SetScroll (xALP_Documentos;0;-3)
AL_SetEntryOpts (xALP_Documentos;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Documentos;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Documentos;1;"";"";"")
AL_SetDrgSrc (xALP_Documentos;2;"";"";"")
AL_SetDrgSrc (xALP_Documentos;3;"";"";"")
AL_SetDrgDst (xALP_Documentos;1;"";"";"")
AL_SetDrgDst (xALP_Documentos;1;"";"";"")
AL_SetDrgDst (xALP_Documentos;1;"";"";"")