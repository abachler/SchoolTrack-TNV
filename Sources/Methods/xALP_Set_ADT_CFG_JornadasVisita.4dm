//%attributes = {}
  //xALP_Set_ADT_CFG_JornadasVisita

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_JornadasVisita;1;1;"atPST_SeccionJornada")
$Error:=AL_SetArraysNam (xALP_JornadasVisita;2;1;"adPST_DateJornada")
$Error:=AL_SetArraysNam (xALP_JornadasVisita;3;1;"aiPST_HoraJornada")
$Error:=AL_SetArraysNam (xALP_JornadasVisita;4;1;"aiPST_AsistentesJornada")
$Error:=AL_SetArraysNam (xALP_JornadasVisita;5;1;"atPST_LugarJornada")
$Error:=AL_SetArraysNam (xALP_JornadasVisita;6;1;"aiPST_IDJornada")


  //column 1 settings
AL_SetHeaders (xALP_JornadasVisita;1;1;__ ("Sección"))
AL_SetWidths (xALP_JornadasVisita;1;1;70)
AL_SetFormat (xALP_JornadasVisita;1;" ";3;0;0;0)
AL_SetHdrStyle (xALP_JornadasVisita;1;"tahoma";9;1)
AL_SetFtrStyle (xALP_JornadasVisita;1;"tahoma";9;0)
AL_SetStyle (xALP_JornadasVisita;1;"tahoma";9;0)
AL_SetForeColor (xALP_JornadasVisita;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_JornadasVisita;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_JornadasVisita;1;0)
AL_SetEntryCtls (xALP_JornadasVisita;1;0)

  //column 2 settings
AL_SetHeaders (xALP_JornadasVisita;2;1;__ ("Día"))
AL_SetWidths (xALP_JornadasVisita;2;1;70)
AL_SetFormat (xALP_JornadasVisita;2;"00/00/0000";0;0;0;0)
AL_SetHdrStyle (xALP_JornadasVisita;2;"tahoma";9;1)
AL_SetFtrStyle (xALP_JornadasVisita;2;"tahoma";9;0)
AL_SetStyle (xALP_JornadasVisita;2;"tahoma";9;0)
AL_SetForeColor (xALP_JornadasVisita;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_JornadasVisita;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_JornadasVisita;2;1)
AL_SetEntryCtls (xALP_JornadasVisita;2;0)

  //column 3 settings
AL_SetHeaders (xALP_JornadasVisita;3;1;__ ("Hora"))
AL_SetWidths (xALP_JornadasVisita;3;1;80)
AL_SetFormat (xALP_JornadasVisita;3;"&/2";0;0;0;0)
AL_SetHdrStyle (xALP_JornadasVisita;3;"tahoma";9;1)
AL_SetFtrStyle (xALP_JornadasVisita;3;"tahoma";9;0)
AL_SetStyle (xALP_JornadasVisita;3;"tahoma";9;0)
AL_SetForeColor (xALP_JornadasVisita;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_JornadasVisita;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_JornadasVisita;3;1)
AL_SetEntryCtls (xALP_JornadasVisita;3;0)


  //column 4 settings
AL_SetHeaders (xALP_JornadasVisita;4;1;__ ("Asistentes"))
AL_SetWidths (xALP_JornadasVisita;4;1;80)
AL_SetFormat (xALP_JornadasVisita;4;"###0";0;0;0;0)
AL_SetHdrStyle (xALP_JornadasVisita;4;"tahoma";9;1)
AL_SetFtrStyle (xALP_JornadasVisita;4;"tahoma";9;0)
AL_SetStyle (xALP_JornadasVisita;4;"tahoma";9;0)
AL_SetForeColor (xALP_JornadasVisita;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_JornadasVisita;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_JornadasVisita;4;0)
AL_SetEntryCtls (xALP_JornadasVisita;4;0)

  //column 5 settings
AL_SetHeaders (xALP_JornadasVisita;5;1;__ ("Lugar"))
AL_SetWidths (xALP_JornadasVisita;5;1;180)
AL_SetFormat (xALP_JornadasVisita;5;"";0;0;0;0)
AL_SetHdrStyle (xALP_JornadasVisita;5;"tahoma";9;1)
AL_SetFtrStyle (xALP_JornadasVisita;5;"tahoma";9;0)
AL_SetStyle (xALP_JornadasVisita;5;"tahoma";9;0)
AL_SetForeColor (xALP_JornadasVisita;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_JornadasVisita;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_JornadasVisita;5;1)
  //AL_SetEnterable (xALP_JornadasVisita;5;3;atADT_Entrevistadores)
AL_SetEntryCtls (xALP_JornadasVisita;5;0)

  //column 6 settings
AL_SetHeaders (xALP_JornadasVisita;6;1;"Id Jornada")
AL_SetWidths (xALP_JornadasVisita;6;1;80)
AL_SetFormat (xALP_JornadasVisita;6;"##000";0;0;0;0)
AL_SetHdrStyle (xALP_JornadasVisita;6;"tahoma";9;1)
AL_SetFtrStyle (xALP_JornadasVisita;6;"tahoma";9;0)
AL_SetStyle (xALP_JornadasVisita;6;"tahoma";9;0)
AL_SetForeColor (xALP_JornadasVisita;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_JornadasVisita;6;"White";0;"White";0;"White";0)
AL_SetEntryCtls (xALP_JornadasVisita;6;0)

  //general options
ALP_SetDefaultAppareance (xALP_JornadasVisita;9;1;6;1;8)
AL_SetColOpts (xALP_JornadasVisita;1;1;1;1;0)
AL_SetRowOpts (xALP_JornadasVisita;0;1;0;0;1;0)
AL_SetCellOpts (xALP_JornadasVisita;0;1;1)
AL_SetMiscOpts (xALP_JornadasVisita;0;0;"\\";0;1)
AL_SetMainCalls (xALP_JornadasVisita;"";"")
AL_SetCallbacks (xALP_JornadasVisita;"";"xALP_ADT_EX_JornadasVisita")
AL_SetScroll (xALP_JornadasVisita;0;-3)
AL_SetEntryOpts (xALP_JornadasVisita;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_JornadasVisita;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_JornadasVisita;1;"";"";"")
AL_SetDrgSrc (xALP_JornadasVisita;2;"";"";"")
AL_SetDrgSrc (xALP_JornadasVisita;3;"";"";"")
AL_SetDrgDst (xALP_JornadasVisita;1;"";"";"")
AL_SetDrgDst (xALP_JornadasVisita;1;"";"";"")
AL_SetDrgDst (xALP_JornadasVisita;1;"";"";"")
