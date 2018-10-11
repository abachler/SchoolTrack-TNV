//%attributes = {}
  //xALPSet_ACT_CatsDT

C_LONGINT:C283($Error)

  //20130210 RCH Requerimiento Aleman Pto Montt. Se agrega una columna a la conf
AT_Inc (0)
  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_CatsDT;AT_Inc ;1;"apACT_PorDefecto")
$Error:=AL_SetArraysNam (xALP_CatsDT;AT_Inc ;1;"atACT_Categorias")
$Error:=AL_SetArraysNam (xALP_CatsDT;AT_Inc ;1;"apACT_ReqDatos")
$Error:=AL_SetArraysNam (xALP_CatsDT;AT_Inc ;1;"apACT_EmiteAfectoExento")
$Error:=AL_SetArraysNam (xALP_CatsDT;AT_Inc ;1;"abACT_ReqDatos")
$Error:=AL_SetArraysNam (xALP_CatsDT;AT_Inc ;1;"abACT_EmiteAfectoExento")
$Error:=AL_SetArraysNam (xALP_CatsDT;AT_Inc ;1;"alACT_IDsCats")
$Error:=AL_SetArraysNam (xALP_CatsDT;AT_Inc ;1;"abACT_PorDefecto")
  //$Error:=AL_SetArraysNam (xALP_CatsDT;7;1;"al_idCatDoctributario")

  //column 1 settings
AL_SetHeaders (xALP_CatsDT;1;1;"")
AL_SetFormat (xALP_CatsDT;1;"1";0;0;0;0)
AL_SetWidths (xALP_CatsDT;1;1;15)
AL_SetHdrStyle (xALP_CatsDT;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_CatsDT;1;"Tahoma";9;0)
AL_SetStyle (xALP_CatsDT;1;"Tahoma";9;0)
AL_SetForeColor (xALP_CatsDT;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CatsDT;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CatsDT;1;0)
AL_SetEntryCtls (xALP_CatsDT;1;0)

  //column 2 settings
AL_SetHeaders (xALP_CatsDT;2;1;__ ("Categorías"))
AL_SetFormat (xALP_CatsDT;2;"";0;0;0;0)
AL_SetWidths (xALP_CatsDT;2;1;193)
AL_SetHdrStyle (xALP_CatsDT;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_CatsDT;2;"Tahoma";9;0)
AL_SetStyle (xALP_CatsDT;2;"Tahoma";9;0)
AL_SetForeColor (xALP_CatsDT;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CatsDT;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CatsDT;2;2;atACT_CategoriasDctos)
AL_SetEntryCtls (xALP_CatsDT;2;0)

  //column 3 settings

AL_SetHeaders (xALP_CatsDT;3;1;__ ("Requiere datos\radicionales"))
AL_SetFormat (xALP_CatsDT;3;"1";0;0;0;0)
AL_SetWidths (xALP_CatsDT;3;1;82)
AL_SetHdrStyle (xALP_CatsDT;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_CatsDT;3;"Tahoma";9;0)
AL_SetStyle (xALP_CatsDT;3;"Tahoma";9;0)
AL_SetForeColor (xALP_CatsDT;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CatsDT;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CatsDT;3;0)
AL_SetEntryCtls (xALP_CatsDT;3;0)

  //column 4 settings

AL_SetHeaders (xALP_CatsDT;4;1;__ ("Afecto Exento\ren 1 documento"))
AL_SetFormat (xALP_CatsDT;4;"1";0;0;0;0)
AL_SetWidths (xALP_CatsDT;4;1;82)
AL_SetHdrStyle (xALP_CatsDT;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_CatsDT;4;"Tahoma";9;0)
AL_SetStyle (xALP_CatsDT;4;"Tahoma";9;0)
AL_SetForeColor (xALP_CatsDT;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CatsDT;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CatsDT;4;0)
AL_SetEntryCtls (xALP_CatsDT;4;0)

  //column 5 settings

AL_SetHeaders (xALP_CatsDT;5;1;"ReqDataBool")
AL_SetFormat (xALP_CatsDT;5;"Si;No";2;0;0;0)
AL_SetHdrStyle (xALP_CatsDT;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_CatsDT;5;"Tahoma";9;0)
AL_SetStyle (xALP_CatsDT;5;"Tahoma";9;0)
AL_SetForeColor (xALP_CatsDT;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CatsDT;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CatsDT;5;0)
AL_SetEntryCtls (xALP_CatsDT;5;0)

  //column 6 settings

AL_SetHeaders (xALP_CatsDT;6;1;"Emite1DocBool")
AL_SetFormat (xALP_CatsDT;6;"Si;No";2;0;0;0)
AL_SetHdrStyle (xALP_CatsDT;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_CatsDT;6;"Tahoma";9;0)
AL_SetStyle (xALP_CatsDT;5;"Tahoma";9;0)
AL_SetForeColor (xALP_CatsDT;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CatsDT;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CatsDT;6;0)
AL_SetEntryCtls (xALP_CatsDT;6;0)

  //column 7 settings
AL_SetHeaders (xALP_CatsDT;7;1;"ID")
AL_SetFormat (xALP_CatsDT;7;"";0;0;0;0)
AL_SetHdrStyle (xALP_CatsDT;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_CatsDT;7;"Tahoma";9;0)
AL_SetStyle (xALP_CatsDT;7;"Tahoma";9;0)
AL_SetForeColor (xALP_CatsDT;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CatsDT;7;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CatsDT;7;0)
AL_SetEntryCtls (xALP_CatsDT;7;0)

  //column 8 settings

AL_SetHeaders (xALP_CatsDT;8;1;"ReqDataBool")
AL_SetFormat (xALP_CatsDT;8;"Si;No";2;0;0;0)
AL_SetHdrStyle (xALP_CatsDT;8;"Tahoma";9;1)
AL_SetFtrStyle (xALP_CatsDT;8;"Tahoma";9;0)
AL_SetStyle (xALP_CatsDT;8;"Tahoma";9;0)
AL_SetForeColor (xALP_CatsDT;8;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CatsDT;8;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CatsDT;8;0)
AL_SetEntryCtls (xALP_CatsDT;8;0)

  //  `column 7 settings
  //
  //AL_SetHeaders (xALP_CatsDT;7;1;"Id Docto Tributario")
  //AL_SetFormat (xALP_CatsDT;7;"";2;0;0;0)
  //AL_SetHdrStyle (xALP_CatsDT;7;"Tahoma";9;1)
  //AL_SetFtrStyle (xALP_CatsDT;7;"Tahoma";9;0)
  //AL_SetStyle (xALP_CatsDT;7;"Tahoma";9;0)
  //AL_SetForeColor (xALP_CatsDT;7;"Black";0;"Black";0;"Black";0)
  //AL_SetBackColor (xALP_CatsDT;7;"White";0;"White";0;"White";0)
  //AL_SetEnterable (xALP_CatsDT;7;0)
  //AL_SetEntryCtls (xALP_CatsDT;7;0)
  //general options
ALP_SetDefaultAppareance (xALP_CatsDT;9;1;6;2;6)
AL_SetColOpts (xALP_CatsDT;1;1;1;4;0)
AL_SetRowOpts (xALP_CatsDT;0;1;0;0;1;0)
AL_SetCellOpts (xALP_CatsDT;0;1;1)
AL_SetMiscOpts (xALP_CatsDT;0;0;"\\";0;1)
AL_SetMainCalls (xALP_CatsDT;"";"")
AL_SetCallbacks (xALP_CatsDT;"";"xALP_ACT_CB_Cats")
AL_SetScroll (xALP_CatsDT;0;-3)
AL_SetEntryOpts (xALP_CatsDT;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_CatsDT;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_CatsDT;1;"";"";"")
AL_SetDrgSrc (xALP_CatsDT;2;"";"";"")
AL_SetDrgSrc (xALP_CatsDT;3;"";"";"")
AL_SetDrgDst (xALP_CatsDT;1;"";"";"")
AL_SetDrgDst (xALP_CatsDT;1;"";"";"")
AL_SetDrgDst (xALP_CatsDT;1;"";"";"")

