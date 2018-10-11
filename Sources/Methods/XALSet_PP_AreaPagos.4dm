//%attributes = {}
  //XALSet_PP_AreaPagos

  //Configuration commands for ALP object 'xALP_Pagos'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Pagos;1;1;"aACT_ApdosPFecha")
$Error:=AL_SetArraysNam (xALP_Pagos;2;1;"aACT_ApdosPGlosa")
$Error:=AL_SetArraysNam (xALP_Pagos;3;1;"aACT_ApdosPMonto")
$Error:=AL_SetArraysNam (xALP_Pagos;4;1;"aACT_ApdosPIDPagos")

  //column 1 settings
AL_SetHeaders (xALP_Pagos;1;1;__ ("Fecha"))
AL_SetFormat (xALP_Pagos;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Pagos;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Pagos;1;"Tahoma";9;0)
AL_SetStyle (xALP_Pagos;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Pagos;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Pagos;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Pagos;1;1)
AL_SetEntryCtls (xALP_Pagos;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Pagos;2;1;__ ("Forma de Pago"))
AL_SetFormat (xALP_Pagos;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Pagos;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Pagos;2;"Tahoma";9;0)
AL_SetStyle (xALP_Pagos;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Pagos;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Pagos;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Pagos;2;1)
AL_SetEntryCtls (xALP_Pagos;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Pagos;3;1;__ ("Monto"))
AL_SetFormat (xALP_Pagos;3;"###.###.###";0;0;0;0)
AL_SetHdrStyle (xALP_Pagos;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Pagos;3;"Tahoma";9;0)
AL_SetStyle (xALP_Pagos;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Pagos;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Pagos;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Pagos;3;1)
AL_SetEntryCtls (xALP_Pagos;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Pagos;4;1;__ ("ID"))
AL_SetFormat (xALP_Pagos;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_Pagos;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Pagos;4;"Tahoma";9;0)
AL_SetStyle (xALP_Pagos;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Pagos;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Pagos;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Pagos;4;1)
AL_SetEntryCtls (xALP_Pagos;4;0)

  //general options

AL_SetColOpts (xALP_Pagos;1;1;1;1;0)
AL_SetRowOpts (xALP_Pagos;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Pagos;0;1;1)
AL_SetMiscOpts (xALP_Pagos;0;0;"\\";0;1)
AL_SetMiscColor (xALP_Pagos;0;"White";0)
AL_SetMiscColor (xALP_Pagos;1;"White";0)
AL_SetMiscColor (xALP_Pagos;2;"White";0)
AL_SetMiscColor (xALP_Pagos;3;"White";0)
AL_SetMainCalls (xALP_Pagos;"";"")
AL_SetScroll (xALP_Pagos;0;-3)
AL_SetCopyOpts (xALP_Pagos;0;"\t";"\r")
AL_SetSortOpts (xALP_Pagos;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Pagos;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_Pagos;1;2;1;1;2)
AL_SetDividers (xALP_Pagos;"Gray";"Black";0;"Gray";"Black";0)
AL_SetDrgOpts (xALP_Pagos;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Pagos;1;"";"";"")
AL_SetDrgSrc (xALP_Pagos;2;"";"";"")
AL_SetDrgSrc (xALP_Pagos;3;"";"";"")
AL_SetDrgDst (xALP_Pagos;1;"";"";"")
AL_SetDrgDst (xALP_Pagos;1;"";"";"")
AL_SetDrgDst (xALP_Pagos;1;"";"";"")




  //Configuration commands for ALP object 'xALP_DesglosePago'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_DesglosePago;1;1;"aACT_ApdosDPFecha")
$Error:=AL_SetArraysNam (xALP_DesglosePago;2;1;"aACT_ApdosDPPeriodo")
$Error:=AL_SetArraysNam (xALP_DesglosePago;3;1;"aACT_ApdosDPAlumno")
$Error:=AL_SetArraysNam (xALP_DesglosePago;4;1;"aACT_ApdosDPMonto")
$Error:=AL_SetArraysNam (xALP_DesglosePago;5;1;"aACT_ApdosDPSaldoCargo")
$Error:=AL_SetArraysNam (xALP_DesglosePago;6;1;"aACT_ApdosDPPagadoCargo")

  //column 1 settings
AL_SetHeaders (xALP_DesglosePago;1;1;__ ("Fecha"))
AL_SetFormat (xALP_DesglosePago;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_DesglosePago;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DesglosePago;1;"Tahoma";9;0)
AL_SetStyle (xALP_DesglosePago;1;"Tahoma";9;0)
AL_SetForeColor (xALP_DesglosePago;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DesglosePago;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DesglosePago;1;1)
AL_SetEntryCtls (xALP_DesglosePago;1;0)

  //column 2 settings
AL_SetHeaders (xALP_DesglosePago;2;1;__ ("Período"))
AL_SetFormat (xALP_DesglosePago;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_DesglosePago;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DesglosePago;2;"Tahoma";9;0)
AL_SetStyle (xALP_DesglosePago;2;"Tahoma";9;0)
AL_SetForeColor (xALP_DesglosePago;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DesglosePago;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DesglosePago;2;1)
AL_SetEntryCtls (xALP_DesglosePago;2;0)

  //column 3 settings
AL_SetHeaders (xALP_DesglosePago;3;1;__ ("Alumno"))
AL_SetFormat (xALP_DesglosePago;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_DesglosePago;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DesglosePago;3;"Tahoma";9;0)
AL_SetStyle (xALP_DesglosePago;3;"Tahoma";9;0)
AL_SetForeColor (xALP_DesglosePago;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DesglosePago;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DesglosePago;3;1)
AL_SetEntryCtls (xALP_DesglosePago;3;0)

  //column 4 settings
AL_SetHeaders (xALP_DesglosePago;4;1;__ ("Monto"))
AL_SetFormat (xALP_DesglosePago;4;"###.###.###";0;0;0;0)
AL_SetHdrStyle (xALP_DesglosePago;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DesglosePago;4;"Tahoma";9;0)
AL_SetStyle (xALP_DesglosePago;4;"Tahoma";9;0)
AL_SetForeColor (xALP_DesglosePago;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DesglosePago;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DesglosePago;4;1)
AL_SetEntryCtls (xALP_DesglosePago;4;0)

  //column 5 settings
AL_SetHeaders (xALP_DesglosePago;5;1;__ ("Saldo Cargo"))
AL_SetFormat (xALP_DesglosePago;5;"###.###.###";0;0;0;0)
AL_SetHdrStyle (xALP_DesglosePago;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DesglosePago;5;"Tahoma";9;0)
AL_SetStyle (xALP_DesglosePago;5;"Tahoma";9;0)
AL_SetForeColor (xALP_DesglosePago;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DesglosePago;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DesglosePago;5;1)
AL_SetEntryCtls (xALP_DesglosePago;5;0)

  //column 6 settings
AL_SetHeaders (xALP_DesglosePago;6;1;__ ("Pagado Cargo"))
AL_SetFormat (xALP_DesglosePago;6;"###.###.###";0;0;0;0)
AL_SetHdrStyle (xALP_DesglosePago;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DesglosePago;6;"Tahoma";9;0)
AL_SetStyle (xALP_DesglosePago;6;"Tahoma";9;0)
AL_SetForeColor (xALP_DesglosePago;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DesglosePago;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DesglosePago;6;1)
AL_SetEntryCtls (xALP_DesglosePago;6;0)

  //general options

AL_SetColOpts (xALP_DesglosePago;1;1;1;0;0)
AL_SetRowOpts (xALP_DesglosePago;0;1;0;0;1;1)
AL_SetCellOpts (xALP_DesglosePago;0;1;1)
AL_SetMiscOpts (xALP_DesglosePago;0;0;"\\";0;1)
AL_SetMiscColor (xALP_DesglosePago;0;"White";0)
AL_SetMiscColor (xALP_DesglosePago;1;"White";0)
AL_SetMiscColor (xALP_DesglosePago;2;"White";0)
AL_SetMiscColor (xALP_DesglosePago;3;"White";0)
AL_SetMainCalls (xALP_DesglosePago;"";"")
AL_SetScroll (xALP_DesglosePago;0;-3)
AL_SetCopyOpts (xALP_DesglosePago;0;"\t";"\r")
AL_SetSortOpts (xALP_DesglosePago;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_DesglosePago;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_DesglosePago;1;2;1;1;2)
AL_SetDividers (xALP_DesglosePago;"Gray";"Black";0;"Gray";"Black";0)
AL_SetDrgOpts (xALP_DesglosePago;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_DesglosePago;1;"";"";"")
AL_SetDrgSrc (xALP_DesglosePago;2;"";"";"")
AL_SetDrgSrc (xALP_DesglosePago;3;"";"";"")
AL_SetDrgDst (xALP_DesglosePago;1;"";"";"")
AL_SetDrgDst (xALP_DesglosePago;1;"";"";"")
AL_SetDrgDst (xALP_DesglosePago;1;"";"";"")

