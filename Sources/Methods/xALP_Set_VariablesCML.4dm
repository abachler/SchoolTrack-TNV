//%attributes = {}
C_LONGINT:C283($err)

$err:=ALP_DefaultColSettings (xALP_VariablesCML;1;"<>apCML_SiVariable";"";30;"";0;0;0)
$err:=ALP_DefaultColSettings (xALP_VariablesCML;2;"<>atCML_CodigoVariable";"";40;"";0;0;0)
$err:=ALP_DefaultColSettings (xALP_VariablesCML;3;"<>atCML_DescripcionVariable";"";150;"";0;0;0)
  //$err:=ALP_DefaultColSettings (xALP_ExaminationsGroups;4;"adPST_ToDate";"Hasta el";60;"00/00/0000";0;0;1)
  //$err:=ALP_DefaultColSettings (xALP_ExaminationsGroups;5;"aiPST_maxpostulantes";"Postulantes";65;"###0";0;0;1)
  //$err:=ALP_DefaultColSettings (xALP_ExaminationsGroups;6;"aiPST_Candidates";"Inscritos";50;"###0";0;0;0)
  //$err:=ALP_DefaultColSettings (xALP_ExaminationsGroups;7;"aiPST_Cupos";"Cupos";40;"###0";0;0;0)
  //$err:=ALP_DefaultColSettings (xALP_ExaminationsGroups;8;"aiPST_ExamTime";"Hora Ex.";50;"&/2";0;0;1)

  //general options
ALP_SetDefaultAppareance (xALP_VariablesCML;9;1;6;1;8)
AL_SetColOpts (xALP_VariablesCML;1;1;1;0;0)
AL_SetRowOpts (xALP_VariablesCML;0;0;0;0;1;0)
AL_SetCellOpts (xALP_VariablesCML;0;1;1)
AL_SetMiscOpts (xALP_VariablesCML;1;0;"\\";0;1)
AL_SetMainCalls (xALP_VariablesCML;"";"")
  //AL_SetCallbacks (xALP_VariablesCML;"";"xALP_CML_CBEX_GuardarVariable")
AL_SetScroll (xALP_VariablesCML;0;0)
AL_SetEntryOpts (xALP_VariablesCML;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_VariablesCML;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_VariablesCML;1;"";"";"")
AL_SetDrgSrc (xALP_VariablesCML;2;"";"";"")
AL_SetDrgSrc (xALP_VariablesCML;3;"";"";"")
AL_SetDrgDst (xALP_VariablesCML;1;"";"";"")
AL_SetDrgDst (xALP_VariablesCML;1;"";"";"")
AL_SetDrgDst (xALP_VariablesCML;1;"";"";"")