//%attributes = {}
  //xALSet_PP_ACT_AreaTerceros
$err:=ALP_DefaultColSettings (xALP_TercApdo;1;"aACT_ApdosTercAsocNombre";__ ("Nombre");126)

  //general options
ALP_SetDefaultAppareance (xALP_TercApdo;9;1;6;1;8)
AL_SetColOpts (xALP_TercApdo;1;1;1;0;0)
AL_SetRowOpts (xALP_TercApdo;0;1;0;0;1;1)
AL_SetCellOpts (xALP_TercApdo;0;1;1)
AL_SetMiscOpts (xALP_TercApdo;0;0;"\\";0;1)
AL_SetMainCalls (xALP_TercApdo;"";"")
AL_SetScroll (xALP_TercApdo;-3;-3)
AL_SetEntryOpts (xALP_TercApdo;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_TercApdo;0;30;0)