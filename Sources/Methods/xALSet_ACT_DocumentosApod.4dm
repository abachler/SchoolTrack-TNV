//%attributes = {}
  //xALSet_ACT_DocumentosApod

  //Configuration commands for ALP object 'xALP_Documentos'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify fields to display
$Error:=AL_SetFile (xALP_Documentos;Table:C252(->[ACT_Documentos_de_Cargo:174]))  //[ACT_Documentos_de_Cargo]
$Error:=AL_SetFields (xALP_Documentos;174;1;1;15)  //[ACT_Documentos_de_Cargo]No_ComprobanteInterno
$Error:=AL_SetFields (xALP_Documentos;174;2;1;8)  //[ACT_Documentos_de_Cargo]Num_Boleta
$Error:=AL_SetFields (xALP_Documentos;174;3;1;21)  //[ACT_Documentos_de_Cargo]FechaEmision
$Error:=AL_SetFields (xALP_Documentos;174;4;1;19)  //[ACT_Documentos_de_Cargo]Monto_total
$Error:=AL_SetFields (xALP_Documentos;174;5;1;4)  //[ACT_Documentos_de_Cargo]Monto_Neto
$Error:=AL_SetFields (xALP_Documentos;174;6;1;9)  //[ACT_Documentos_de_Cargo]Pagos
$Error:=AL_SetFields (xALP_Documentos;174;7;1;10)  //[ACT_Documentos_de_Cargo]Saldo

  //column 1 settings
AL_SetHeaders (xALP_Documentos;1;1;__ ("Nº Comprobante"))
AL_SetWidths (xALP_Documentos;1;1;80)
AL_SetFormat (xALP_Documentos;1;"### ### ###";0;0;0;0)
AL_SetHdrStyle (xALP_Documentos;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Documentos;1;"Tahoma";9;0)
AL_SetStyle (xALP_Documentos;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Documentos;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Documentos;1;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_Documentos;1;1)
AL_SetEntryCtls (xALP_Documentos;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Documentos;2;1;__ ("Nº Boleta"))
AL_SetWidths (xALP_Documentos;2;1;80)
AL_SetFormat (xALP_Documentos;2;"### ### ###";0;0;0;0)
AL_SetHdrStyle (xALP_Documentos;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Documentos;2;"Tahoma";9;0)
AL_SetStyle (xALP_Documentos;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Documentos;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Documentos;2;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_Documentos;2;1)
AL_SetEntryCtls (xALP_Documentos;2;0)

  //column 3 settings
AL_SetCalcCall (xALP_Documentos;3;"xALP_CalcColumnACT_Trans")
AL_SetHeaders (xALP_Documentos;3;1;__ ("Fecha emisión"))
AL_SetWidths (xALP_Documentos;3;1;80)
AL_SetFormat (xALP_Documentos;3;"7";0;0;0;0)
AL_SetHdrStyle (xALP_Documentos;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Documentos;3;"Tahoma";9;0)
AL_SetStyle (xALP_Documentos;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Documentos;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Documentos;3;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_Documentos;3;1)
AL_SetEntryCtls (xALP_Documentos;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Documentos;4;1;__ ("Total"))
AL_SetWidths (xALP_Documentos;4;1;100)
AL_SetFormat (xALP_Documentos;4;"###.###.###";0;0;0;0)
AL_SetHdrStyle (xALP_Documentos;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Documentos;4;"Tahoma";9;0)
AL_SetStyle (xALP_Documentos;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Documentos;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Documentos;4;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_Documentos;4;1)
AL_SetEntryCtls (xALP_Documentos;4;0)

  //column 5 settings
AL_SetHeaders (xALP_Documentos;5;1;__ ("Neto"))
AL_SetWidths (xALP_Documentos;5;1;100)
AL_SetFormat (xALP_Documentos;5;"###.###.###";0;0;0;0)
AL_SetHdrStyle (xALP_Documentos;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Documentos;5;"Tahoma";9;0)
AL_SetStyle (xALP_Documentos;5;"Tahoma";9;0)
AL_SetForeColor (xALP_Documentos;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Documentos;5;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_Documentos;5;1)
AL_SetEntryCtls (xALP_Documentos;5;0)

  //column 6 settings
AL_SetHeaders (xALP_Documentos;6;1;__ ("Pagos"))
AL_SetWidths (xALP_Documentos;6;1;100)
AL_SetFormat (xALP_Documentos;6;"###.###.###";0;0;0;0)
AL_SetHdrStyle (xALP_Documentos;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Documentos;6;"Tahoma";9;0)
AL_SetStyle (xALP_Documentos;6;"Tahoma";9;0)
AL_SetForeColor (xALP_Documentos;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Documentos;6;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_Documentos;6;1)
AL_SetEntryCtls (xALP_Documentos;6;0)

  //column 7 settings
AL_SetHeaders (xALP_Documentos;7;1;__ ("Saldo"))
AL_SetWidths (xALP_Documentos;7;1;100)
AL_SetFormat (xALP_Documentos;7;"###.###.###";0;0;0;0)
AL_SetHdrStyle (xALP_Documentos;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Documentos;7;"Tahoma";9;0)
AL_SetStyle (xALP_Documentos;7;"Tahoma";9;0)
AL_SetForeColor (xALP_Documentos;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Documentos;7;"White";0;"Light Gray";0;"White";0)
AL_SetEnterable (xALP_Documentos;7;1)
AL_SetEntryCtls (xALP_Documentos;7;0)

  //general options

AL_SetColOpts (xALP_Documentos;1;1;1;0;0)
AL_SetRowOpts (xALP_Documentos;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Documentos;0;1;1)
AL_SetMiscOpts (xALP_Documentos;0;0;"\\";0;1)
AL_SetMiscColor (xALP_Documentos;0;"White";0)
AL_SetMiscColor (xALP_Documentos;1;"White";0)
AL_SetMiscColor (xALP_Documentos;2;"White";0)
AL_SetMiscColor (xALP_Documentos;3;"White";0)
AL_SetMainCalls (xALP_Documentos;"";"")
AL_SetScroll (xALP_Documentos;0;-3)
AL_SetCopyOpts (xALP_Documentos;0;"\t";"\r")
AL_SetSortOpts (xALP_Documentos;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Documentos;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_Documentos;1;2;1;1;2)
AL_SetDividers (xALP_Documentos;"Black";"White";0;"Black";"White";0)
AL_SetDrgOpts (xALP_Documentos;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Documentos;1;"";"";"")
AL_SetDrgSrc (xALP_Documentos;2;"";"";"")
AL_SetDrgSrc (xALP_Documentos;3;"";"";"")
AL_SetDrgDst (xALP_Documentos;1;"";"";"")
AL_SetDrgDst (xALP_Documentos;1;"";"";"")
AL_SetDrgDst (xALP_Documentos;1;"";"";"")

