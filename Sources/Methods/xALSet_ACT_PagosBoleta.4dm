//%attributes = {}
  //xALSet_ACT_PagosBoleta

AL_RemoveArrays (xALP_DocsInvolved;1;6)
ARRAY TEXT:C222(atACT_PagoFormaBol;0)
ARRAY REAL:C219(arACT_PagoMontoBol;0)

C_LONGINT:C283($Error)
$Error:=AL_SetArraysNam (xALP_DocsInvolved;1;1;"atACT_PagoFormaBol")
$Error:=AL_SetArraysNam (xALP_DocsInvolved;2;1;"arACT_PagoMontoBol")
$Error:=AL_SetArraysNam (xALP_DocsInvolved;3;1;"arACT_PagoSaldoBol")
$Error:=AL_SetArraysNam (xALP_DocsInvolved;4;1;"atACT_PagoEstadoDocBol")
$Error:=AL_SetArraysNam (xALP_DocsInvolved;5;1;"alACT_PagoIDBol")

  //column 1 settings
AL_SetHeaders (xALP_DocsInvolved;1;1;__ ("Forma de Pago"))
AL_SetWidths (xALP_DocsInvolved;1;1;200)
AL_SetFormat (xALP_DocsInvolved;1;"";0;2;0;0)
AL_SetHdrStyle (xALP_DocsInvolved;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsInvolved;1;"Tahoma";9;0)
AL_SetStyle (xALP_DocsInvolved;1;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsInvolved;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsInvolved;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsInvolved;1;0)
AL_SetEntryCtls (xALP_DocsInvolved;1;0)

  //column 2 settings
AL_SetHeaders (xALP_DocsInvolved;2;1;__ ("Monto"))
AL_SetWidths (xALP_DocsInvolved;2;1;91)
AL_SetFormat (xALP_DocsInvolved;2;"|Despliegue_ACT_Pagos";0;2;0;0)
AL_SetHdrStyle (xALP_DocsInvolved;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsInvolved;2;"Tahoma";9;0)
AL_SetStyle (xALP_DocsInvolved;2;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsInvolved;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsInvolved;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsInvolved;2;0)
AL_SetEntryCtls (xALP_DocsInvolved;2;0)

  //column 3 settings
AL_SetHeaders (xALP_DocsInvolved;3;1;__ ("Disponible"))
AL_SetWidths (xALP_DocsInvolved;3;1;91)
AL_SetFormat (xALP_DocsInvolved;3;"|Despliegue_ACT_Pagos";0;2;0;0)
AL_SetHdrStyle (xALP_DocsInvolved;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsInvolved;3;"Tahoma";9;0)
AL_SetStyle (xALP_DocsInvolved;3;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsInvolved;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsInvolved;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsInvolved;3;0)
AL_SetEntryCtls (xALP_DocsInvolved;3;0)

  //column 4 settings
AL_SetHeaders (xALP_DocsInvolved;4;1;__ ("Estado Documento"))
AL_SetWidths (xALP_DocsInvolved;4;1;200)
AL_SetFormat (xALP_DocsInvolved;4;"";0;2;0;0)
AL_SetHdrStyle (xALP_DocsInvolved;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsInvolved;4;"Tahoma";9;0)
AL_SetStyle (xALP_DocsInvolved;4;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsInvolved;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsInvolved;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsInvolved;4;0)
AL_SetEntryCtls (xALP_DocsInvolved;4;0)

  //column 5 settings
AL_SetHeaders (xALP_DocsInvolved;5;1;"ID")
AL_SetFormat (xALP_DocsInvolved;5;"###.###.###";0;2;0;0)
AL_SetHdrStyle (xALP_DocsInvolved;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_DocsInvolved;5;"Tahoma";9;0)
AL_SetStyle (xALP_DocsInvolved;5;"Tahoma";9;0)
AL_SetForeColor (xALP_DocsInvolved;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_DocsInvolved;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_DocsInvolved;5;0)
AL_SetEntryCtls (xALP_DocsInvolved;5;0)

  //general options
ALP_SetDefaultAppareance (xALP_DocsInvolved;9;1;6;1;8)
AL_SetColOpts (xALP_DocsInvolved;1;1;1;1;0)
AL_SetRowOpts (xALP_DocsInvolved;0;1;0;0;1;0)
AL_SetCellOpts (xALP_DocsInvolved;0;1;1)
AL_SetMiscOpts (xALP_DocsInvolved;0;0;"\\";0;1)
AL_SetMainCalls (xALP_DocsInvolved;"";"")
AL_SetScroll (xALP_DocsInvolved;0;0)
AL_SetEntryOpts (xALP_DocsInvolved;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_DocsInvolved;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_DocsInvolved;1;"";"";"")
AL_SetDrgSrc (xALP_DocsInvolved;2;"";"";"")
AL_SetDrgSrc (xALP_DocsInvolved;3;"";"";"")
AL_SetDrgDst (xALP_DocsInvolved;1;"";"";"")
AL_SetDrgDst (xALP_DocsInvolved;1;"";"";"")
AL_SetDrgDst (xALP_DocsInvolved;1;"";"";"")

