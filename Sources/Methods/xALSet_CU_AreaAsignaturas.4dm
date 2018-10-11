//%attributes = {}
  //xALSet_CU_AreaAsignaturas


C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Asignaturas;1;1;"aSubjectName")
$Error:=AL_SetArraysNam (xALP_Asignaturas;2;1;"aSubjectTeacher")
$Error:=AL_SetArraysNam (xALP_Asignaturas;3;1;"at_OrdenAsignaturas")

  //column 1 settings
AL_SetHeaders (xALP_Asignaturas;1;1;__ ("Subsector"))
AL_SetWidths (xALP_Asignaturas;1;1;200)
AL_SetFormat (xALP_Asignaturas;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Asignaturas;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Asignaturas;1;"Tahoma";9;0)
AL_SetStyle (xALP_Asignaturas;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Asignaturas;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Asignaturas;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Asignaturas;1;1)
AL_SetEntryCtls (xALP_Asignaturas;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Asignaturas;2;1;__ ("Profesor"))
AL_SetWidths (xALP_Asignaturas;2;1;189)
AL_SetFormat (xALP_Asignaturas;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Asignaturas;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Asignaturas;2;"Tahoma";9;0)
AL_SetStyle (xALP_Asignaturas;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Asignaturas;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Asignaturas;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Asignaturas;2;1)
AL_SetEntryCtls (xALP_Asignaturas;2;0)

  //general options
ALP_SetDefaultAppareance (xALP_Asignaturas;9;1;4;1;4)
AL_SetColOpts (xALP_Asignaturas;0;0;1;1;0)
AL_SetRowOpts (xALP_Asignaturas;0;1;0;0;0;0)
AL_SetCellOpts (xALP_Asignaturas;0;1;1)
AL_SetMiscOpts (xALP_Asignaturas;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Asignaturas;"";"")
AL_SetScroll (xALP_Asignaturas;0;-3)
AL_SetEntryOpts (xALP_Asignaturas;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Asignaturas;0;30;0)
AL_SetSortOpts (xALP_Asignaturas;0;0;0;"";0;0)

  //dragging options
AL_SetDrgSrc (xALP_Asignaturas;1;"")
AL_SetDrgDst (xALP_Asignaturas;1;"")

