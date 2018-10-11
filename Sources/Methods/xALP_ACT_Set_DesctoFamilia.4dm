//%attributes = {}
  //xALP_ACT_Set_DesctoFamilia

C_LONGINT:C283($Error)

$Error:=ALP_DefaultColSettings (xALP_DesctosFamilia;1;"atACT_Familia";"";75)
$Error:=ALP_DefaultColSettings (xALP_DesctosFamilia;2;"arACT_DesctoPorFamilia";"";75;"|Pct_4DecIfNec";0;0;1)

  //general options
ALP_SetDefaultAppareance (xALP_DesctosFamilia;9;1;6;1;8)
AL_SetColOpts (xALP_DesctosFamilia;1;1;1;0;0)
AL_SetRowOpts (xALP_DesctosFamilia;0;1;0;0;1;1)
AL_SetCellOpts (xALP_DesctosFamilia;0;1;1)
AL_SetMiscOpts (xALP_DesctosFamilia;1;0;"\\";0;1)
AL_SetCallbacks (xALP_DesctosFamilia;"";"xALCB_EX_cfgModBlobItemsFamilia")
AL_SetMainCalls (xALP_DesctosFamilia;"";"")
AL_SetScroll (xALP_DesctosFamilia;0;0)
AL_SetEntryOpts (xALP_DesctosFamilia;2;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_DesctosFamilia;0;30;0)