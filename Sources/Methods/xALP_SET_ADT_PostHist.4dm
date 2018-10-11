//%attributes = {}
  //xALP_SET_ADT_PostHist

$error:=AL_SetArraysNam (xALP_PostHist;1;1;"atADT_ApeyNombPH")
$error:=AL_SetArraysNam (xALP_PostHist;2;1;"asADT_RUTPH")
$error:=AL_SetArraysNam (xALP_PostHist;3;1;"adADT_FechaInsPH")
$error:=AL_SetArraysNam (xALP_PostHist;4;1;"asADT_SitFinalPH")
$error:=AL_SetArraysNam (xALP_PostHist;5;1;"alADT_IDPH")

  //column 1 settings
AL_SetHeaders (xALP_PostHist;1;1;__ ("Postulante"))
AL_SetWidths (xALP_PostHist;1;1;300)
AL_SetFormat (xALP_PostHist;1;"";0;2;0;0)
AL_SetHdrStyle (xALP_PostHist;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_PostHist;1;"Tahoma";9;0)
AL_SetStyle (xALP_PostHist;1;"Tahoma";9;0)
AL_SetForeColor (xALP_PostHist;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PostHist;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_PostHist;1;0)
AL_SetEntryCtls (xALP_PostHist;1;0)

  //column 2 settings
AL_SetHeaders (xALP_PostHist;2;1;__ ("RUT"))
AL_SetWidths (xALP_PostHist;2;1;110)
AL_SetFormat (xALP_PostHist;2;"###.###.###-#";0;2;0;0)
AL_SetHdrStyle (xALP_PostHist;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_PostHist;2;"Tahoma";9;0)
AL_SetStyle (xALP_PostHist;2;"Tahoma";9;0)
AL_SetForeColor (xALP_PostHist;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PostHist;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_PostHist;2;0)
AL_SetEntryCtls (xALP_PostHist;2;0)

  //column 3 settings
AL_SetHeaders (xALP_PostHist;3;1;__ ("Fecha Inscripción"))
AL_SetWidths (xALP_PostHist;3;1;110)
AL_SetFormat (xALP_PostHist;3;"7";0;2;0;0)
AL_SetHdrStyle (xALP_PostHist;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_PostHist;3;"Tahoma";9;0)
AL_SetStyle (xALP_PostHist;3;"Tahoma";9;0)
AL_SetForeColor (xALP_PostHist;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PostHist;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_PostHist;3;0)
AL_SetEntryCtls (xALP_PostHist;3;0)

  //column 4 settings
AL_SetHeaders (xALP_PostHist;4;1;__ ("Situación Final"))
AL_SetWidths (xALP_PostHist;4;1;118)
AL_SetFormat (xALP_PostHist;4;"";0;2;0;0)
AL_SetHdrStyle (xALP_PostHist;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_PostHist;4;"Tahoma";9;0)
AL_SetStyle (xALP_PostHist;4;"Tahoma";9;0)
AL_SetForeColor (xALP_PostHist;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_PostHist;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_PostHist;4;0)
AL_SetEntryCtls (xALP_PostHist;4;0)

  //general options
ALP_SetDefaultAppareance (xALP_PostHist;9;1;6;1;8)
AL_SetColOpts (xALP_PostHist;1;1;1;1;0)
AL_SetRowOpts (xALP_PostHist;0;1;0;0;1;0)
AL_SetCellOpts (xALP_PostHist;0;1;1)
AL_SetMainCalls (xALP_PostHist;"";"")
AL_SetScroll (xALP_PostHist;0;-3)
AL_SetEntryOpts (xALP_PostHist;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_PostHist;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_PostHist;1;"";"";"")
AL_SetDrgSrc (xALP_PostHist;2;"";"";"")
AL_SetDrgSrc (xALP_PostHist;3;"";"";"")
AL_SetDrgDst (xALP_PostHist;1;"";"";"")
AL_SetDrgDst (xALP_PostHist;1;"";"";"")
AL_SetDrgDst (xALP_PostHist;1;"";"";"")