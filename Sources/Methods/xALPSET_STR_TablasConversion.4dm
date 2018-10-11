//%attributes = {}
  //xALPSET_STR_TablasConversion

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_ConversionTable;1;1;"arEVS_ConvGrades")
$Error:=AL_SetArraysNam (xALP_ConversionTable;2;1;"arEVS_ConvPoints")
$Error:=AL_SetArraysNam (xALP_ConversionTable;3;1;"arEVS_ConvGradesOfficial")

  //column 1 settings
AL_SetHeaders (xALP_ConversionTable;1;1;"Notas")
AL_SetWidths (xALP_ConversionTable;1;1;100)
AL_SetFormat (xALP_ConversionTable;1;"";0;2;0;0)
AL_SetHdrStyle (xALP_ConversionTable;1;"Tahoma";11;0)
AL_SetFtrStyle (xALP_ConversionTable;1;"Tahoma";9;0)
AL_SetStyle (xALP_ConversionTable;1;"Tahoma";11;0)
AL_SetForeColor (xALP_ConversionTable;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ConversionTable;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ConversionTable;1;1)
AL_SetEntryCtls (xALP_ConversionTable;1;0)

  //column 2 settings
AL_SetHeaders (xALP_ConversionTable;2;1;"Puntos")
AL_SetWidths (xALP_ConversionTable;2;1;100)
AL_SetFormat (xALP_ConversionTable;2;"";0;2;0;0)
AL_SetHdrStyle (xALP_ConversionTable;2;"Tahoma";11;0)
AL_SetFtrStyle (xALP_ConversionTable;2;"Tahoma";9;0)
AL_SetStyle (xALP_ConversionTable;2;"Tahoma";11;0)
AL_SetForeColor (xALP_ConversionTable;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ConversionTable;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ConversionTable;2;1)
AL_SetEntryCtls (xALP_ConversionTable;2;0)

  //column 3 settings
AL_SetHeaders (xALP_ConversionTable;3;1;"Bonificación")
AL_SetWidths (xALP_ConversionTable;3;1;100)
AL_SetFormat (xALP_ConversionTable;3;"";0;2;0;0)
AL_SetHdrStyle (xALP_ConversionTable;3;"Tahoma";11;0)
AL_SetFtrStyle (xALP_ConversionTable;3;"Tahoma";9;0)
AL_SetStyle (xALP_ConversionTable;3;"Tahoma";11;0)
AL_SetForeColor (xALP_ConversionTable;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ConversionTable;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ConversionTable;3;1)
AL_SetEntryCtls (xALP_ConversionTable;3;0)

  //general options
ALP_SetDefaultAppareance (xALP_ConversionTable;9;1;4;1;1)
AL_SetColOpts (xALP_ConversionTable;1;1;1;0;0)
AL_SetRowOpts (xALP_ConversionTable;0;1;0;0;1;0)
AL_SetCellOpts (xALP_ConversionTable;0;1;1)
AL_SetMiscOpts (xALP_ConversionTable;0;0;"\\";0;1)
AL_SetCallbacks (xALP_ConversionTable;"";"xALCB_EX_TablasConversion_EVS")
AL_SetScroll (xALP_ConversionTable;0;-3)
AL_SetEntryOpts (xALP_ConversionTable;2;0;0;1;2;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_ConversionTable;0;30;0)



  //dragging options

AL_SetDrgSrc (xALP_ConversionTable;1;"";"";"")
AL_SetDrgSrc (xALP_ConversionTable;2;"";"";"")
AL_SetDrgSrc (xALP_ConversionTable;3;"";"";"")
AL_SetDrgDst (xALP_ConversionTable;1;"";"";"")
AL_SetDrgDst (xALP_ConversionTable;1;"";"";"")
AL_SetDrgDst (xALP_ConversionTable;1;"";"";"")