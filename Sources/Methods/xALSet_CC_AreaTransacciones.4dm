//%attributes = {}
  //xALSet_CC_AreaTransacciones

  //Configuration commands for ALP object 'xALP_Transacciones'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Transacciones;1;1;"aACT_CtasTFecha")
$Error:=AL_SetArraysNam (xALP_Transacciones;2;1;"aACT_CtasTPeriodo")
$Error:=AL_SetArraysNam (xALP_Transacciones;3;1;"aACT_CtasTGlosa")
$Error:=AL_SetArraysNam (xALP_Transacciones;4;1;"aACT_CtasTDebito")
$Error:=AL_SetArraysNam (xALP_Transacciones;5;1;"aACT_CtasTCredito")

  //column 1 settings
AL_SetHeaders (xALP_Transacciones;1;1;__ ("Fecha"))
AL_SetFormat (xALP_Transacciones;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Transacciones;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Transacciones;1;"Tahoma";9;0)
AL_SetStyle (xALP_Transacciones;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Transacciones;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Transacciones;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Transacciones;1;1)
AL_SetEntryCtls (xALP_Transacciones;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Transacciones;2;1;__ ("Período"))
AL_SetFormat (xALP_Transacciones;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Transacciones;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Transacciones;2;"Tahoma";9;0)
AL_SetStyle (xALP_Transacciones;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Transacciones;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Transacciones;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Transacciones;2;1)
AL_SetEntryCtls (xALP_Transacciones;2;0)

  //column 3 settings
AL_SetCalcCall (xALP_Transacciones;3;"xALP_CalcColumnACT_Trans")
AL_SetHeaders (xALP_Transacciones;3;1;__ ("Glosa"))
AL_SetFormat (xALP_Transacciones;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_Transacciones;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Transacciones;3;"Tahoma";9;0)
AL_SetStyle (xALP_Transacciones;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Transacciones;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Transacciones;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Transacciones;3;1)
AL_SetEntryCtls (xALP_Transacciones;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Transacciones;4;1;__ ("Débito"))
AL_SetFormat (xALP_Transacciones;4;"###.###.###";0;0;0;0)
AL_SetHdrStyle (xALP_Transacciones;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Transacciones;4;"Tahoma";9;0)
AL_SetStyle (xALP_Transacciones;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Transacciones;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Transacciones;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Transacciones;4;1)
AL_SetEntryCtls (xALP_Transacciones;4;0)

  //column 5 settings
AL_SetHeaders (xALP_Transacciones;5;1;__ ("Crédito"))
AL_SetFormat (xALP_Transacciones;5;"###.###.###";0;0;0;0)
AL_SetHdrStyle (xALP_Transacciones;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Transacciones;5;"Tahoma";9;0)
AL_SetStyle (xALP_Transacciones;5;"Tahoma";9;0)
AL_SetForeColor (xALP_Transacciones;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Transacciones;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Transacciones;5;1)
AL_SetEntryCtls (xALP_Transacciones;5;0)

  //general options

AL_SetColOpts (xALP_Transacciones;1;1;1;0;0)
AL_SetRowOpts (xALP_Transacciones;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Transacciones;0;1;1)
AL_SetMiscOpts (xALP_Transacciones;0;0;"\\";0;1)
AL_SetMiscColor (xALP_Transacciones;0;"White";0)
AL_SetMiscColor (xALP_Transacciones;1;"White";0)
AL_SetMiscColor (xALP_Transacciones;2;"White";0)
AL_SetMiscColor (xALP_Transacciones;3;"White";0)
AL_SetMainCalls (xALP_Transacciones;"";"")
AL_SetScroll (xALP_Transacciones;0;0)
AL_SetCopyOpts (xALP_Transacciones;0;"\t";"\r")
AL_SetSortOpts (xALP_Transacciones;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Transacciones;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_Transacciones;1;2;1;1;2)
AL_SetDividers (xALP_Transacciones;"Gray";"Black";0;"Gray";"Black";0)
AL_SetDrgOpts (xALP_Transacciones;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Transacciones;1;"";"";"")
AL_SetDrgSrc (xALP_Transacciones;2;"";"";"")
AL_SetDrgSrc (xALP_Transacciones;3;"";"";"")
AL_SetDrgDst (xALP_Transacciones;1;"";"";"")
AL_SetDrgDst (xALP_Transacciones;1;"";"";"")
AL_SetDrgDst (xALP_Transacciones;1;"";"";"")

