//%attributes = {}
  //xALP_Set_StudTutorias

C_LONGINT:C283($Error)
ARRAY TEXT:C222(aStdName;0)
ARRAY TEXT:C222(aStdClass;0)
ARRAY LONGINT:C221(aStdRecNo;0)
  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Students;1;1;"aStdName")
$Error:=AL_SetArraysNam (xALP_Students;2;1;"aStdClass")
$Error:=AL_SetArraysNam (xALP_Students;3;1;"aStdRecNo")

  //column 1 settings
AL_SetHeaders (xALP_Students;1;1;__ ("Alumno"))
AL_SetWidths (xALP_Students;1;1;160)
AL_SetFormat (xALP_Students;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Students;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Students;1;"Tahoma";9;0)
AL_SetStyle (xALP_Students;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Students;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Students;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Students;1;0)
AL_SetEntryCtls (xALP_Students;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Students;2;1;__ ("Curso"))
AL_SetWidths (xALP_Students;2;1;60)
AL_SetFormat (xALP_Students;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Students;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Students;2;"Tahoma";9;0)
AL_SetStyle (xALP_Students;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Students;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Students;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Students;2;0)
AL_SetEntryCtls (xALP_Students;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Students;3;1;"Column 3")
AL_SetFormat (xALP_Students;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_Students;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Students;3;"Tahoma";9;0)
AL_SetStyle (xALP_Students;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Students;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Students;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Students;3;0)
AL_SetEntryCtls (xALP_Students;3;0)

  //general options
ALP_SetDefaultAppareance (xALP_Students;9;1;4;1;4)
AL_SetColOpts (xALP_Students;1;1;1;1;0)
AL_SetRowOpts (xALP_Students;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Students;0;1;1)
AL_SetMiscOpts (xALP_Students;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Students;"";"")
AL_SetScroll (xALP_Students;0;-3)
AL_SetEntryOpts (xALP_Students;1;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Students;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Students;1;"";"";"")
AL_SetDrgSrc (xALP_Students;2;"";"";"")
AL_SetDrgSrc (xALP_Students;3;"";"";"")
AL_SetDrgDst (xALP_Students;1;"";"";"")
AL_SetDrgDst (xALP_Students;1;"";"";"")
AL_SetDrgDst (xALP_Students;1;"";"";"")
AL_SetSort (xALP_Students;1)