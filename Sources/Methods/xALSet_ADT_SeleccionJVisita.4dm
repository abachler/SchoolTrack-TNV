//%attributes = {}
  //xALSet_ADT_SeleccionJVisita

C_LONGINT:C283($Error)


  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_SelJornadaVisita;1;1;"atPST_SeccionJornada")
$Error:=AL_SetArraysNam (xALP_SelJornadaVisita;2;1;"adPST_DateJornada")
$Error:=AL_SetArraysNam (xALP_SelJornadaVisita;3;1;"aiPST_HoraJornada")
$Error:=AL_SetArraysNam (xALP_SelJornadaVisita;4;1;"atPST_LugarJornada")
$Error:=AL_SetArraysNam (xALP_SelJornadaVisita;5;1;"aiPST_SelJornadaGirls")
$Error:=AL_SetArraysNam (xALP_SelJornadaVisita;6;1;"aiPST_SelJornadaBoys")
$Error:=AL_SetArraysNam (xALP_SelJornadaVisita;7;1;"aiPST_SelJornadaTotal")
$Error:=AL_SetArraysNam (xALP_SelJornadaVisita;8;1;"aiPST_IDJornada")


  //column 1 settings
AL_SetHeaders (xALP_SelJornadaVisita;1;1;__ ("S"))
AL_SetWidths (xALP_SelJornadaVisita;1;1;30)
AL_SetFormat (xALP_SelJornadaVisita;1;"";2;2;0;0)
AL_SetHdrStyle (xALP_SelJornadaVisita;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_SelJornadaVisita;1;"Tahoma";9;0)
AL_SetStyle (xALP_SelJornadaVisita;1;"Tahoma";9;1)
AL_SetForeColor (xALP_SelJornadaVisita;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_SelJornadaVisita;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_SelJornadaVisita;1;0)
AL_SetEntryCtls (xALP_SelJornadaVisita;1;0)

  //column 2 settings
AL_SetHeaders (xALP_SelJornadaVisita;2;1;__ ("Fecha"))
AL_SetWidths (xALP_SelJornadaVisita;2;1;75)
AL_SetFormat (xALP_SelJornadaVisita;2;"1";0;0;0;0)
AL_SetHdrStyle (xALP_SelJornadaVisita;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_SelJornadaVisita;2;"Tahoma";9;0)
AL_SetStyle (xALP_SelJornadaVisita;2;"Tahoma";9;0)
AL_SetForeColor (xALP_SelJornadaVisita;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_SelJornadaVisita;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_SelJornadaVisita;2;0)
AL_SetEntryCtls (xALP_SelJornadaVisita;2;0)

  //column 3 settings
AL_SetHeaders (xALP_SelJornadaVisita;3;1;__ ("Hora"))
AL_SetWidths (xALP_SelJornadaVisita;3;1;55)
AL_SetFormat (xALP_SelJornadaVisita;3;"&/2";0;0;0;0)
AL_SetHdrStyle (xALP_SelJornadaVisita;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_SelJornadaVisita;3;"Tahoma";9;0)
AL_SetStyle (xALP_SelJornadaVisita;3;"Tahoma";9;0)
AL_SetForeColor (xALP_SelJornadaVisita;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_SelJornadaVisita;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_SelJornadaVisita;3;0)
AL_SetEntryCtls (xALP_SelJornadaVisita;3;0)

  //column 4 settings
AL_SetHeaders (xALP_SelJornadaVisita;4;1;__ ("Lugar"))
AL_SetWidths (xALP_SelJornadaVisita;4;1;50)
AL_SetFormat (xALP_SelJornadaVisita;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_SelJornadaVisita;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_SelJornadaVisita;4;"Tahoma";9;0)
AL_SetStyle (xALP_SelJornadaVisita;4;"Tahoma";9;0)
AL_SetForeColor (xALP_SelJornadaVisita;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_SelJornadaVisita;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_SelJornadaVisita;4;0)
AL_SetEntryCtls (xALP_SelJornadaVisita;4;0)

  //column 5 settings
AL_SetHeaders (xALP_SelJornadaVisita;5;1;__ ("M"))
AL_SetWidths (xALP_SelJornadaVisita;5;1;30)
AL_SetFormat (xALP_SelJornadaVisita;5;"###0";0;2;0;0)
AL_SetHdrStyle (xALP_SelJornadaVisita;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_SelJornadaVisita;5;"Tahoma";9;0)
AL_SetStyle (xALP_SelJornadaVisita;5;"Tahoma";9;0)
AL_SetForeColor (xALP_SelJornadaVisita;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_SelJornadaVisita;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_SelJornadaVisita;5;0)
AL_SetEntryCtls (xALP_SelJornadaVisita;5;0)

  //column 6 settings
AL_SetHeaders (xALP_SelJornadaVisita;6;1;__ ("H"))
AL_SetWidths (xALP_SelJornadaVisita;6;1;30)
AL_SetFormat (xALP_SelJornadaVisita;6;"###0";0;2;0;0)
AL_SetHdrStyle (xALP_SelJornadaVisita;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_SelJornadaVisita;6;"Tahoma";9;0)
AL_SetStyle (xALP_SelJornadaVisita;6;"Tahoma";9;0)
AL_SetForeColor (xALP_SelJornadaVisita;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_SelJornadaVisita;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_SelJornadaVisita;6;0)
AL_SetEntryCtls (xALP_SelJornadaVisita;6;0)

  //column 7 settings
AL_SetHeaders (xALP_SelJornadaVisita;7;1;__ ("Total"))
AL_SetWidths (xALP_SelJornadaVisita;7;1;27)
AL_SetFormat (xALP_SelJornadaVisita;7;"###0";0;2;0;0)
AL_SetHdrStyle (xALP_SelJornadaVisita;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_SelJornadaVisita;7;"Tahoma";9;0)
AL_SetStyle (xALP_SelJornadaVisita;7;"Tahoma";9;0)
AL_SetForeColor (xALP_SelJornadaVisita;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_SelJornadaVisita;7;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_SelJornadaVisita;7;0)
AL_SetEntryCtls (xALP_SelJornadaVisita;7;0)

  //column 8 settings
AL_SetHeaders (xALP_SelJornadaVisita;8;1;"ID")
AL_SetFormat (xALP_SelJornadaVisita;8;"###0";0;0;0;0)
AL_SetHdrStyle (xALP_SelJornadaVisita;8;"Tahoma";9;1)
AL_SetFtrStyle (xALP_SelJornadaVisita;8;"Tahoma";9;0)
AL_SetStyle (xALP_SelJornadaVisita;8;"Tahoma";9;0)
AL_SetForeColor (xALP_SelJornadaVisita;8;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_SelJornadaVisita;8;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_SelJornadaVisita;8;1)
AL_SetEntryCtls (xALP_SelJornadaVisita;8;0)

  //general options
ALP_SetDefaultAppareance (xALP_SelJornadaVisita;9)
AL_SetColOpts (xALP_SelJornadaVisita;1;1;1;0;0)
AL_SetRowOpts (xALP_SelJornadaVisita;0;0;0;0;1;0)
AL_SetCellOpts (xALP_SelJornadaVisita;0;1;1)
AL_SetMiscOpts (xALP_SelJornadaVisita;0;0;"\\";0;1)
  //AL_SetMiscColor (xALP_SelJornadaVisita;0;"White";0)
  //AL_SetMiscColor (xALP_SelJornadaVisita;1;"White";0)
  //AL_SetMiscColor (xALP_SelJornadaVisita;2;"White";0)
  //AL_SetMiscColor (xALP_SelJornadaVisita;3;"White";0)
AL_SetMainCalls (xALP_SelJornadaVisita;"";"")
AL_SetScroll (xALP_SelJornadaVisita;0;-3)
  //AL_SetCopyOpts (xALP_SelJornadaVisita;0;"\t";"\r";Char(0))
  //AL_SetSortOpts (xALP_SelJornadaVisita;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_SelJornadaVisita;1;0;0;1;0;<>tXS_RS_DecimalSeparator)
  //AL_SetHeight (xALP_SelJornadaVisita;1;2;1;1;2)
  //AL_SetDividers (xALP_SelJornadaVisita;"Black";"Gray";0;"Black";"Gray";0)
AL_SetDrgOpts (xALP_SelJornadaVisita;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_SelJornadaVisita;1;"";"";"")
AL_SetDrgSrc (xALP_SelJornadaVisita;2;"";"";"")
AL_SetDrgSrc (xALP_SelJornadaVisita;3;"";"";"")
AL_SetDrgSrc (xALP_SelJornadaVisita;1;"";"";"")
AL_SetDrgDst (xALP_SelJornadaVisita;1;"";"";"")
AL_SetDrgDst (xALP_SelJornadaVisita;1;"";"";"")
AL_SetDrgDst (xALP_SelJornadaVisita;1;"";"";"")