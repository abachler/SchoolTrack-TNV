//%attributes = {}
  //xALSet_CU_AreaFirmasActas

  //specify arrays to display

$Error:=AL_SetArraysNam (xALP_Firmas;1;1;"aAsg")
$Error:=AL_SetArraysNam (xALP_Firmas;2;1;"aPrfNam")
$Error:=AL_SetArraysNam (xALP_Firmas;3;1;"aPrfAut")
$Error:=AL_SetArraysNam (xALP_Firmas;4;1;"aRUNProfesor")
$Error:=AL_SetArraysNam (xALP_Firmas;5;1;"aStringPrfID")
$Error:=AL_SetArraysNam (xALP_Firmas;6;1;"aAsgCode")

  //column 1 settings
AL_SetHeaders (xALP_Firmas;1;1;__ ("Asignatura"))
AL_SetWidths (xALP_Firmas;1;1;120)
AL_SetFormat (xALP_Firmas;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Firmas;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Firmas;1;"Tahoma";9;0)
AL_SetStyle (xALP_Firmas;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Firmas;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Firmas;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Firmas;1;0)
AL_SetEntryCtls (xALP_Firmas;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Firmas;2;1;__ ("Firmante(s)"))
AL_SetWidths (xALP_Firmas;2;1;180)
AL_SetFormat (xALP_Firmas;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Firmas;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Firmas;2;"Tahoma";9;0)
AL_SetStyle (xALP_Firmas;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Firmas;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Firmas;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Firmas;2;0)
AL_SetEntryCtls (xALP_Firmas;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Firmas;3;1;__ ("Autorización"))
AL_SetWidths (xALP_Firmas;3;1;220)
AL_SetFormat (xALP_Firmas;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_Firmas;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Firmas;3;"Tahoma";9;0)
AL_SetStyle (xALP_Firmas;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Firmas;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Firmas;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Firmas;3;1)
AL_SetEntryCtls (xALP_Firmas;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Firmas;4;1;__ ("RUN"))
AL_SetWidths (xALP_Firmas;4;1;60)
AL_SetFormat (xALP_Firmas;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_Firmas;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Firmas;4;"Tahoma";9;0)
AL_SetStyle (xALP_Firmas;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Firmas;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Firmas;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Firmas;4;0)
AL_SetEntryCtls (xALP_Firmas;4;0)

  //general options
ALP_SetDefaultAppareance (xALP_Firmas;9;1;4;1;2)
AL_SetColOpts (xALP_Firmas;1;1;1;3;0)
AL_SetRowOpts (xALP_Firmas;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Firmas;1;1;1)
AL_SetMainCalls (xALP_Firmas;"";"")
AL_SetCallbacks (xALP_Firmas;"";"xALCB_EX_Default")
AL_SetScroll (xALP_Firmas;0;-3)
AL_SetEntryOpts (xALP_Firmas;3;1;0;0;1;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Firmas;0;1;0)
  //AL_SetColLock (xAL_Firmas;2)

  //dragging options

AL_SetDrgSrc (xALP_Firmas;1;"";"";"")
AL_SetDrgSrc (xALP_Firmas;2;"";"";"")
AL_SetDrgSrc (xALP_Firmas;3;"";"";"")
AL_SetDrgDst (xALP_Firmas;1;"";"";"")
AL_SetDrgDst (xALP_Firmas;1;"";"";"")
AL_SetDrgDst (xALP_Firmas;1;"Firmantes";"";"")

C_LONGINT:C283($Error)

  //specify fields to display
$Error:=AL_SetFile (xALP_teachers;Table:C252(->[Profesores:4]))  //[Profesores]
$Error:=AL_SetFields (xALP_teachers;4;1;1;21)  //[Profesores]Nombre_común

  //column 1 settings
AL_SetHeaders (xALP_teachers;1;1;__ ("Profesores"))
AL_SetFormat (xALP_teachers;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_teachers;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_teachers;1;"Tahoma";9;0)
AL_SetStyle (xALP_teachers;1;"Tahoma";9;0)
AL_SetForeColor (xALP_teachers;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_teachers;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_teachers;1;0)
AL_SetEntryCtls (xALP_teachers;1;0)

  //general options
ALP_SetDefaultAppareance (xALP_teachers;9;1;4;1;6)
AL_SetColOpts (xALP_teachers;1;1;1;0;0)
AL_SetRowOpts (xALP_teachers;0;0;0;0;1;0)
AL_SetCellOpts (xALP_teachers;1;1;1)
AL_SetMiscOpts (xALP_teachers;0;0;"\\";0;1)
AL_SetMainCalls (xALP_teachers;"";"")
AL_SetScroll (xALP_teachers;0;-3)
AL_SetEntryOpts (xALP_teachers;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_teachers;0;30;1)

  //dragging options

AL_SetDrgSrc (xALP_teachers;1;"";"";"")
AL_SetDrgSrc (xALP_teachers;2;"";"";"")
AL_SetDrgSrc (xALP_teachers;3;"Firmantes";"";"")
AL_SetDrgDst (xALP_teachers;1;"";"";"")
AL_SetDrgDst (xALP_teachers;1;"";"";"")
AL_SetDrgDst (xALP_teachers;1;"";"";"")