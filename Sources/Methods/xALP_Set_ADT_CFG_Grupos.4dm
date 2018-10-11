//%attributes = {}
  //xALP_Set_ADT_CFG_Grupos

C_LONGINT:C283($err)

$err:=ALP_DefaultColSettings (xALP_ExaminationsGroups;1;"aiPst_GroupID";__ ("Nº");16;"###")
$err:=ALP_DefaultColSettings (xALP_ExaminationsGroups;2;"atPST_GroupName";__ ("Grupo");75;"";0;0;1)
$err:=ALP_DefaultColSettings (xALP_ExaminationsGroups;3;"adPST_FromDate";__ ("Desde el");60;"00/00/0000";0;0;1)
$err:=ALP_DefaultColSettings (xALP_ExaminationsGroups;4;"adPST_ToDate";__ ("Hasta el");60;"00/00/0000";0;0;1)
$err:=ALP_DefaultColSettings (xALP_ExaminationsGroups;5;"aiPST_maxpostulantes";__ ("Vacantes");65;"###0";0;0;1)
$err:=ALP_DefaultColSettings (xALP_ExaminationsGroups;6;"aiPST_Candidates";__ ("Inscritos");50;"###0";0;0;0)
$err:=ALP_DefaultColSettings (xALP_ExaminationsGroups;7;"aiPST_Cupos";__ ("Cupos");40;"###0";0;0;0)
$err:=ALP_DefaultColSettings (xALP_ExaminationsGroups;8;"aiPST_ExamTime";__ ("Hora Ex.");50;"&/2";0;0;1)


  //general options
ALP_SetDefaultAppareance (xALP_ExaminationsGroups;9;1;6;1;8)
AL_SetColOpts (xALP_ExaminationsGroups;1;1;1;0;0)
AL_SetRowOpts (xALP_ExaminationsGroups;0;0;0;0;1;0)
AL_SetCellOpts (xALP_ExaminationsGroups;0;1;1)
AL_SetMiscOpts (xALP_ExaminationsGroups;0;0;"\\";0;1)
AL_SetMainCalls (xALP_ExaminationsGroups;"";"")
AL_SetCallbacks (xALP_ExaminationsGroups;"";"xALP_ADT_CBEX_ExamsGroups")
AL_SetScroll (xALP_ExaminationsGroups;0;0)
AL_SetEntryOpts (xALP_ExaminationsGroups;3;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_ExaminationsGroups;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_ExaminationsGroups;1;"";"";"")
AL_SetDrgSrc (xALP_ExaminationsGroups;2;"";"";"")
AL_SetDrgSrc (xALP_ExaminationsGroups;3;"";"";"")
AL_SetDrgDst (xALP_ExaminationsGroups;1;"";"";"")
AL_SetDrgDst (xALP_ExaminationsGroups;1;"";"";"")
AL_SetDrgDst (xALP_ExaminationsGroups;1;"";"";"")

