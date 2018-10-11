//%attributes = {}
  //ADT_xALSet_Configuracion

  //Configuration commands for ALP object 'xALP_ExaminationsGroups'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_ExaminationsGroups;1;1;"aiPst_GroupID")
$Error:=AL_SetArraysNam (xALP_ExaminationsGroups;2;1;"atPST_GroupName")
$Error:=AL_SetArraysNam (xALP_ExaminationsGroups;3;1;"adPST_FromDate")
$Error:=AL_SetArraysNam (xALP_ExaminationsGroups;4;1;"adPST_ToDate")
$Error:=AL_SetArraysNam (xALP_ExaminationsGroups;5;1;"aiPST_Candidates")
$Error:=AL_SetArraysNam (xALP_ExaminationsGroups;6;1;"aiPST_ExamTime")

  //column 1 settings
AL_SetHeaders (xALP_ExaminationsGroups;1;1;__ ("Nº"))
AL_SetWidths (xALP_ExaminationsGroups;1;1;16)
AL_SetFormat (xALP_ExaminationsGroups;1;"###";0;0;0;0)
AL_SetHdrStyle (xALP_ExaminationsGroups;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ExaminationsGroups;1;"Tahoma";9;0)
AL_SetStyle (xALP_ExaminationsGroups;1;"Tahoma";9;0)
AL_SetForeColor (xALP_ExaminationsGroups;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ExaminationsGroups;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ExaminationsGroups;1;0)
AL_SetEntryCtls (xALP_ExaminationsGroups;1;0)

  //column 2 settings
AL_SetHeaders (xALP_ExaminationsGroups;2;1;__ ("Nombre del grupo"))
AL_SetFormat (xALP_ExaminationsGroups;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_ExaminationsGroups;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ExaminationsGroups;2;"Tahoma";9;0)
AL_SetStyle (xALP_ExaminationsGroups;2;"Tahoma";9;0)
AL_SetForeColor (xALP_ExaminationsGroups;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ExaminationsGroups;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ExaminationsGroups;2;1)
AL_SetEntryCtls (xALP_ExaminationsGroups;2;0)

  //column 3 settings
AL_SetHeaders (xALP_ExaminationsGroups;3;1;__ ("Desde el"))
AL_SetWidths (xALP_ExaminationsGroups;3;1;65)
AL_SetFormat (xALP_ExaminationsGroups;3;"00/00/0000";0;0;0;0)
AL_SetHdrStyle (xALP_ExaminationsGroups;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ExaminationsGroups;3;"Tahoma";9;0)
AL_SetStyle (xALP_ExaminationsGroups;3;"Tahoma";9;0)
AL_SetForeColor (xALP_ExaminationsGroups;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ExaminationsGroups;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ExaminationsGroups;3;1)
AL_SetEntryCtls (xALP_ExaminationsGroups;3;0)

  //column 4 settings
AL_SetHeaders (xALP_ExaminationsGroups;4;1;__ ("Hasta el"))
AL_SetWidths (xALP_ExaminationsGroups;4;1;65)
AL_SetFormat (xALP_ExaminationsGroups;4;"00/00/0000";0;0;0;0)
AL_SetHdrStyle (xALP_ExaminationsGroups;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ExaminationsGroups;4;"Tahoma";9;0)
AL_SetStyle (xALP_ExaminationsGroups;4;"Tahoma";9;0)
AL_SetForeColor (xALP_ExaminationsGroups;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ExaminationsGroups;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ExaminationsGroups;4;1)
AL_SetEntryCtls (xALP_ExaminationsGroups;4;0)

  //column 5 settings
AL_SetHeaders (xALP_ExaminationsGroups;5;1;__ ("Inscritos"))
AL_SetWidths (xALP_ExaminationsGroups;5;1;60)
AL_SetFormat (xALP_ExaminationsGroups;5;"####";0;0;0;0)
AL_SetHdrStyle (xALP_ExaminationsGroups;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ExaminationsGroups;5;"Tahoma";9;0)
AL_SetStyle (xALP_ExaminationsGroups;5;"Tahoma";9;0)
AL_SetForeColor (xALP_ExaminationsGroups;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ExaminationsGroups;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ExaminationsGroups;5;0)
AL_SetEntryCtls (xALP_ExaminationsGroups;5;0)

  //column 6 settings
AL_SetHeaders (xALP_ExaminationsGroups;6;1;__ ("Hora Ex."))
AL_SetFormat (xALP_ExaminationsGroups;6;"&/2";0;0;0;0)
AL_SetHdrStyle (xALP_ExaminationsGroups;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ExaminationsGroups;6;"Tahoma";9;0)
AL_SetStyle (xALP_ExaminationsGroups;6;"Tahoma";9;0)
AL_SetForeColor (xALP_ExaminationsGroups;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ExaminationsGroups;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ExaminationsGroups;6;1)
AL_SetEntryCtls (xALP_ExaminationsGroups;6;0)

  //general options

AL_SetColOpts (xALP_ExaminationsGroups;1;1;1;0;0)
AL_SetRowOpts (xALP_ExaminationsGroups;0;0;0;0;1;0)
AL_SetCellOpts (xALP_ExaminationsGroups;0;1;1)
AL_SetMiscOpts (xALP_ExaminationsGroups;0;0;"\\";0;1)
AL_SetMiscColor (xALP_ExaminationsGroups;0;"White";0)
AL_SetMiscColor (xALP_ExaminationsGroups;1;"White";0)
AL_SetMiscColor (xALP_ExaminationsGroups;2;"White";0)
AL_SetMiscColor (xALP_ExaminationsGroups;3;"White";0)
AL_SetMainCalls (xALP_ExaminationsGroups;"";"")
AL_SetScroll (xALP_ExaminationsGroups;0;0)
AL_SetCopyOpts (xALP_ExaminationsGroups;0;"\t";"\r")
AL_SetSortOpts (xALP_ExaminationsGroups;1;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_ExaminationsGroups;3;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_ExaminationsGroups;1;2;1;1;2)
AL_SetDividers (xALP_ExaminationsGroups;"Black";"Gray";0;"Black";"Gray";0)
AL_SetDrgOpts (xALP_ExaminationsGroups;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_ExaminationsGroups;1;"";"";"")
AL_SetDrgSrc (xALP_ExaminationsGroups;2;"";"";"")
AL_SetDrgSrc (xALP_ExaminationsGroups;3;"";"";"")
AL_SetDrgDst (xALP_ExaminationsGroups;1;"";"";"")
AL_SetDrgDst (xALP_ExaminationsGroups;1;"";"";"")
AL_SetDrgDst (xALP_ExaminationsGroups;1;"";"";"")




  //Configuration commands for ALP object 'xALP_Presentations'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Presentations;1;1;"adPST_PresentDate")
$Error:=AL_SetArraysNam (xALP_Presentations;2;1;"aLPST_PresentTime")
$Error:=AL_SetArraysNam (xALP_Presentations;3;1;"aiPST_Asistentes")

  //column 1 settings
AL_SetHeaders (xALP_Presentations;1;1;__ ("Fecha"))
AL_SetWidths (xALP_Presentations;1;1;120)
AL_SetFormat (xALP_Presentations;1;"00/00/0000";0;0;0;0)
AL_SetHdrStyle (xALP_Presentations;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Presentations;1;"Tahoma";9;0)
AL_SetStyle (xALP_Presentations;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Presentations;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Presentations;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Presentations;1;3)
AL_SetEntryCtls (xALP_Presentations;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Presentations;2;1;__ ("Hora"))
AL_SetWidths (xALP_Presentations;2;1;60)
AL_SetFormat (xALP_Presentations;2;"&/2";0;0;0;0)
AL_SetHdrStyle (xALP_Presentations;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Presentations;2;"Tahoma";9;0)
AL_SetStyle (xALP_Presentations;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Presentations;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Presentations;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Presentations;2;1)
AL_SetEntryCtls (xALP_Presentations;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Presentations;3;1;__ ("Asistentes"))
AL_SetWidths (xALP_Presentations;3;1;80)
AL_SetFormat (xALP_Presentations;3;"####";0;0;0;0)
AL_SetHdrStyle (xALP_Presentations;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Presentations;3;"Tahoma";9;0)
AL_SetStyle (xALP_Presentations;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Presentations;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Presentations;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Presentations;3;0)
AL_SetEntryCtls (xALP_Presentations;3;0)

  //general options

AL_SetColOpts (xALP_Presentations;1;1;1;0;0)
AL_SetRowOpts (xALP_Presentations;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Presentations;0;1;1)
AL_SetMiscOpts (xALP_Presentations;0;0;"\\";0;1)
AL_SetMiscColor (xALP_Presentations;0;"White";0)
AL_SetMiscColor (xALP_Presentations;1;"White";0)
AL_SetMiscColor (xALP_Presentations;2;"White";0)
AL_SetMiscColor (xALP_Presentations;3;"White";0)
AL_SetMainCalls (xALP_Presentations;"";"")
AL_SetScroll (xALP_Presentations;0;-3)
AL_SetCopyOpts (xALP_Presentations;0;"\t";"\r")
AL_SetSortOpts (xALP_Presentations;1;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Presentations;3;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_Presentations;1;2;1;1;2)
AL_SetDividers (xALP_Presentations;"Black";"Gray";0;"Black";"Gray";0)
AL_SetDrgOpts (xALP_Presentations;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Presentations;1;"";"";"")
AL_SetDrgSrc (xALP_Presentations;2;"";"";"")
AL_SetDrgSrc (xALP_Presentations;3;"";"";"")
AL_SetDrgDst (xALP_Presentations;1;"";"";"")
AL_SetDrgDst (xALP_Presentations;1;"";"";"")
AL_SetDrgDst (xALP_Presentations;1;"";"";"")




  //Configuration commands for ALP object 'xALP_Exams'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify fields to display
$Error:=AL_SetFile (xALP_Exams;Table:C252(->[ADT_SesionesDeExamenes:123]))  //[ADT_SesionesDeExamenes]
$Error:=AL_SetFields (xALP_Exams;123;1;1;2)  //[ADT_SesionesDeExamenes]Date_Session
$Error:=AL_SetFields (xALP_Exams;123;2;1;4)  //[ADT_SesionesDeExamenes]Attendance
$Error:=AL_SetFields (xALP_Exams;123;3;1;5)  //[ADT_SesionesDeExamenes]ReservedPG
$Error:=AL_SetFields (xALP_Exams;123;4;1;3)  //[ADT_SesionesDeExamenes]Place
$Error:=AL_SetFields (xALP_Exams;123;5;1;1)  //[ADT_SesionesDeExamenes]ID

  //column 1 settings
AL_SetHeaders (xALP_Exams;1;1;__ ("Fecha"))
AL_SetWidths (xALP_Exams;1;1;70)
AL_SetFormat (xALP_Exams;1;"7";0;0;0;0)
AL_SetHdrStyle (xALP_Exams;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Exams;1;"Tahoma";9;0)
AL_SetStyle (xALP_Exams;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Exams;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Exams;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Exams;1;1)
AL_SetEntryCtls (xALP_Exams;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Exams;2;1;__ ("No."))
AL_SetWidths (xALP_Exams;2;1;30)
AL_SetFormat (xALP_Exams;2;"###0";0;0;0;0)
AL_SetHdrStyle (xALP_Exams;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Exams;2;"Tahoma";9;0)
AL_SetStyle (xALP_Exams;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Exams;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Exams;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Exams;2;0)
AL_SetEntryCtls (xALP_Exams;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Exams;3;1;__ ("Solo J. Inf."))
AL_SetWidths (xALP_Exams;3;1;70)
AL_SetFormat (xALP_Exams;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_Exams;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Exams;3;"Tahoma";9;0)
AL_SetStyle (xALP_Exams;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Exams;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Exams;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Exams;3;1)
AL_SetEntryCtls (xALP_Exams;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Exams;4;1;__ ("Lugar"))
AL_SetWidths (xALP_Exams;4;1;146)
AL_SetFormat (xALP_Exams;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_Exams;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Exams;4;"Tahoma";9;0)
AL_SetStyle (xALP_Exams;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Exams;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Exams;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Exams;4;1)
AL_SetEntryCtls (xALP_Exams;4;0)

  //column 5 settings
AL_SetHeaders (xALP_Exams;5;1;"id")
AL_SetFormat (xALP_Exams;5;"";0;0;0;0)
AL_SetHdrStyle (xALP_Exams;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Exams;5;"Tahoma";9;0)
AL_SetStyle (xALP_Exams;5;"Tahoma";9;0)
AL_SetForeColor (xALP_Exams;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Exams;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Exams;5;1)
AL_SetEntryCtls (xALP_Exams;5;0)

  //general options

AL_SetColOpts (xALP_Exams;1;1;1;1;0)
AL_SetRowOpts (xALP_Exams;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Exams;0;1;1)
AL_SetMiscOpts (xALP_Exams;0;0;"\\";0;1)
AL_SetMiscColor (xALP_Exams;0;"White";0)
AL_SetMiscColor (xALP_Exams;1;"White";0)
AL_SetMiscColor (xALP_Exams;2;"White";0)
AL_SetMiscColor (xALP_Exams;3;"White";0)
AL_SetMainCalls (xALP_Exams;"";"")
AL_SetScroll (xALP_Exams;0;-3)
AL_SetCopyOpts (xALP_Exams;0;"\t";"\r")
AL_SetSortOpts (xALP_Exams;1;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Exams;3;0;0;1;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_Exams;1;2;1;1;2)
AL_SetDividers (xALP_Exams;"Black";"Gray";0;"Black";"Gray";0)
AL_SetDrgOpts (xALP_Exams;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Exams;1;"";"";"")
AL_SetDrgSrc (xALP_Exams;2;"";"";"")
AL_SetDrgSrc (xALP_Exams;3;"";"";"")
AL_SetDrgDst (xALP_Exams;1;"";"";"")
AL_SetDrgDst (xALP_Exams;1;"";"";"")
AL_SetDrgDst (xALP_Exams;1;"";"";"")

