//%attributes = {}
  //xALP_setPeriodosEscolares

C_LONGINT:C283($err)

$err:=ALP_DefaultColSettings (xALP_Periodos;1;"aiSTR_Periodos_Numero";__ ("Nº");20;"###")
$err:=ALP_DefaultColSettings (xALP_Periodos;2;"atSTR_Periodos_Nombre";__ ("Nombre Período");100;"";0;0;0)
$err:=ALP_DefaultColSettings (xALP_Periodos;3;"adSTR_Periodos_Desde";__ ("Inicio");69;"00/00/0000";0;0;1)
$err:=ALP_DefaultColSettings (xALP_Periodos;4;"adSTR_Periodos_Hasta";__ ("Término");69;"00/00/0000";0;0;1)

  //AL_SetInterface (xALP_Periodos;AL Platinium Interface ;1;1;0;0;0;0)
  //$err:=ALP_DefaultColSettings (xALP_Periodos;1;"aiPst_GroupID";"Nº";16;"###")
  //AL_SetInterface()
  //general options
ALP_SetDefaultAppareance (xALP_Periodos;9;1;6;1;8)
AL_SetColOpts (xALP_Periodos;1;1;1;0;0)
AL_SetRowOpts (xALP_Periodos;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Periodos;0;1;1)
AL_SetMiscOpts (xALP_Periodos;0;0;"\\";0;1)
  //AL_SetCallbacks (xALP_Periodos;"";"xALP_ADT_GuardaIntervaloPostula")
AL_SetMainCalls (xALP_Periodos;"";"")
AL_SetScroll (xALP_Periodos;-3;-3)
AL_SetEntryOpts (xALP_Periodos;3;0;0;1;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_Periodos;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Periodos;1;"";"";"")
AL_SetDrgSrc (xALP_Periodos;2;"";"";"")
AL_SetDrgSrc (xALP_Periodos;3;"";"";"")
AL_SetDrgDst (xALP_Periodos;1;"";"";"")
AL_SetDrgDst (xALP_Periodos;1;"";"";"")
AL_SetDrgDst (xALP_Periodos;1;"";"";"")

