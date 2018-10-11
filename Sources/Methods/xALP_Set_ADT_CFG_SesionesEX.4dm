//%attributes = {}
  //xALP_Set_ADT_CFG_SesionesEX

C_LONGINT:C283($Error)

$error:=ALP_DefaultColSettings (xALP_Exams;1;"adPst_ExamSesionsDate";__ ("Fecha");70;"00/00/0000";0;0;1)
$error:=ALP_DefaultColSettings (xALP_Exams;2;"alADT_ExamAttendance";__ ("No.");30;"###0")
$error:=ALP_DefaultColSettings (xALP_Exams;3;"abADT_ReservedPG";__ ("Sólo J. Inf");70;"Si;No";0;0;1)
$error:=ALP_DefaultColSettings (xALP_Exams;4;"atADT_Place";__ ("Lugar");184;"";0;0;1)
$error:=ALP_DefaultColSettings (xALP_Exams;5;"asADT_Responsable";__ ("Examinador");170)
AL_SetEnterable (xALP_Exams;5;3;atADT_Examinadores)
$error:=ALP_DefaultColSettings (xALP_Exams;6;"aLPST_SesionID";"")
$error:=ALP_DefaultColSettings (xALP_Exams;7;"alADT_Responsable_ID";"")

  //general options
ALP_SetDefaultAppareance (xALP_Exams;9;1;6;1;8)
AL_SetColOpts (xALP_Exams;1;1;1;2;0)
AL_SetRowOpts (xALP_Exams;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Exams;0;1;1)
AL_SetMiscOpts (xALP_Exams;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Exams;"";"")
AL_SetCallbacks (xALP_Exams;"";"xALP_ADT_CBEX_Exams")
AL_SetScroll (xALP_Exams;0;-3)
AL_SetEntryOpts (xALP_Exams;3;0;0;1;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_Exams;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Exams;1;"";"";"")
AL_SetDrgSrc (xALP_Exams;2;"";"";"")
AL_SetDrgSrc (xALP_Exams;3;"";"";"")
AL_SetDrgDst (xALP_Exams;1;"";"";"")
AL_SetDrgDst (xALP_Exams;1;"";"";"")
AL_SetDrgDst (xALP_Exams;1;"";"";"")