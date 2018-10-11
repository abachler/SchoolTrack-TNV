//%attributes = {}
  //XALSet_PP_AreasDocumentos

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Documentos;1;1;"aACT_ApdosDCNoComprobante")
$Error:=AL_SetArraysNam (xALP_Documentos;2;1;"aACT_ApdosDCFechaEmision")
$Error:=AL_SetArraysNam (xALP_Documentos;3;1;"aACT_ApdosDCTotal")
$Error:=AL_SetArraysNam (xALP_Documentos;4;1;"aACT_ApdosDCNeto")
$Error:=AL_SetArraysNam (xALP_Documentos;5;1;"aACT_ApdosDCPagos")
$Error:=AL_SetArraysNam (xALP_Documentos;6;1;"aACT_ApdosDCSaldo")
$Error:=AL_SetArraysNam (xALP_Documentos;7;1;"aACT_ApdosDCID")

  //column 1 settings
AL_SetHeaders (xALP_Documentos;1;1;__ ("Nº Comprobante"))
AL_SetFormat (xALP_Documentos;1;"### ### ###";0;0;0;0)
AL_SetHdrStyle (xALP_Documentos;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Documentos;1;"Tahoma";9;0)
AL_SetStyle (xALP_Documentos;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Documentos;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Documentos;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Documentos;1;1)
AL_SetEntryCtls (xALP_Documentos;1;0)

  //column 2 settings
AL_SetCalcCall (xALP_Documentos;2;"xALP_CalcColumnACT_Trans")
AL_SetHeaders (xALP_Documentos;2;1;__ ("Fecha emisión"))
AL_SetFormat (xALP_Documentos;2;"7";0;0;0;0)
AL_SetHdrStyle (xALP_Documentos;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Documentos;2;"Tahoma";9;0)
AL_SetStyle (xALP_Documentos;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Documentos;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Documentos;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Documentos;2;1)
AL_SetEntryCtls (xALP_Documentos;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Documentos;3;1;__ ("Total"))
AL_SetFormat (xALP_Documentos;3;"###.###.###";0;0;0;0)
AL_SetHdrStyle (xALP_Documentos;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Documentos;3;"Tahoma";9;0)
AL_SetStyle (xALP_Documentos;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Documentos;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Documentos;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Documentos;3;1)
AL_SetEntryCtls (xALP_Documentos;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Documentos;4;1;__ ("Neto"))
AL_SetFormat (xALP_Documentos;4;"###.###.###";0;0;0;0)
AL_SetHdrStyle (xALP_Documentos;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Documentos;4;"Tahoma";9;0)
AL_SetStyle (xALP_Documentos;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Documentos;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Documentos;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Documentos;4;1)
AL_SetEntryCtls (xALP_Documentos;4;0)

  //column 5 settings
AL_SetHeaders (xALP_Documentos;5;1;__ ("Pagos"))
AL_SetFormat (xALP_Documentos;5;"###.###.###";0;0;0;0)
AL_SetHdrStyle (xALP_Documentos;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Documentos;5;"Tahoma";9;0)
AL_SetStyle (xALP_Documentos;5;"Tahoma";9;0)
AL_SetForeColor (xALP_Documentos;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Documentos;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Documentos;5;1)
AL_SetEntryCtls (xALP_Documentos;5;0)

  //column 6 settings
AL_SetHeaders (xALP_Documentos;6;1;__ ("Saldo"))
AL_SetFormat (xALP_Documentos;6;"###.###.###";0;0;0;0)
AL_SetHdrStyle (xALP_Documentos;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Documentos;6;"Tahoma";9;0)
AL_SetStyle (xALP_Documentos;6;"Tahoma";9;0)
AL_SetForeColor (xALP_Documentos;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Documentos;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Documentos;6;1)
AL_SetEntryCtls (xALP_Documentos;6;0)

  //column 7 settings
AL_SetHeaders (xALP_Documentos;7;1;__ ("ID"))
AL_SetFormat (xALP_Documentos;7;"";0;0;0;0)
AL_SetHdrStyle (xALP_Documentos;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Documentos;7;"Tahoma";9;0)
AL_SetStyle (xALP_Documentos;7;"Tahoma";9;0)
AL_SetForeColor (xALP_Documentos;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Documentos;7;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Documentos;7;1)
AL_SetEntryCtls (xALP_Documentos;7;0)

  //general options

AL_SetColOpts (xALP_Documentos;1;1;1;1;0)
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
AL_SetDividers (xALP_Documentos;"Gray";"Black";0;"Gray";"Black";0)
AL_SetDrgOpts (xALP_Documentos;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Documentos;1;"";"";"")
AL_SetDrgSrc (xALP_Documentos;2;"";"";"")
AL_SetDrgSrc (xALP_Documentos;3;"";"";"")
AL_SetDrgDst (xALP_Documentos;1;"";"";"")
AL_SetDrgDst (xALP_Documentos;1;"";"";"")
AL_SetDrgDst (xALP_Documentos;1;"";"";"")



  //Configuration commands for ALP object 'xALP_DetalleDocumento'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_DetalleDocumento;1;1;"aACT_ApdosCFechaEmision")
$Error:=AL_SetArraysNam (xALP_DetalleDocumento;2;1;"aACT_ApdosCGlosa")
$Error:=AL_SetArraysNam (xALP_DetalleDocumento;3;1;"aACT_ApdosCAlumno")
$Error:=AL_SetArraysNam (xALP_DetalleDocumento;4;1;"aACT_ApdosCMonto")
$Error:=AL_SetArraysNam (xALP_DetalleDocumento;5;1;"aACT_ApdosCPagos")

  //column 1 settings
AL_SetHeaders (xALP_DetalleDocumento;1;1;__ ("Fecha de emisión"))
AL_SetFormat (xALP_DetalleDocumento;1;"7";0;0;0;0)
AL_SetHdrStyle (xALP_DetalleDocumento;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DetalleDocumento;1;"Tahoma";9;0)
AL_SetStyle (xALP_DetalleDocumento;1;"Tahoma";9;0)
AL_SetForeColor (xALP_DetalleDocumento;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DetalleDocumento;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DetalleDocumento;1;1)
AL_SetEntryCtls (xALP_DetalleDocumento;1;0)

  //column 2 settings
AL_SetHeaders (xALP_DetalleDocumento;2;1;__ ("Glosa"))
AL_SetFormat (xALP_DetalleDocumento;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_DetalleDocumento;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DetalleDocumento;2;"Tahoma";9;0)
AL_SetStyle (xALP_DetalleDocumento;2;"Tahoma";9;0)
AL_SetForeColor (xALP_DetalleDocumento;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DetalleDocumento;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DetalleDocumento;2;1)
AL_SetEntryCtls (xALP_DetalleDocumento;2;0)

  //column 3 settings
AL_SetHeaders (xALP_DetalleDocumento;3;1;__ ("Alumno"))
AL_SetFormat (xALP_DetalleDocumento;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_DetalleDocumento;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DetalleDocumento;3;"Tahoma";9;0)
AL_SetStyle (xALP_DetalleDocumento;3;"Tahoma";9;0)
AL_SetForeColor (xALP_DetalleDocumento;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DetalleDocumento;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DetalleDocumento;3;1)
AL_SetEntryCtls (xALP_DetalleDocumento;3;0)

  //column 4 settings
AL_SetCalcCall (xALP_DetalleDocumento;4;"xALP_CalcColumnACT_Trans")
AL_SetHeaders (xALP_DetalleDocumento;4;1;__ ("Monto"))
AL_SetFormat (xALP_DetalleDocumento;4;"###.###.###";0;0;0;0)
AL_SetHdrStyle (xALP_DetalleDocumento;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DetalleDocumento;4;"Tahoma";9;0)
AL_SetStyle (xALP_DetalleDocumento;4;"Tahoma";9;0)
AL_SetForeColor (xALP_DetalleDocumento;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DetalleDocumento;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DetalleDocumento;4;1)
AL_SetEntryCtls (xALP_DetalleDocumento;4;0)

  //column 5 settings
AL_SetHeaders (xALP_DetalleDocumento;5;1;__ ("Pagos"))
AL_SetFormat (xALP_DetalleDocumento;5;"###.###.###";0;0;0;0)
AL_SetHdrStyle (xALP_DetalleDocumento;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DetalleDocumento;5;"Tahoma";9;0)
AL_SetStyle (xALP_DetalleDocumento;5;"Tahoma";9;0)
AL_SetForeColor (xALP_DetalleDocumento;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DetalleDocumento;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DetalleDocumento;5;1)
AL_SetEntryCtls (xALP_DetalleDocumento;5;0)

  //general options

AL_SetColOpts (xALP_DetalleDocumento;1;1;1;0;0)
AL_SetRowOpts (xALP_DetalleDocumento;0;1;0;0;1;1)
AL_SetCellOpts (xALP_DetalleDocumento;0;1;1)
AL_SetMiscOpts (xALP_DetalleDocumento;0;0;"\\";0;1)
AL_SetMiscColor (xALP_DetalleDocumento;0;"White";0)
AL_SetMiscColor (xALP_DetalleDocumento;1;"White";0)
AL_SetMiscColor (xALP_DetalleDocumento;2;"White";0)
AL_SetMiscColor (xALP_DetalleDocumento;3;"White";0)
AL_SetMainCalls (xALP_DetalleDocumento;"";"")
AL_SetScroll (xALP_DetalleDocumento;0;-3)
AL_SetCopyOpts (xALP_DetalleDocumento;0;"\t";"\r")
AL_SetSortOpts (xALP_DetalleDocumento;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_DetalleDocumento;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetHeight (xALP_DetalleDocumento;1;2;1;1;2)
AL_SetDividers (xALP_DetalleDocumento;"Gray";"Black";0;"Gray";"Black";0)
AL_SetDrgOpts (xALP_DetalleDocumento;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_DetalleDocumento;1;"";"";"")
AL_SetDrgSrc (xALP_DetalleDocumento;2;"";"";"")
AL_SetDrgSrc (xALP_DetalleDocumento;3;"";"";"")
AL_SetDrgDst (xALP_DetalleDocumento;1;"";"";"")
AL_SetDrgDst (xALP_DetalleDocumento;1;"";"";"")
AL_SetDrgDst (xALP_DetalleDocumento;1;"";"";"")

