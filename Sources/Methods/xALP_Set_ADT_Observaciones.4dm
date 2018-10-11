//%attributes = {}
C_LONGINT:C283($err)

$err:=ALP_DefaultColSettings (xALP_Observaciones;1;"adFechaObservacion";"Fecha";60;"00/00/0000";0;1;0)
$err:=ALP_DefaultColSettings (xALP_Observaciones;2;"atTextoObservacion";"Observaciones";300;"";0;1;1)
$err:=ALP_DefaultColSettings (xALP_Observaciones;3;"atUsuarioObservacion";"Usuario";68;"";0;1;0)
$err:=ALP_DefaultColSettings (xALP_Observaciones;4;"aiIDObservacion";"ID";64;"";1;0;0)
  //AL_SetInterface (xALP_Observaciones;AL Platinium Interface ;1;1;0;0;0;0)
  //$err:=ALP_DefaultColSettings (xALP_Observaciones;1;"aiPst_GroupID";"Nº";16;"###")
  //AL_SetInterface()
  //general options
ALP_SetDefaultAppareance (xALP_Observaciones;9;3;6;1;7)
AL_SetColOpts (xALP_Observaciones;1;1;1;1;0)
AL_SetRowOpts (xALP_Observaciones;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Observaciones;0;1;1)
AL_SetMiscOpts (xALP_Observaciones;0;0;"\\";0;1)
  //AL_SetCallbacks (xALP_Observaciones;"";"xALP_ADT_GuardaIntervaloPostula")
AL_SetMainCalls (xALP_Observaciones;"";"")
AL_SetScroll (xALP_Observaciones;0;-3)
AL_SetEntryOpts (xALP_Observaciones;3;0;0;1;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_Observaciones;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Observaciones;1;"";"";"")
AL_SetDrgSrc (xALP_Observaciones;2;"";"";"")
AL_SetDrgSrc (xALP_Observaciones;3;"";"";"")
AL_SetDrgDst (xALP_Observaciones;1;"";"";"")
AL_SetDrgDst (xALP_Observaciones;1;"";"";"")
AL_SetDrgDst (xALP_Observaciones;1;"";"";"")