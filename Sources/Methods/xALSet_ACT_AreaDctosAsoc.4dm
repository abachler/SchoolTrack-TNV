//%attributes = {}
  //xALSet_ACT_AreaDctosAsoc

C_LONGINT:C283($Error)

$error:=ALP_DefaultColSettings (xALP_DocsAsociados;1;"alACT_NumDctoAsoc";__ ("Número");45;"### ###";0;0;0)
$error:=ALP_DefaultColSettings (xALP_DocsAsociados;2;"atACT_TipoDctoAsoc";__ ("Tipo Dcto");125;"";0;0;0)
$error:=ALP_DefaultColSettings (xALP_DocsAsociados;3;"arACT_MontoDctoAsoc";__ ("Monto Dcto");70;"|Despliegue_ACT_Pagos";0;0;0)

  //general options
ALP_SetDefaultAppareance (xALP_DocsAsociados;9;1;6;1;8)
AL_SetColOpts (xALP_DocsAsociados;1;1;1;0;0)
AL_SetRowOpts (xALP_DocsAsociados;1;1;0;0;1;0)
AL_SetCellOpts (xALP_DocsAsociados;0;1;1)
AL_SetMainCalls (xALP_DocsAsociados;"";"")
AL_SetScroll (xALP_DocsAsociados;0;0)
AL_SetEntryOpts (xALP_DocsAsociados;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_DocsAsociados;0;30;0)