//%attributes = {}
  //xALSet_BBL_LectorInfoAreas

  //Configuration commands for ALP object 'xALP_loans'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_loans;1;1;"aDate1")
$Error:=AL_SetArraysNam (xALP_loans;2;1;"aText1")
$Error:=AL_SetArraysNam (xALP_loans;3;1;"aText2")
$Error:=AL_SetArraysNam (xALP_loans;4;1;"aText3")
$Error:=AL_SetArraysNam (xALP_loans;5;1;"aLong1")
$Error:=AL_SetArraysNam (xALP_loans;6;1;"aDate2")
$Error:=AL_SetArraysNam (xALP_loans;7;1;"aLong2")
$Error:=AL_SetArraysNam (xALP_loans;8;1;"aText4")

  //column 1 settings
AL_SetHeaders (xALP_loans;1;1;__ ("Hasta el"))
AL_SetFormat (xALP_loans;1;"00/00/0000";0;0;0;0)
AL_SetHdrStyle (xALP_loans;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_loans;1;"Tahoma";9;0)
AL_SetStyle (xALP_loans;1;"Tahoma";9;0)
AL_SetForeColor (xALP_loans;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_loans;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_loans;1;1)
AL_SetEntryCtls (xALP_loans;1;0)

  //column 2 settings
AL_SetHeaders (xALP_loans;2;1;__ ("Clasificación"))
AL_SetFormat (xALP_loans;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_loans;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_loans;2;"Tahoma";9;0)
AL_SetStyle (xALP_loans;2;"Tahoma";9;0)
AL_SetForeColor (xALP_loans;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_loans;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_loans;2;1)
AL_SetEntryCtls (xALP_loans;2;0)

  //column 3 settings
AL_SetHeaders (xALP_loans;3;1;__ ("Título"))
AL_SetFormat (xALP_loans;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_loans;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_loans;3;"Tahoma";9;0)
AL_SetStyle (xALP_loans;3;"Tahoma";9;0)
AL_SetForeColor (xALP_loans;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_loans;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_loans;3;1)
AL_SetEntryCtls (xALP_loans;3;0)

  //column 4 settings
AL_SetHeaders (xALP_loans;4;1;__ ("Autor"))
AL_SetFormat (xALP_loans;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_loans;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_loans;4;"Tahoma";9;0)
AL_SetStyle (xALP_loans;4;"Tahoma";9;0)
AL_SetForeColor (xALP_loans;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_loans;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_loans;4;1)
AL_SetEntryCtls (xALP_loans;4;0)

  //column 5 settings
AL_SetHeaders (xALP_loans;5;1;__ ("Nº de registro"))
AL_SetFormat (xALP_loans;5;"##########";0;0;0;0)
AL_SetHdrStyle (xALP_loans;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_loans;5;"Tahoma";9;0)
AL_SetStyle (xALP_loans;5;"Tahoma";9;0)
AL_SetForeColor (xALP_loans;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_loans;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_loans;5;1)
AL_SetEntryCtls (xALP_loans;5;0)

  //column 6 settings
AL_SetHeaders (xALP_loans;6;1;__ ("Fecha devolución"))
AL_SetFormat (xALP_loans;6;"";0;0;0;0)
AL_SetHdrStyle (xALP_loans;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_loans;6;"Tahoma";9;0)
AL_SetStyle (xALP_loans;6;"Tahoma";9;0)
AL_SetForeColor (xALP_loans;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_loans;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_loans;6;1)
AL_SetEntryCtls (xALP_loans;6;0)

  //column 7 settings
AL_SetHeaders (xALP_loans;7;1;"Record Number")
AL_SetFormat (xALP_loans;7;"";0;0;0;0)
AL_SetHdrStyle (xALP_loans;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_loans;7;"Tahoma";9;0)
AL_SetStyle (xALP_loans;7;"Tahoma";9;0)
AL_SetForeColor (xALP_loans;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_loans;7;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_loans;7;1)
AL_SetEntryCtls (xALP_loans;7;0)

  //column 8 settings
AL_SetHeaders (xALP_loans;8;1;"Status")
AL_SetFormat (xALP_loans;8;"";0;0;0;0)
AL_SetHdrStyle (xALP_loans;8;"Tahoma";9;1)
AL_SetFtrStyle (xALP_loans;8;"Tahoma";9;0)
AL_SetStyle (xALP_loans;8;"Tahoma";9;0)
AL_SetForeColor (xALP_loans;8;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_loans;8;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_loans;8;1)
AL_SetEntryCtls (xALP_loans;8;0)

  //general options

AL_SetColOpts (xALP_loans;1;1;0;3;0)
AL_SetRowOpts (xALP_loans;0;1;0;0;1;0)
AL_SetCellOpts (xALP_loans;0;1;1)
AL_SetMiscOpts (xALP_loans;0;0;"\\";0;1)
AL_SetMiscColor (xALP_loans;0;"White";0)
AL_SetMiscColor (xALP_loans;1;"White";0)
AL_SetMiscColor (xALP_loans;2;"White";0)
AL_SetMiscColor (xALP_loans;3;"White";0)
AL_SetMainCalls (xALP_loans;"";"")
AL_SetScroll (xALP_loans;0;0)
AL_SetCopyOpts (xALP_loans;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_loans;1;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_loans;1;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_loans;1;2;1;1;2)
AL_SetDividers (xALP_loans;"No line";"Black";0;"No line";"Black";0)
AL_SetDrgOpts (xALP_loans;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_loans;1;"";"";"")
AL_SetDrgSrc (xALP_loans;2;"";"";"")
AL_SetDrgSrc (xALP_loans;3;"";"";"")
AL_SetDrgDst (xALP_loans;1;"";"";"")
AL_SetDrgDst (xALP_loans;1;"";"";"")
AL_SetDrgDst (xALP_loans;1;"";"";"")


ALP_SetDefaultAppareance (xALP_loans)
