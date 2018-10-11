//%attributes = {}
  //xALSet_ADT_SelectPresentacion

C_LONGINT:C283($Error)

$Error:=ALP_DefaultColSettings (xALP_Presentations;1;"adPST_PresentDate";__ ("Fecha");80;"00/00/0000")
$Error:=ALP_DefaultColSettings (xALP_Presentations;2;"aLPST_PresentTime";__ ("Hora");60;"&/2")
$Error:=ALP_DefaultColSettings (xALP_Presentations;3;"aiPST_Asistentes";__ ("Asistentes");80;"####")
$Error:=ALP_DefaultColSettings (xALP_Presentations;4;"atPST_Place";__ ("Lugar");80;"####")
$Error:=ALP_DefaultColSettings (xALP_Presentations;5;"atPST_Encargado";__ ("Encargado");80;"####")
$Error:=ALP_DefaultColSettings (xALP_Presentations;6;"aiADT_IDEntrevistador";"IdEntrevistador";80;"####")


  //general options
ALP_SetDefaultAppareance (xALP_Presentations;9;1;1;1;2)
AL_SetColOpts (xALP_Presentations;1;1;1;0;0)
AL_SetRowOpts (xALP_Presentations;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Presentations;0;1;1)
AL_SetMiscOpts (xALP_Presentations;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Presentations;"";"")
AL_SetScroll (xALP_Presentations;0;-3)
AL_SetEntryOpts (xALP_Presentations;1;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Presentations;0;30;0)