//%attributes = {}
  //xALSet_TMT_Cursos

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Cursos;1;1;"at_CursosEnHorario")

  //column 1 settings
AL_SetHeaders (xALP_Cursos;1;1;__ ("Cursos"))
AL_SetFormat (xALP_Cursos;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Cursos;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Cursos;1;"Tahoma";9;0)
AL_SetStyle (xALP_Cursos;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Cursos;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Cursos;1;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_Cursos;1;1)
AL_SetEntryCtls (xALP_Cursos;1;0)

  //general options
ALP_SetDefaultAppareance (xALP_Cursos;11;1;4;1;4)
AL_SetColOpts (xALP_Cursos;1;1;1;0;0)
AL_SetRowOpts (xALP_Cursos;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Cursos;0;1;1)
AL_SetMiscOpts (xALP_Cursos;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Cursos;"";"")
AL_SetScroll (xALP_Cursos;0;-3)
AL_SetEntryOpts (xALP_Cursos;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Cursos;0;30;0)
AL_SetInterface (xALP_Cursos;AL Force OSX Interface;1;1;0;0;1)

  //dragging options

AL_SetDrgSrc (xALP_Cursos;1;"";"";"")
AL_SetDrgSrc (xALP_Cursos;2;"";"";"")
AL_SetDrgSrc (xALP_Cursos;3;"";"";"")
AL_SetDrgDst (xALP_Cursos;1;"";"";"")
AL_SetDrgDst (xALP_Cursos;1;"";"";"")
AL_SetDrgDst (xALP_Cursos;1;"";"";"")

