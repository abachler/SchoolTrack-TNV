//%attributes = {}
  //xALSet_ADT_InscripJInfantil

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Postulantes;1;1;"atPST_CandidateName")
$Error:=AL_SetArraysNam (xALP_Postulantes;2;1;"alPst_CandidateRecNum")

  //column 1 settings
AL_SetHeaders (xALP_Postulantes;1;1;__ ("Nombre"))
AL_SetWidths (xALP_Postulantes;1;1;180)
AL_SetFormat (xALP_Postulantes;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Postulantes;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Postulantes;1;"Tahoma";9;0)
AL_SetStyle (xALP_Postulantes;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Postulantes;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Postulantes;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Postulantes;1;1)
AL_SetEntryCtls (xALP_Postulantes;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Postulantes;2;1;"recNum")
AL_SetFormat (xALP_Postulantes;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Postulantes;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Postulantes;2;"Tahoma";9;0)
AL_SetStyle (xALP_Postulantes;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Postulantes;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Postulantes;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Postulantes;2;1)
AL_SetEntryCtls (xALP_Postulantes;2;0)

  //general options
ALP_SetDefaultAppareance (xALP_Postulantes;9;1;6;1;8)
AL_SetColOpts (xALP_Postulantes;1;1;1;1;0)
AL_SetRowOpts (xALP_Postulantes;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Postulantes;0;1;1)
AL_SetMiscOpts (xALP_Postulantes;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Postulantes;"";"")
AL_SetScroll (xALP_Postulantes;0;-3)
AL_SetEntryOpts (xALP_Postulantes;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Postulantes;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Postulantes;1;"Candidates";"";"")
AL_SetDrgSrc (xALP_Postulantes;2;"";"";"")
AL_SetDrgSrc (xALP_Postulantes;3;"";"";"")
AL_SetDrgDst (xALP_Postulantes;1;"PlayGroup";"";"")
AL_SetDrgDst (xALP_Postulantes;1;"";"";"")
AL_SetDrgDst (xALP_Postulantes;1;"";"";"")


C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_PlayGroup;1;1;"atPST_JFName")
$Error:=AL_SetArraysNam (xALP_PlayGroup;2;1;"atPST_JFClass")
$Error:=AL_SetArraysNam (xALP_PlayGroup;3;1;"alPST_JFRecNum")

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
AL_SetHeaders (xALP_PlayGroup;2;1;__ ("Curso"))
AL_SetWidths (xALP_PlayGroup;2;1;50)
AL_SetFormat (xALP_PlayGroup;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_PlayGroup;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_PlayGroup;2;"Tahoma";9;0)
AL_SetStyle (xALP_PlayGroup;2;"Tahoma";9;0)
AL_SetForeColor (xALP_PlayGroup;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PlayGroup;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_PlayGroup;2;1)
AL_SetEntryCtls (xALP_PlayGroup;2;0)

  //column 3 settings
AL_SetHeaders (xALP_PlayGroup;3;1;"RecNum")
AL_SetFormat (xALP_PlayGroup;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_PlayGroup;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_PlayGroup;3;"Tahoma";9;0)
AL_SetStyle (xALP_PlayGroup;3;"Tahoma";9;0)
AL_SetForeColor (xALP_PlayGroup;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PlayGroup;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_PlayGroup;3;1)
AL_SetEntryCtls (xALP_PlayGroup;3;0)

  //general options
ALP_SetDefaultAppareance (xALP_PlayGroup;9;1;6;1;8)
AL_SetColOpts (xALP_PlayGroup;1;1;1;1;0)
AL_SetRowOpts (xALP_PlayGroup;0;0;0;0;1;0)
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


