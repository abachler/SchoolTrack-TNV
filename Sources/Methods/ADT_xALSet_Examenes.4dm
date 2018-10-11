//%attributes = {}
  //ADT_xALSet_Examenes

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Sections;1;1;"asPST_SelEXmSections")
$Error:=AL_SetArraysNam (xALP_Sections;2;1;"adPST_SelEXmDate")
$Error:=AL_SetArraysNam (xALP_Sections;3;1;"aLPST_SelEXmTime")
$Error:=AL_SetArraysNam (xALP_Sections;4;1;"aiPST_SelEXmGirls")
$Error:=AL_SetArraysNam (xALP_Sections;5;1;"aiPST_SelEXmBoys")
$Error:=AL_SetArraysNam (xALP_Sections;6;1;"aiPST_SelEXmTotal")
$Error:=AL_SetArraysNam (xALP_Sections;7;1;"aLPST_SelEXmID")
$Error:=AL_SetArraysNam (xALP_Sections;8;1;"aLPST_SelEXmSecs")
$Error:=AL_SetArraysNam (xALP_Sections;9;1;"IDS_Examenes")

  //column 1 settings
AL_SetHeaders (xALP_Sections;1;1;__ ("S"))
AL_SetWidths (xALP_Sections;1;1;20)
AL_SetFormat (xALP_Sections;1;"";2;2;0;0)
AL_SetHdrStyle (xALP_Sections;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;1;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;1;"Tahoma";9;1)
AL_SetForeColor (xALP_Sections;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;1;0)
AL_SetEntryCtls (xALP_Sections;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Sections;2;1;__ ("Fecha"))
AL_SetWidths (xALP_Sections;2;1;55)
AL_SetFormat (xALP_Sections;2;"1";0;0;0;0)
AL_SetHdrStyle (xALP_Sections;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;2;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Sections;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;2;0)
AL_SetEntryCtls (xALP_Sections;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Sections;3;1;__ ("Hora"))
AL_SetWidths (xALP_Sections;3;1;55)
AL_SetFormat (xALP_Sections;3;"&/2";0;0;0;0)
AL_SetHdrStyle (xALP_Sections;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;3;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Sections;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;3;0)
AL_SetEntryCtls (xALP_Sections;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Sections;4;1;__ ("M"))
AL_SetWidths (xALP_Sections;4;1;20)
AL_SetFormat (xALP_Sections;4;"###0";0;2;0;0)
AL_SetHdrStyle (xALP_Sections;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;4;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Sections;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;4;0)
AL_SetEntryCtls (xALP_Sections;4;0)

  //column 5 settings
AL_SetHeaders (xALP_Sections;5;1;__ ("H"))
AL_SetWidths (xALP_Sections;5;1;20)
AL_SetFormat (xALP_Sections;5;"###0";0;2;0;0)
AL_SetHdrStyle (xALP_Sections;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;5;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;5;"Tahoma";9;0)
AL_SetForeColor (xALP_Sections;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;5;0)
AL_SetEntryCtls (xALP_Sections;5;0)

  //column 6 settings
AL_SetHeaders (xALP_Sections;6;1;__ ("Total"))
AL_SetWidths (xALP_Sections;6;1;40)
AL_SetFormat (xALP_Sections;6;"###0";0;2;0;0)
AL_SetHdrStyle (xALP_Sections;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;6;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;6;"Tahoma";9;0)
AL_SetForeColor (xALP_Sections;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;6;0)
AL_SetEntryCtls (xALP_Sections;6;0)

  //column 7 settings
AL_SetHeaders (xALP_Sections;7;1;"ID")
AL_SetFormat (xALP_Sections;7;"";0;0;0;0)
AL_SetHdrStyle (xALP_Sections;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;7;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;7;"Tahoma";9;0)
AL_SetForeColor (xALP_Sections;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;7;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;7;1)
AL_SetEntryCtls (xALP_Sections;7;0)

  //column 8 settings
AL_SetHeaders (xALP_Sections;8;1;"secs")
AL_SetFormat (xALP_Sections;8;"";0;0;0;0)
AL_SetHdrStyle (xALP_Sections;8;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;8;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;8;"Tahoma";9;0)
AL_SetForeColor (xALP_Sections;8;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;8;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;8;1)
AL_SetEntryCtls (xALP_Sections;8;0)

  //general options
ALP_SetDefaultAppareance (xALP_Sections;9;1;6;1;8)
AL_SetColOpts (xALP_Sections;1;1;1;2;0)
AL_SetRowOpts (xALP_Sections;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Sections;0;1;1)
AL_SetMiscOpts (xALP_Sections;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Sections;"";"")
AL_SetScroll (xALP_Sections;0;-3)
AL_SetEntryOpts (xALP_Sections;1;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Sections;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Sections;1;"";"";"")
AL_SetDrgSrc (xALP_Sections;2;"";"";"")
AL_SetDrgSrc (xALP_Sections;3;"";"";"")
AL_SetDrgDst (xALP_Sections;1;"";"";"")
AL_SetDrgDst (xALP_Sections;1;"";"";"")
AL_SetDrgDst (xALP_Sections;1;"";"";"")

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
AL_SetEnterable (xALP_Groups;3;1)
AL_SetEntryCtls (xALP_Groups;3;0)

  //general options
ALP_SetDefaultAppareance (xALP_Groups;9;1;6;1;8)
AL_SetColOpts (xALP_Groups;1;1;1;0;0)
AL_SetRowOpts (xALP_Groups;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Groups;0;1;1)
AL_SetMiscOpts (xALP_Groups;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Groups;"";"")
AL_SetScroll (xALP_Groups;0;-3)
AL_SetEntryOpts (xALP_Groups;2;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Groups;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Groups;1;"";"";"")
AL_SetDrgSrc (xALP_Groups;2;"";"";"")
AL_SetDrgSrc (xALP_Groups;3;"";"";"")
AL_SetDrgDst (xALP_Groups;1;"";"";"")
AL_SetDrgDst (xALP_Groups;1;"";"";"")
AL_SetDrgDst (xALP_Groups;1;"";"";"")

