//%attributes = {}
  //xALSet_ADT_SeleccionExamen

C_LONGINT:C283($Error)


  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Sections;1;1;"asPST_SelEXmSections")
$Error:=AL_SetArraysNam (xALP_Sections;2;1;"adPST_SelEXmDate")
$Error:=AL_SetArraysNam (xALP_Sections;3;1;"aLPST_SelEXmTime")
$Error:=AL_SetArraysNam (xALP_Sections;4;1;"atPST_LugarExamen")
$Error:=AL_SetArraysNam (xALP_Sections;5;1;"aiPST_SelEXmGirls")
$Error:=AL_SetArraysNam (xALP_Sections;6;1;"aiPST_SelEXmBoys")
$Error:=AL_SetArraysNam (xALP_Sections;7;1;"aiPST_SelEXmTotal")
$Error:=AL_SetArraysNam (xALP_Sections;8;1;"aLPST_SelEXmID")
$Error:=AL_SetArraysNam (xALP_Sections;9;1;"aLPST_SelEXmSecs")
$Error:=AL_SetArraysNam (xALP_Sections;10;1;"IDS_Examen")

  //column 1 settings
AL_SetHeaders (xALP_Sections;1;1;__ ("S"))
AL_SetWidths (xALP_Sections;1;1;30)
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
AL_SetWidths (xALP_Sections;2;1;75)
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
AL_SetHeaders (xALP_Sections;4;1;__ ("Sala"))
AL_SetWidths (xALP_Sections;4;1;50)
AL_SetFormat (xALP_Sections;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_Sections;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;4;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Sections;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;4;0)
AL_SetEntryCtls (xALP_Sections;4;0)

  //column 5 settings
AL_SetHeaders (xALP_Sections;5;1;__ ("M"))
AL_SetWidths (xALP_Sections;5;1;30)
AL_SetFormat (xALP_Sections;5;"###0";0;2;0;0)
AL_SetHdrStyle (xALP_Sections;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;5;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;5;"Tahoma";9;0)
AL_SetForeColor (xALP_Sections;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;5;0)
AL_SetEntryCtls (xALP_Sections;5;0)

  //column 6 settings
AL_SetHeaders (xALP_Sections;6;1;__ ("H"))
AL_SetWidths (xALP_Sections;6;1;30)
AL_SetFormat (xALP_Sections;6;"###0";0;2;0;0)
AL_SetHdrStyle (xALP_Sections;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;6;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;6;"Tahoma";9;0)
AL_SetForeColor (xALP_Sections;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;6;0)
AL_SetEntryCtls (xALP_Sections;6;0)

  //column 7 settings
AL_SetHeaders (xALP_Sections;7;1;__ ("Total"))
AL_SetWidths (xALP_Sections;7;1;27)
AL_SetFormat (xALP_Sections;7;"###0";0;2;0;0)
AL_SetHdrStyle (xALP_Sections;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;7;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;7;"Tahoma";9;0)
AL_SetForeColor (xALP_Sections;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;7;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;7;0)
AL_SetEntryCtls (xALP_Sections;7;0)

  //column 8 settings
AL_SetHeaders (xALP_Sections;8;1;__ ("ID"))
AL_SetFormat (xALP_Sections;8;"###0";0;0;0;0)
AL_SetHdrStyle (xALP_Sections;8;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;8;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;8;"Tahoma";9;0)
AL_SetForeColor (xALP_Sections;8;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;8;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;8;1)
AL_SetEntryCtls (xALP_Sections;8;0)

  //column 9 settings
AL_SetHeaders (xALP_Sections;9;1;__ ("secs"))
AL_SetFormat (xALP_Sections;9;"";0;0;0;0)
AL_SetHdrStyle (xALP_Sections;9;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;9;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;9;"Tahoma";9;0)
AL_SetForeColor (xALP_Sections;9;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;9;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;9;1)
AL_SetEntryCtls (xALP_Sections;9;0)

  //column 10 settings
AL_SetHeaders (xALP_Sections;10;1;__ ("ID"))
AL_SetFormat (xALP_Sections;10;"###0";0;0;0;0)
AL_SetHdrStyle (xALP_Sections;10;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Sections;10;"Tahoma";9;0)
AL_SetStyle (xALP_Sections;10;"Tahoma";9;0)
AL_SetForeColor (xALP_Sections;10;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Sections;10;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Sections;10;1)
AL_SetEntryCtls (xALP_Sections;10;0)


  //general options
ALP_SetDefaultAppareance (xALP_Sections;9)
AL_SetColOpts (xALP_Sections;1;1;1;0;0)
AL_SetRowOpts (xALP_Sections;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Sections;0;1;1)
AL_SetMiscOpts (xALP_Sections;0;0;"\\";0;1)
  //AL_SetMiscColor (xALP_Sections;0;"White";0)
  //AL_SetMiscColor (xALP_Sections;1;"White";0)
  //AL_SetMiscColor (xALP_Sections;2;"White";0)
  //AL_SetMiscColor (xALP_Sections;3;"White";0)
AL_SetMainCalls (xALP_Sections;"";"")
AL_SetScroll (xALP_Sections;0;-3)
  //AL_SetCopyOpts (xALP_Sections;0;"\t";"\r";Char(0))
  //AL_SetSortOpts (xALP_Sections;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Sections;1;0;0;1;0;<>tXS_RS_DecimalSeparator)
  //AL_SetHeight (xALP_Sections;1;2;1;1;2)
  //AL_SetDividers (xALP_Sections;"Black";"Gray";0;"Black";"Gray";0)
AL_SetDrgOpts (xALP_Sections;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Sections;1;"";"";"")
AL_SetDrgSrc (xALP_Sections;2;"";"";"")
AL_SetDrgSrc (xALP_Sections;3;"";"";"")
AL_SetDrgSrc (xALP_Sections;1;"";"";"")
AL_SetDrgDst (xALP_Sections;1;"";"";"")
AL_SetDrgDst (xALP_Sections;1;"";"";"")
AL_SetDrgDst (xALP_Sections;1;"";"";"")