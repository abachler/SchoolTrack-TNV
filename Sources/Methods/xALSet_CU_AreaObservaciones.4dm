//%attributes = {}
  //xALSet_CU_AreaObservaciones

  //Configuration commands for ALP object 'xAL_comment'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_COMMENT;1;1;"aText1")
$Error:=AL_SetArraysNam (xALP_COMMENT;2;1;"aText2")
$Error:=AL_SetArraysNam (xALP_COMMENT;3;1;"aText3")
$Error:=AL_SetArraysNam (xALP_COMMENT;4;1;"aText4")
$Error:=AL_SetArraysNam (xALP_COMMENT;5;1;"aText5")
$Error:=AL_SetArraysNam (xALP_COMMENT;6;1;"aText5")
$Error:=AL_SetArraysNam (xALP_COMMENT;7;1;"aLong1")

  //column 1 settings
AL_SetHeaders (xALP_COMMENT;1;1;__ ("Alumno"))
AL_SetWidths (xALP_COMMENT;1;1;100)
AL_SetFormat (xALP_COMMENT;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_COMMENT;1;"tahoma";9;1)
AL_SetFtrStyle (xALP_COMMENT;1;"tahoma";9;0)
AL_SetStyle (xALP_COMMENT;1;"tahoma";9;0)
AL_SetForeColor (xALP_COMMENT;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_COMMENT;1;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_COMMENT;1;0)
AL_SetEntryCtls (xALP_COMMENT;1;0)

  //column 2 settings
AL_SetHeaders (xALP_COMMENT;2;1;__ ("Observaciones finales"))
AL_SetWidths (xALP_COMMENT;2;1;230)
AL_SetFormat (xALP_COMMENT;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_COMMENT;2;"tahoma";9;1)
AL_SetFtrStyle (xALP_COMMENT;2;"tahoma";9;0)
AL_SetStyle (xALP_COMMENT;2;"tahoma";9;0)
AL_SetForeColor (xALP_COMMENT;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_COMMENT;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_COMMENT;2;1)
AL_SetEntryCtls (xALP_COMMENT;2;0)

  //column 3 settings
AL_SetHeaders (xALP_COMMENT;3;1;__ ("1er Período"))
AL_SetWidths (xALP_COMMENT;3;1;230)
AL_SetFormat (xALP_COMMENT;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_COMMENT;3;"tahoma";9;1)
AL_SetFtrStyle (xALP_COMMENT;3;"tahoma";9;0)
AL_SetStyle (xALP_COMMENT;3;"tahoma";9;0)
AL_SetForeColor (xALP_COMMENT;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_COMMENT;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_COMMENT;3;1)
AL_SetEntryCtls (xALP_COMMENT;3;0)

  //column 4 settings
AL_SetHeaders (xALP_COMMENT;4;1;__ ("2do Periodo"))
AL_SetWidths (xALP_COMMENT;4;1;250)
AL_SetFormat (xALP_COMMENT;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_COMMENT;4;"tahoma";9;1)
AL_SetFtrStyle (xALP_COMMENT;4;"tahoma";9;0)
AL_SetStyle (xALP_COMMENT;4;"tahoma";9;0)
AL_SetForeColor (xALP_COMMENT;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_COMMENT;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_COMMENT;4;1)
AL_SetEntryCtls (xALP_COMMENT;4;0)

  //column 5 settings
AL_SetHeaders (xALP_COMMENT;5;1;__ ("3er Período"))
AL_SetWidths (xALP_COMMENT;5;1;250)
AL_SetFormat (xALP_COMMENT;5;"";0;0;0;0)
AL_SetHdrStyle (xALP_COMMENT;5;"tahoma";9;1)
AL_SetFtrStyle (xALP_COMMENT;5;"tahoma";9;0)
AL_SetStyle (xALP_COMMENT;5;"tahoma";9;0)
AL_SetForeColor (xALP_COMMENT;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_COMMENT;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_COMMENT;5;1)
AL_SetEntryCtls (xALP_COMMENT;5;0)

  //column 6 settings
AL_SetHeaders (xALP_COMMENT;6;1;__ ("4to periodo"))
AL_SetWidths (xALP_COMMENT;6;1;250)
AL_SetFormat (xALP_COMMENT;6;"";0;0;0;0)
AL_SetHdrStyle (xALP_COMMENT;6;"tahoma";9;1)
AL_SetFtrStyle (xALP_COMMENT;6;"tahoma";9;0)
AL_SetStyle (xALP_COMMENT;6;"tahoma";9;0)
AL_SetForeColor (xALP_COMMENT;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_COMMENT;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_COMMENT;6;1)
AL_SetEntryCtls (xALP_COMMENT;6;0)

  //column 7 settings
AL_SetHeaders (xALP_COMMENT;7;1;"Record number")
AL_SetFormat (xALP_COMMENT;7;"";0;0;0;0)
AL_SetHdrStyle (xALP_COMMENT;7;"tahoma";9;1)
AL_SetFtrStyle (xALP_COMMENT;7;"tahoma";9;0)
AL_SetStyle (xALP_COMMENT;7;"tahoma";9;0)
AL_SetForeColor (xALP_COMMENT;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_COMMENT;7;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_COMMENT;7;1)
AL_SetEntryCtls (xALP_COMMENT;7;0)

  //general options

AL_SetColOpts (xALP_COMMENT;1;1;1;0;0)
AL_SetRowOpts (xALP_COMMENT;0;1;0;0;1;0)
AL_SetCellOpts (xALP_COMMENT;0;1;1)
AL_SetMiscOpts (xALP_COMMENT;0;0;"\\";0;1)
AL_SetMiscColor (xALP_COMMENT;0;"White";0)
AL_SetMiscColor (xALP_COMMENT;1;"White";0)
AL_SetMiscColor (xALP_COMMENT;2;"White";0)
AL_SetMiscColor (xALP_COMMENT;3;"White";0)
AL_SetMainCalls (xALP_COMMENT;"";"AS_CommentsAreaExit")
AL_SetScroll (xALP_COMMENT;0;0)
AL_SetCopyOpts (xALP_COMMENT;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_COMMENT;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_COMMENT;2;1;0;0;2;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_COMMENT;1;2;3;1;2)
AL_SetDividers (xALP_COMMENT;"Black";"Black";0;"Black";"Gray";0)
AL_SetColLock (xALP_COMMENT;1)
AL_SetDrgOpts (xALP_COMMENT;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_COMMENT;1;"";"";"")
AL_SetDrgSrc (xALP_COMMENT;2;"";"";"")
AL_SetDrgSrc (xALP_COMMENT;3;"";"";"")
AL_SetDrgDst (xALP_COMMENT;1;"";"";"")
AL_SetDrgDst (xALP_COMMENT;1;"";"";"")
AL_SetDrgDst (xALP_COMMENT;1;"";"";"")

