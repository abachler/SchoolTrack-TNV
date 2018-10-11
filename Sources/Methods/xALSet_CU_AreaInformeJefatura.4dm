//%attributes = {}
  //xALSet_CU_AreaInformeJefatura

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Dispersion;1;1;"aiCU_DispersionRango")
$Error:=AL_SetArraysNam (xALP_Dispersion;2;1;"atCU_DispersionTo")
$Error:=AL_SetArraysNam (xALP_Dispersion;3;1;"atCU_DispersionFrom")
$Error:=AL_SetArraysNam (xALP_Dispersion;4;1;"arCU_DispersionFrom")
$Error:=AL_SetArraysNam (xALP_Dispersion;5;1;"arCU_DispersionTo")

  //column 1 settings
AL_SetHeaders (xALP_Dispersion;1;1;__ ("Rango"))
AL_SetWidths (xALP_Dispersion;1;1;40)
AL_SetFormat (xALP_Dispersion;1;"0";2;0;0;0)
AL_SetHdrStyle (xALP_Dispersion;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Dispersion;1;"Tahoma";9;0)
AL_SetStyle (xALP_Dispersion;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Dispersion;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Dispersion;1;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_Dispersion;1;0)
AL_SetEntryCtls (xALP_Dispersion;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Dispersion;2;1;__ ("Hasta"))
AL_SetWidths (xALP_Dispersion;2;1;59)
AL_SetFormat (xALP_Dispersion;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Dispersion;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Dispersion;2;"Tahoma";9;0)
AL_SetStyle (xALP_Dispersion;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Dispersion;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Dispersion;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Dispersion;2;1)
AL_SetEntryCtls (xALP_Dispersion;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Dispersion;3;1;__ ("Desde"))
AL_SetFormat (xALP_Dispersion;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_Dispersion;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Dispersion;3;"Tahoma";9;0)
AL_SetStyle (xALP_Dispersion;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Dispersion;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Dispersion;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Dispersion;3;1)
AL_SetEntryCtls (xALP_Dispersion;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Dispersion;4;1;"Desde % (hidden)")
AL_SetFormat (xALP_Dispersion;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_Dispersion;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Dispersion;4;"Tahoma";9;0)
AL_SetStyle (xALP_Dispersion;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Dispersion;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Dispersion;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Dispersion;4;1)
AL_SetEntryCtls (xALP_Dispersion;4;0)

  //column 5 settings
AL_SetHeaders (xALP_Dispersion;5;1;"Hasta % (hidden)")
AL_SetFormat (xALP_Dispersion;5;"";0;0;0;0)
AL_SetHdrStyle (xALP_Dispersion;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Dispersion;5;"Tahoma";9;0)
AL_SetStyle (xALP_Dispersion;5;"Tahoma";9;0)
AL_SetForeColor (xALP_Dispersion;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Dispersion;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Dispersion;5;1)
AL_SetEntryCtls (xALP_Dispersion;5;0)

  //general options
ALP_SetDefaultAppareance (xALP_Dispersion)
AL_SetColOpts (xALP_Dispersion;1;1;1;3;0)
AL_SetRowOpts (xALP_Dispersion;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Dispersion;0;1;1)
AL_SetMiscOpts (xALP_Dispersion;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Dispersion;"";"")
AL_SetCallbacks (xALP_Dispersion;"";"xALP_CB_EX_Dispersion")
AL_SetScroll (xALP_Dispersion;0;-3)
AL_SetEntryOpts (xALP_Dispersion;2;0;0;1;2;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Dispersion;0;30;0)

ARRAY INTEGER:C220(aInteger2D;2;0)
AL_SetCellColor (xALP_Dispersion;1;1;1;8;aInteger2D;"";0;"Light Gray";0)
AL_SetLine (xALP_Dispersion;0)

  //dragging options

AL_SetDrgSrc (xALP_Dispersion;1;"";"";"")
AL_SetDrgSrc (xALP_Dispersion;2;"";"";"")
AL_SetDrgSrc (xALP_Dispersion;3;"";"";"")
AL_SetDrgDst (xALP_Dispersion;1;"";"";"")
AL_SetDrgDst (xALP_Dispersion;1;"";"";"")
AL_SetDrgDst (xALP_Dispersion;1;"";"";"")

