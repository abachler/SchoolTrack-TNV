//%attributes = {}
  //xALSet_ACT_ConfigMatrices

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Matrices;1;1;"alACT_IDMatriz")
$Error:=AL_SetArraysNam (xALP_Matrices;2;1;"atACT_NombreMatriz")
$Error:=AL_SetArraysNam (xALP_Matrices;3;1;"atACT_MonedaMatriz")

  //column 1 settings
AL_SetHeaders (xALP_Matrices;1;1;__ ("ID"))
AL_SetWidths (xALP_Matrices;1;1;30)
AL_SetFormat (xALP_Matrices;1;"######";0;2;0;0)
AL_SetHdrStyle (xALP_Matrices;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Matrices;1;"Tahoma";9;0)
AL_SetStyle (xALP_Matrices;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Matrices;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Matrices;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Matrices;1;0)
AL_SetEntryCtls (xALP_Matrices;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Matrices;2;1;__ ("Nombre"))
AL_SetWidths (xALP_Matrices;2;1;170)
AL_SetFormat (xALP_Matrices;2;"";0;2;0;0)
AL_SetHdrStyle (xALP_Matrices;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Matrices;2;"Tahoma";9;0)
AL_SetStyle (xALP_Matrices;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Matrices;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Matrices;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Matrices;2;1)
AL_SetEntryCtls (xALP_Matrices;2;0)

  //Column 3 settings
AL_SetHeaders (xALP_Matrices;3;1;__ ("Moneda"))
AL_SetWidths (xALP_Matrices;3;1;90)
AL_SetFormat (xALP_Matrices;3;"";0;2;0;0)
AL_SetHdrStyle (xALP_Matrices;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Matrices;3;"Tahoma";9;0)
AL_SetStyle (xALP_Matrices;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Matrices;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Matrices;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Matrices;3;3;atACT_NombreMoneda)
AL_SetEntryCtls (xALP_Matrices;3;0)

  //general options
ALP_SetDefaultAppareance (xALP_Matrices;9;1;6;1;8)
AL_SetColOpts (xALP_Matrices;1;1;1;1;0)
AL_SetRowOpts (xALP_Matrices;1;0;0;0;1;0)
AL_SetCellOpts (xALP_Matrices;0;1;1)
AL_SetMainCalls (xALP_Matrices;"";"")
AL_SetCallbacks (xALP_Matrices;"";"xALP_CB_ACT_Matrices")
AL_SetScroll (xALP_Matrices;0;-3)
AL_SetEntryOpts (xALP_Matrices;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_Matrices;0;30;0)
  //AL_SetSortOpts (xALP_Matrices;0;0;0;"Seleccione las columnas a ordenar:";0;1)

  //dragging options

AL_SetDrgSrc (xALP_Matrices;1;"";"";"")
AL_SetDrgSrc (xALP_Matrices;2;"";"";"")
AL_SetDrgSrc (xALP_Matrices;3;"";"";"")
AL_SetDrgDst (xALP_Matrices;1;"";"";"")
AL_SetDrgDst (xALP_Matrices;1;"";"";"")
AL_SetDrgDst (xALP_Matrices;1;"";"";"")

