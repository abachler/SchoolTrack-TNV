//%attributes = {}
  //xALSet_ADT_SeleccionGrupo

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Groups;1;1;"aiPst_GroupID")
$Error:=AL_SetArraysNam (xALP_Groups;2;1;"atPST_GroupName")
$Error:=AL_SetArraysNam (xALP_Groups;3;1;"aiPST_ExamTime")


  //column 1 settings
AL_SetHeaders (xALP_Groups;1;1;__ ("Nº"))
AL_SetWidths (xALP_Groups;1;1;20)
AL_SetFormat (xALP_Groups;1;"###";0;0;0;0)
AL_SetHdrStyle (xALP_Groups;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Groups;1;"Tahoma";9;0)
AL_SetStyle (xALP_Groups;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Groups;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Groups;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Groups;1;0)
AL_SetEntryCtls (xALP_Groups;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Groups;2;1;__ ("Nombre del grupo"))
AL_SetWidths (xALP_Groups;2;1;220)
AL_SetFormat (xALP_Groups;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Groups;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Groups;2;"Tahoma";9;0)
AL_SetStyle (xALP_Groups;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Groups;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Groups;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Groups;2;0)
AL_SetEntryCtls (xALP_Groups;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Groups;3;1;__ ("Hora Ex."))
AL_SetWidths (xALP_Groups;3;1;48)
AL_SetFormat (xALP_Groups;3;"&/2";0;0;0;0)
AL_SetHdrStyle (xALP_Groups;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Groups;3;"Tahoma";9;0)
AL_SetStyle (xALP_Groups;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Groups;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Groups;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Groups;3;0)
AL_SetEntryCtls (xALP_Groups;3;0)

  //  `general options
ALP_SetDefaultAppareance (xALP_Groups;9)
  //ALP_SetDefaultAppareance (xALP_Groups;9;1;6;1;8)
AL_SetColOpts (xALP_Groups;1;1;1;0;0)
AL_SetRowOpts (xALP_Groups;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Groups;0;1;1)
AL_SetMiscOpts (xALP_Groups;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Groups;"";"")
AL_SetScroll (xALP_Groups;0;-3)
AL_SetEntryOpts (xALP_Groups;1;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Groups;0;30;0)
  //
  //  `dragging options

AL_SetDrgSrc (xALP_Groups;1;"";"";"")
AL_SetDrgSrc (xALP_Groups;2;"";"";"")
AL_SetDrgSrc (xALP_Groups;3;"";"";"")
AL_SetDrgDst (xALP_Groups;1;"";"";"")
AL_SetDrgDst (xALP_Groups;1;"";"";"")
AL_SetDrgDst (xALP_Groups;1;"";"";"")