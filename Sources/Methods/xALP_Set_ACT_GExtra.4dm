//%attributes = {}
  //xALP_Set_ACT_GExtra

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Glosas;1;1;"atACT_GlosasExtraGlosa")
$Error:=AL_SetArraysNam (xALP_Glosas;2;1;"atACT_GlosasExtraCta")
$Error:=AL_SetArraysNam (xALP_Glosas;3;1;"atACT_GlosasExtraCentro")
$Error:=AL_SetArraysNam (xALP_Glosas;4;1;"atACT_GlosasExtraCCta")
$Error:=AL_SetArraysNam (xALP_Glosas;5;1;"atACT_GlosasExtraCCentro")
$Error:=AL_SetArraysNam (xALP_Glosas;6;1;"apACT_ImputacUnicaPict")
$Error:=AL_SetArraysNam (xALP_Glosas;7;1;"abACT_ImputacionUnica")

  //column 1 settings
AL_SetHeaders (xALP_Glosas;1;1;__ ("Glosa"))
AL_SetWidths (xALP_Glosas;1;1;180)
AL_SetFormat (xALP_Glosas;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Glosas;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Glosas;1;"Tahoma";9;0)
AL_SetStyle (xALP_Glosas;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Glosas;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Glosas;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Glosas;1;1)
AL_SetEntryCtls (xALP_Glosas;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Glosas;2;1;__ ("Código Plan de Cuentas"))
AL_SetWidths (xALP_Glosas;2;1;95)
AL_SetFormat (xALP_Glosas;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Glosas;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Glosas;2;"Tahoma";9;0)
AL_SetStyle (xALP_Glosas;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Glosas;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Glosas;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Glosas;2;3;<>asACT_CuentaCta)
AL_SetEntryCtls (xALP_Glosas;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Glosas;3;1;__ ("Código Centro de Costos"))
AL_SetWidths (xALP_Glosas;3;1;95)
AL_SetFormat (xALP_Glosas;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_Glosas;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Glosas;3;"Tahoma";9;0)
AL_SetStyle (xALP_Glosas;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Glosas;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Glosas;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Glosas;3;3;<>asACT_Centro)
AL_SetEntryCtls (xALP_Glosas;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Glosas;4;1;__ ("Código Plan de Cuentas Contra"))
AL_SetWidths (xALP_Glosas;4;1;95)
AL_SetFormat (xALP_Glosas;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_Glosas;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Glosas;4;"Tahoma";9;0)
AL_SetStyle (xALP_Glosas;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Glosas;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Glosas;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Glosas;4;3;<>asACT_CuentaCta)
AL_SetEntryCtls (xALP_Glosas;4;0)

  //column 5 settings
AL_SetHeaders (xALP_Glosas;5;1;__ ("Código Centro de Costos Contra"))
AL_SetWidths (xALP_Glosas;5;1;95)
AL_SetFormat (xALP_Glosas;5;"";0;0;0;0)
AL_SetHdrStyle (xALP_Glosas;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Glosas;5;"Tahoma";9;0)
AL_SetStyle (xALP_Glosas;5;"Tahoma";9;0)
AL_SetForeColor (xALP_Glosas;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Glosas;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Glosas;5;3;<>asACT_Centro)
AL_SetEntryCtls (xALP_Glosas;5;0)

  //column 6 settings
AL_SetHeaders (xALP_Glosas;6;1;__ ("Imputación Única"))
AL_SetWidths (xALP_Glosas;6;1;65)
AL_SetFormat (xALP_Glosas;6;"1";0;0;0;0)
AL_SetHdrStyle (xALP_Glosas;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Glosas;6;"Tahoma";9;0)
AL_SetStyle (xALP_Glosas;6;"Tahoma";9;0)
AL_SetForeColor (xALP_Glosas;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Glosas;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Glosas;6;0)
AL_SetEntryCtls (xALP_Glosas;6;0)

  //column 7 settings
AL_SetHeaders (xALP_Glosas;7;1;__ ("Código Centro de Costos Contra"))
AL_SetWidths (xALP_Glosas;7;1;95)
AL_SetFormat (xALP_Glosas;7;"";0;0;0;0)
AL_SetHdrStyle (xALP_Glosas;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Glosas;7;"Tahoma";9;0)
AL_SetStyle (xALP_Glosas;7;"Tahoma";9;0)
AL_SetForeColor (xALP_Glosas;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Glosas;7;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Glosas;7;0)
AL_SetEntryCtls (xALP_Glosas;7;0)

  //general options
ALP_SetDefaultAppareance (xALP_Glosas)
AL_SetColOpts (xALP_Glosas;1;1;1;1;0)
AL_SetRowOpts (xALP_Glosas;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Glosas;0;1;1)
AL_SetMainCalls (xALP_Glosas;"";"")
AL_SetCallbacks (xALP_Glosas;"";"xALP_CB_ACT_ContableExtras")
AL_SetScroll (xALP_Glosas;0;-3)
AL_SetEntryOpts (xALP_Glosas;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_Glosas;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Glosas;1;"";"";"")
AL_SetDrgSrc (xALP_Glosas;2;"";"";"")
AL_SetDrgSrc (xALP_Glosas;3;"";"";"")
AL_SetDrgDst (xALP_Glosas;1;"";"";"")
AL_SetDrgDst (xALP_Glosas;1;"";"";"")
AL_SetDrgDst (xALP_Glosas;1;"";"";"")