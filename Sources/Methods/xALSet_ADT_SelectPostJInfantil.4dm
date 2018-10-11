//%attributes = {}
  //xALSet_ADT_SelectPostJInfantil

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_PlayGroup;1;1;"atPST_JFName")
$Error:=AL_SetArraysNam (xALP_PlayGroup;2;1;"adPST_JFBirthDate")
$Error:=AL_SetArraysNam (xALP_PlayGroup;3;1;"atPST_JFClass")
$Error:=AL_SetArraysNam (xALP_PlayGroup;4;1;"alPST_JFRecNum")

  //column 1 settings
AL_SetHeaders (xALP_PlayGroup;1;1;__ ("Nombre"))
AL_SetWidths (xALP_PlayGroup;1;1;150)
AL_SetFormat (xALP_PlayGroup;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_PlayGroup;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_PlayGroup;1;"Tahoma";9;0)
AL_SetStyle (xALP_PlayGroup;1;"Tahoma";9;0)
AL_SetForeColor (xALP_PlayGroup;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PlayGroup;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_PlayGroup;1;1)
AL_SetEntryCtls (xALP_PlayGroup;1;0)

  //column 2 settings
AL_SetHeaders (xALP_PlayGroup;2;1;__ ("Fecha Nac."))
AL_SetWidths (xALP_PlayGroup;2;1;60)
AL_SetFormat (xALP_PlayGroup;2;"7";0;0;0;0)
AL_SetHdrStyle (xALP_PlayGroup;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_PlayGroup;2;"Tahoma";9;0)
AL_SetStyle (xALP_PlayGroup;2;"Tahoma";9;0)
AL_SetForeColor (xALP_PlayGroup;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PlayGroup;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_PlayGroup;2;1)
AL_SetEntryCtls (xALP_PlayGroup;2;0)

  //column 3 settings
AL_SetHeaders (xALP_PlayGroup;3;1;__ ("Curso"))
AL_SetWidths (xALP_PlayGroup;3;1;48)
AL_SetFormat (xALP_PlayGroup;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_PlayGroup;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_PlayGroup;3;"Tahoma";9;0)
AL_SetStyle (xALP_PlayGroup;3;"Tahoma";9;0)
AL_SetForeColor (xALP_PlayGroup;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PlayGroup;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_PlayGroup;3;1)
AL_SetEntryCtls (xALP_PlayGroup;3;0)

  //column 4 settings
AL_SetHeaders (xALP_PlayGroup;4;1;"RecNum")
AL_SetFormat (xALP_PlayGroup;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_PlayGroup;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_PlayGroup;4;"Tahoma";9;0)
AL_SetStyle (xALP_PlayGroup;4;"Tahoma";9;0)
AL_SetForeColor (xALP_PlayGroup;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PlayGroup;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_PlayGroup;4;1)
AL_SetEntryCtls (xALP_PlayGroup;4;0)

  //general options
ALP_SetDefaultAppareance (xALP_PlayGroup;9;1;6;1;8)
AL_SetColOpts (xALP_PlayGroup;1;1;1;1;0)
AL_SetRowOpts (xALP_PlayGroup;0;1;0;0;1;0)
AL_SetCellOpts (xALP_PlayGroup;0;1;1)
AL_SetMiscOpts (xALP_PlayGroup;0;0;"\\";0;1)
AL_SetMainCalls (xALP_PlayGroup;"";"")
AL_SetScroll (xALP_PlayGroup;0;-3)
AL_SetEntryOpts (xALP_PlayGroup;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_PlayGroup;0;30;1)

  //dragging options

AL_SetDrgSrc (xALP_PlayGroup;1;"PlayGroup";"";"")
AL_SetDrgSrc (xALP_PlayGroup;2;"";"";"")
AL_SetDrgSrc (xALP_PlayGroup;3;"";"";"")
AL_SetDrgDst (xALP_PlayGroup;1;"Candidates";"";"")
AL_SetDrgDst (xALP_PlayGroup;1;"";"";"")
AL_SetDrgDst (xALP_PlayGroup;1;"";"";"")