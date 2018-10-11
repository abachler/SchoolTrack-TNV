//%attributes = {}
  //xALPSet_ACT_ModelosAv

C_LONGINT:C283($Error)

$Error:=ALP_DefaultColSettings (xAL_ModelosAvisos;1;"atACT_ModelosAv";__ ("Modelo");150;"";0;0;1)
$Error:=ALP_DefaultColSettings (xAL_ModelosAvisos;2;"atACT_ModelosAvDesc";__ ("Descripción");330;"";0;0;1)
$Error:=ALP_DefaultColSettings (xAL_ModelosAvisos;3;"alACT_RegXPaginsAv";__ ("Avisos por\rPágina");74;"#0";0;0;1)
$Error:=ALP_DefaultColSettings (xAL_ModelosAvisos;4;"alACT_ModelosAvID";"")
$Error:=ALP_DefaultColSettings (xAL_ModelosAvisos;5;"abACT_ModelosAvEsSt";"")

AL_SetFilter (xAL_ModelosAvisos;3;"&9")

  //general options
ALP_SetDefaultAppareance (xAL_ModelosAvisos;9;4;4;2;6)
AL_SetColOpts (xAL_ModelosAvisos;1;1;1;2;0)
AL_SetRowOpts (xAL_ModelosAvisos;0;1;0;0;1;0)
AL_SetCellOpts (xAL_ModelosAvisos;0;1;1)
AL_SetMiscOpts (xAL_ModelosAvisos;0;0;"\\";0;1)
AL_SetMainCalls (xAL_ModelosAvisos;"";"")
AL_SetCallbacks (xAL_ModelosAvisos;"xAL_ACT_CBIN_ModelosAv";"xAL_ACT_CB_ModelosAv")
AL_SetScroll (xAL_ModelosAvisos;0;-3)
AL_SetEntryOpts (xAL_ModelosAvisos;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xAL_ModelosAvisos;0;30;0)