//%attributes = {}
  //XALSet_PP_ACT_AreasDocumentos

C_LONGINT:C283($Error)

AT_Inc (0)
$error:=ALP_DefaultColSettings (xALP_Documentos;AT_Inc ;"aACT_ApdosDCNoComprobante";__ ("Nº Aviso");96;"|Long";0;2;0)
$error:=ALP_DefaultColSettings (xALP_Documentos;AT_Inc ;"aACT_ApdosDCFechaEmision";__ ("Fecha emisión");96;"7";0;2;0)
$error:=ALP_DefaultColSettings (xALP_Documentos;AT_Inc ;"aACT_ApdosDCNeto";__ ("Neto");96;"|Despliegue_ACT";0;2;0)
$error:=ALP_DefaultColSettings (xALP_Documentos;AT_Inc ;"aACT_ApdosDCIntereses";__ ("Intereses");97;"|Despliegue_ACT";0;2;0)
$error:=ALP_DefaultColSettings (xALP_Documentos;AT_Inc ;"aACT_ApdosDCSaldo";__ ("Saldo");97;"|Despliegue_ACT";0;2;0)
$error:=ALP_DefaultColSettings (xALP_Documentos;AT_Inc ;"aACT_ApdosDCMoneda";__ ("Moneda");97;"";0;2;0)
$error:=ALP_DefaultColSettings (xALP_Documentos;AT_Inc ;"alACT_ApdosDCPagares";__ ("Nº Pagaré");60;"### ### ##0";0;2;0)
$error:=ALP_DefaultColSettings (xALP_Documentos;AT_Inc ;"aACT_ApdosDCID";"ID";0;"";0;2;0)

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