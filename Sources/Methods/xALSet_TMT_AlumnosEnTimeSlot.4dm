//%attributes = {}
  //xALSet_TMT_AlumnosEnTimeSlot

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_TMT_Alumnos;1;1;"atTMT_alumnos_nombres")
$Error:=AL_SetArraysNam (xALP_TMT_Alumnos;2;1;"atTMT_alumnos_curso")

  //column 1 settings
AL_SetHeaders (xALP_TMT_Alumnos;1;1;__ ("Alumnos"))
AL_SetWidths (xALP_TMT_Alumnos;1;1;160)
AL_SetFormat (xALP_TMT_Alumnos;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_TMT_Alumnos;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_TMT_Alumnos;1;"Tahoma";9;0)
AL_SetStyle (xALP_TMT_Alumnos;1;"Tahoma";9;0)
AL_SetForeColor (xALP_TMT_Alumnos;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_TMT_Alumnos;1;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_TMT_Alumnos;1;1)
AL_SetEntryCtls (xALP_TMT_Alumnos;1;0)

  //column 2 settings
AL_SetHeaders (xALP_TMT_Alumnos;2;1;__ ("Curso"))
AL_SetWidths (xALP_TMT_Alumnos;2;1;63)
AL_SetFormat (xALP_TMT_Alumnos;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_TMT_Alumnos;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_TMT_Alumnos;2;"Tahoma";9;0)
AL_SetStyle (xALP_TMT_Alumnos;2;"Tahoma";9;0)
AL_SetForeColor (xALP_TMT_Alumnos;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_TMT_Alumnos;2;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_TMT_Alumnos;2;1)
AL_SetEntryCtls (xALP_TMT_Alumnos;2;0)

  //general options
ALP_SetDefaultAppareance (xALP_TMT_Alumnos;9;1;2;1;1)
AL_SetColOpts (xALP_TMT_Alumnos;1;1;1;0;0)
AL_SetRowOpts (xALP_TMT_Alumnos;0;0;0;0;1;0)
AL_SetCellOpts (xALP_TMT_Alumnos;0;1;1)
AL_SetMiscOpts (xALP_TMT_Alumnos;0;0;"\\";0;1)
AL_SetMainCalls (xALP_TMT_Alumnos;"";"")
AL_SetScroll (xALP_TMT_Alumnos;0;-3)
AL_SetEntryOpts (xALP_TMT_Alumnos;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_TMT_Alumnos;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_TMT_Alumnos;1;"";"";"")
AL_SetDrgSrc (xALP_TMT_Alumnos;2;"";"";"")
AL_SetDrgSrc (xALP_TMT_Alumnos;3;"";"";"")
AL_SetDrgDst (xALP_TMT_Alumnos;1;"";"";"")
AL_SetDrgDst (xALP_TMT_Alumnos;1;"";"";"")
AL_SetDrgDst (xALP_TMT_Alumnos;1;"";"";"")

