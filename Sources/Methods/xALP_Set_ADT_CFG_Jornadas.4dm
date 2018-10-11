//%attributes = {}
  //xALP_Set_ADT_CFG_Jornadas

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Presentations;1;1;"adPST_PresentDate")
$Error:=AL_SetArraysNam (xALP_Presentations;2;1;"aLPST_PresentTime")
$Error:=AL_SetArraysNam (xALP_Presentations;3;1;"aiPST_Asistentes")
$Error:=AL_SetArraysNam (xALP_Presentations;4;1;"atPST_Place")
$Error:=AL_SetArraysNam (xALP_Presentations;5;1;"atPST_Encargado")
$Error:=AL_SetArraysNam (xALP_Presentations;6;1;"aiADT_IDEntrevistador")

  //column 1 settings
AL_SetHeaders (xALP_Presentations;1;1;__ ("Fecha"))
AL_SetWidths (xALP_Presentations;1;1;70)
AL_SetFormat (xALP_Presentations;1;"00/00/0000";0;0;0;0)
AL_SetHdrStyle (xALP_Presentations;1;"tahoma";9;1)
AL_SetFtrStyle (xALP_Presentations;1;"tahoma";9;0)
AL_SetStyle (xALP_Presentations;1;"tahoma";9;0)
AL_SetForeColor (xALP_Presentations;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Presentations;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Presentations;1;1)
AL_SetEntryCtls (xALP_Presentations;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Presentations;2;1;__ ("Hora"))
AL_SetWidths (xALP_Presentations;2;1;70)
AL_SetFormat (xALP_Presentations;2;"&/2";0;0;0;0)
AL_SetHdrStyle (xALP_Presentations;2;"tahoma";9;1)
AL_SetFtrStyle (xALP_Presentations;2;"tahoma";9;0)
AL_SetStyle (xALP_Presentations;2;"tahoma";9;0)
AL_SetForeColor (xALP_Presentations;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Presentations;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Presentations;2;1)
AL_SetEntryCtls (xALP_Presentations;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Presentations;3;1;__ ("Asistentes"))
AL_SetWidths (xALP_Presentations;3;1;80)
AL_SetFormat (xALP_Presentations;3;"###0";0;0;0;0)
AL_SetHdrStyle (xALP_Presentations;3;"tahoma";9;1)
AL_SetFtrStyle (xALP_Presentations;3;"tahoma";9;0)
AL_SetStyle (xALP_Presentations;3;"tahoma";9;0)
AL_SetForeColor (xALP_Presentations;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Presentations;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Presentations;3;0)
AL_SetEntryCtls (xALP_Presentations;3;0)


  //column 4 settings
AL_SetHeaders (xALP_Presentations;4;1;__ ("Lugar"))
AL_SetWidths (xALP_Presentations;4;1;80)
AL_SetFormat (xALP_Presentations;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_Presentations;4;"tahoma";9;1)
AL_SetFtrStyle (xALP_Presentations;4;"tahoma";9;0)
AL_SetStyle (xALP_Presentations;4;"tahoma";9;0)
AL_SetForeColor (xALP_Presentations;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Presentations;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Presentations;4;1)
AL_SetEntryCtls (xALP_Presentations;4;0)

  //column 5 settings
AL_SetHeaders (xALP_Presentations;5;1;__ ("Encargado"))
AL_SetWidths (xALP_Presentations;5;1;180)
AL_SetFormat (xALP_Presentations;5;"";0;0;0;0)
AL_SetHdrStyle (xALP_Presentations;5;"tahoma";9;1)
AL_SetFtrStyle (xALP_Presentations;5;"tahoma";9;0)
AL_SetStyle (xALP_Presentations;5;"tahoma";9;0)
AL_SetForeColor (xALP_Presentations;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Presentations;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Presentations;5;3;atADT_Entrevistadores)
AL_SetEntryCtls (xALP_Presentations;5;0)

  //column 6 settings
AL_SetHeaders (xALP_Presentations;6;1;"Id Entrevistadores")
AL_SetWidths (xALP_Presentations;6;1;80)
AL_SetFormat (xALP_Presentations;6;"";0;0;0;0)
AL_SetHdrStyle (xALP_Presentations;6;"tahoma";9;1)
AL_SetFtrStyle (xALP_Presentations;6;"tahoma";9;0)
AL_SetStyle (xALP_Presentations;6;"tahoma";9;0)
AL_SetForeColor (xALP_Presentations;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Presentations;6;"White";0;"White";0;"White";0)
AL_SetEntryCtls (xALP_Presentations;6;0)

  //general options
ALP_SetDefaultAppareance (xALP_Presentations;9;1;6;1;8)
AL_SetColOpts (xALP_Presentations;1;1;1;1;0)
AL_SetRowOpts (xALP_Presentations;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Presentations;0;1;1)
AL_SetMiscOpts (xALP_Presentations;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Presentations;"";"")
AL_SetCallbacks (xALP_Presentations;"";"xALP_ADT_EX_Jornadas")
AL_SetScroll (xALP_Presentations;0;-3)
AL_SetEntryOpts (xALP_Presentations;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_Presentations;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Presentations;1;"";"";"")
AL_SetDrgSrc (xALP_Presentations;2;"";"";"")
AL_SetDrgSrc (xALP_Presentations;3;"";"";"")
AL_SetDrgDst (xALP_Presentations;1;"";"";"")
AL_SetDrgDst (xALP_Presentations;1;"";"";"")
AL_SetDrgDst (xALP_Presentations;1;"";"";"")