//%attributes = {}
  //xALSet_ADT_HorarioEntrevistas

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_IViewTimeTable;1;1;"aTimeIView")
$Error:=AL_SetArraysNam (xALP_IViewTimeTable;2;1;"aD1")
$Error:=AL_SetArraysNam (xALP_IViewTimeTable;3;1;"aD2")
$Error:=AL_SetArraysNam (xALP_IViewTimeTable;4;1;"aD3")
$Error:=AL_SetArraysNam (xALP_IViewTimeTable;5;1;"aD4")
$Error:=AL_SetArraysNam (xALP_IViewTimeTable;6;1;"aD5")

  //column 1 settings
AL_SetHeaders (xALP_IViewTimeTable;1;1;__ ("Hora"))
AL_SetWidths (xALP_IViewTimeTable;1;1;51)
AL_SetFormat (xALP_IViewTimeTable;1;"&/2";2;2;0;0)
AL_SetHdrStyle (xALP_IViewTimeTable;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_IViewTimeTable;1;"Tahoma";9;0)
AL_SetStyle (xALP_IViewTimeTable;1;"Tahoma";9;1)
AL_SetForeColor (xALP_IViewTimeTable;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_IViewTimeTable;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_IViewTimeTable;1;1)
AL_SetEntryCtls (xALP_IViewTimeTable;1;0)

  //column 2 settings
AL_SetHeaders (xALP_IViewTimeTable;2;1;<>atXS_DayNames{2})
AL_SetWidths (xALP_IViewTimeTable;2;1;115)
AL_SetFormat (xALP_IViewTimeTable;2;"";2;2;0;0)
AL_SetHdrStyle (xALP_IViewTimeTable;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_IViewTimeTable;2;"Tahoma";9;0)
AL_SetStyle (xALP_IViewTimeTable;2;"Tahoma";9;0)
AL_SetForeColor (xALP_IViewTimeTable;2;"Black";0;"Light Gray";0;"Black";0)
AL_SetBackColor (xALP_IViewTimeTable;2;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_IViewTimeTable;2;1)
AL_SetEntryCtls (xALP_IViewTimeTable;2;0)

  //column 3 settings
AL_SetHeaders (xALP_IViewTimeTable;3;1;<>atXS_DayNames{3})
AL_SetWidths (xALP_IViewTimeTable;3;1;115)
AL_SetFormat (xALP_IViewTimeTable;3;"";2;2;0;0)
AL_SetHdrStyle (xALP_IViewTimeTable;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_IViewTimeTable;3;"Tahoma";9;0)
AL_SetStyle (xALP_IViewTimeTable;3;"Tahoma";9;0)
AL_SetForeColor (xALP_IViewTimeTable;3;"Black";0;"Light Gray";0;"Black";0)
AL_SetBackColor (xALP_IViewTimeTable;3;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_IViewTimeTable;3;1)
AL_SetEntryCtls (xALP_IViewTimeTable;3;0)

  //column 4 settings
AL_SetHeaders (xALP_IViewTimeTable;4;1;<>atXS_DayNames{4})
AL_SetWidths (xALP_IViewTimeTable;4;1;115)
AL_SetFormat (xALP_IViewTimeTable;4;"";2;2;0;0)
AL_SetHdrStyle (xALP_IViewTimeTable;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_IViewTimeTable;4;"Tahoma";9;0)
AL_SetStyle (xALP_IViewTimeTable;4;"Tahoma";9;0)
AL_SetForeColor (xALP_IViewTimeTable;4;"Black";0;"Light Gray";0;"Black";0)
AL_SetBackColor (xALP_IViewTimeTable;4;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_IViewTimeTable;4;1)
AL_SetEntryCtls (xALP_IViewTimeTable;4;0)

  //column 5 settings
AL_SetHeaders (xALP_IViewTimeTable;5;1;<>atXS_DayNames{5})
AL_SetWidths (xALP_IViewTimeTable;5;1;115)
AL_SetFormat (xALP_IViewTimeTable;5;"";2;2;0;0)
AL_SetHdrStyle (xALP_IViewTimeTable;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_IViewTimeTable;5;"Tahoma";9;0)
AL_SetStyle (xALP_IViewTimeTable;5;"Tahoma";9;0)
AL_SetForeColor (xALP_IViewTimeTable;5;"Black";0;"Light Gray";0;"Black";0)
AL_SetBackColor (xALP_IViewTimeTable;5;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_IViewTimeTable;5;1)
AL_SetEntryCtls (xALP_IViewTimeTable;5;0)

  //column 6 settings
AL_SetHeaders (xALP_IViewTimeTable;6;1;<>atXS_DayNames{6})
AL_SetWidths (xALP_IViewTimeTable;6;1;115)
AL_SetFormat (xALP_IViewTimeTable;6;"";2;2;0;1)
AL_SetHdrStyle (xALP_IViewTimeTable;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_IViewTimeTable;6;"Tahoma";9;0)
AL_SetStyle (xALP_IViewTimeTable;6;"Tahoma";9;0)
AL_SetForeColor (xALP_IViewTimeTable;6;"Black";0;"Light Gray";0;"Black";0)
AL_SetBackColor (xALP_IViewTimeTable;6;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_IViewTimeTable;6;1)
AL_SetEntryCtls (xALP_IViewTimeTable;6;0)

  //general options
ALP_SetDefaultAppareance (xALP_IViewTimeTable;9;2;6;2;8)
AL_SetColOpts (xALP_IViewTimeTable;1;1;1;0;0)
AL_SetRowOpts (xALP_IViewTimeTable;0;0;0;0;1;0)
AL_SetCellOpts (xALP_IViewTimeTable;2;1;1)
AL_SetMiscOpts (xALP_IViewTimeTable;0;0;"\\";0;1)
AL_SetMainCalls (xALP_IViewTimeTable;"";"")
AL_SetScroll (xALP_IViewTimeTable;0;-3)
AL_SetEntryOpts (xALP_IViewTimeTable;1;0;0;1;0;<>tXS_RS_DecimalSeparator)
  //AL_SetHeight (xALP_IViewTimeTable;2;2;2;1;2)
  //AL_SetDividers (xALP_IViewTimeTable;"Black";"Gray";0;"Black";"Gray";0)
AL_SetDrgOpts (xALP_IViewTimeTable;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_IViewTimeTable;1;"";"";"")
AL_SetDrgSrc (xALP_IViewTimeTable;2;"";"";"")
AL_SetDrgSrc (xALP_IViewTimeTable;3;"";"";"")
AL_SetDrgDst (xALP_IViewTimeTable;1;"";"";"")
AL_SetDrgDst (xALP_IViewTimeTable;1;"";"";"")
AL_SetDrgDst (xALP_IViewTimeTable;1;"";"";"")

