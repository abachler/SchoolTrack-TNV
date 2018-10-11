//%attributes = {}
  //xALP_ACT_RecepRecaud

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_RecepRecaud;1;1;"alACT_Campo")
$Error:=AL_SetArraysNam (xALP_RecepRecaud;2;1;"atACT_Descripcion")
$Error:=AL_SetArraysNam (xALP_RecepRecaud;3;1;"alACT_Largo")
$Error:=AL_SetArraysNam (xALP_RecepRecaud;4;1;"atACT_TipoDato")
$Error:=AL_SetArraysNam (xALP_RecepRecaud;5;1;"atACT_Posicion")
$Error:=AL_SetArraysNam (xALP_RecepRecaud;6;1;"atACT_Correspondencia")
$Error:=AL_SetArraysNam (xALP_RecepRecaud;7;1;"alACT_PosIni")
$Error:=AL_SetArraysNam (xALP_RecepRecaud;8;1;"alACT_PosFinal")

  //column 1 settings
AL_SetHeaders (xALP_RecepRecaud;1;1;__ ("Campo"))
AL_SetFormat (xALP_RecepRecaud;1;"###0";0;2;0;0)
AL_SetHdrStyle (xALP_RecepRecaud;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_RecepRecaud;1;"Tahoma";9;0)
AL_SetStyle (xALP_RecepRecaud;1;"Tahoma";9;0)
AL_SetForeColor (xALP_RecepRecaud;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_RecepRecaud;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_RecepRecaud;1;0)

  //column 2 settings
AL_SetHeaders (xALP_RecepRecaud;2;1;__ ("Descripción"))
AL_SetWidths (xALP_RecepRecaud;2;1;250)
AL_SetFormat (xALP_RecepRecaud;2;"";0;2;0;0)
AL_SetHdrStyle (xALP_RecepRecaud;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_RecepRecaud;2;"Tahoma";9;0)
AL_SetStyle (xALP_RecepRecaud;2;"Tahoma";9;0)
AL_SetForeColor (xALP_RecepRecaud;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_RecepRecaud;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_RecepRecaud;2;1)
AL_SetEntryCtls (xALP_RecepRecaud;2;0)

  //column 3 settings
AL_SetHeaders (xALP_RecepRecaud;3;1;__ ("Largo"))
AL_SetFormat (xALP_RecepRecaud;3;"###0";0;2;0;0)
AL_SetHdrStyle (xALP_RecepRecaud;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_RecepRecaud;3;"Tahoma";9;0)
AL_SetStyle (xALP_RecepRecaud;3;"Tahoma";9;0)
AL_SetForeColor (xALP_RecepRecaud;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_RecepRecaud;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_RecepRecaud;3;1)
AL_SetEntryCtls (xALP_RecepRecaud;3;0)

  //column 4 settings
AL_SetHeaders (xALP_RecepRecaud;4;1;__ ("Tipo"))
AL_SetFormat (xALP_RecepRecaud;4;"";0;2;0;0)
AL_SetHdrStyle (xALP_RecepRecaud;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_RecepRecaud;4;"Tahoma";9;0)
AL_SetStyle (xALP_RecepRecaud;4;"Tahoma";9;0)
AL_SetForeColor (xALP_RecepRecaud;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_RecepRecaud;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_RecepRecaud;4;2;atACT_TiposDato)
AL_SetEntryCtls (xALP_RecepRecaud;4;0)

  //column 5 settings
AL_SetHeaders (xALP_RecepRecaud;5;1;__ ("Posición"))
AL_SetWidths (xALP_RecepRecaud;5;1;70)
AL_SetFormat (xALP_RecepRecaud;5;"";0;2;0;0)
AL_SetHdrStyle (xALP_RecepRecaud;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_RecepRecaud;5;"Tahoma";9;0)
AL_SetStyle (xALP_RecepRecaud;5;"Tahoma";9;0)
AL_SetForeColor (xALP_RecepRecaud;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_RecepRecaud;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_RecepRecaud;5;0)
AL_SetEntryCtls (xALP_RecepRecaud;5;0)

  //column 6 settings
AL_SetHeaders (xALP_RecepRecaud;6;1;__ ("Correspondencia"))
AL_SetWidths (xALP_RecepRecaud;6;1;100)
AL_SetFormat (xALP_RecepRecaud;6;"";0;2;0;0)
AL_SetHdrStyle (xALP_RecepRecaud;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_RecepRecaud;6;"Tahoma";9;0)
AL_SetStyle (xALP_RecepRecaud;6;"Tahoma";9;0)
AL_SetForeColor (xALP_RecepRecaud;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_RecepRecaud;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_RecepRecaud;6;2;atACT_CamposPago)
AL_SetEntryCtls (xALP_RecepRecaud;6;0)

  //column 7 settings
AL_SetHeaders (xALP_RecepRecaud;7;1;"PosIni")
AL_SetFormat (xALP_RecepRecaud;7;"";0;2;0;0)
AL_SetHdrStyle (xALP_RecepRecaud;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_RecepRecaud;7;"Tahoma";9;0)
AL_SetStyle (xALP_RecepRecaud;7;"Tahoma";9;0)
AL_SetForeColor (xALP_RecepRecaud;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_RecepRecaud;7;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_RecepRecaud;7;2;atACT_CamposPago)
AL_SetEntryCtls (xALP_RecepRecaud;7;0)

  //column 8 settings
AL_SetHeaders (xALP_RecepRecaud;8;1;"PosFinal")
AL_SetFormat (xALP_RecepRecaud;8;"";0;2;0;0)
AL_SetHdrStyle (xALP_RecepRecaud;8;"Tahoma";9;1)
AL_SetFtrStyle (xALP_RecepRecaud;8;"Tahoma";9;0)
AL_SetStyle (xALP_RecepRecaud;8;"Tahoma";9;0)
AL_SetForeColor (xALP_RecepRecaud;8;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_RecepRecaud;8;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_RecepRecaud;8;2;atACT_CamposPago)
AL_SetEntryCtls (xALP_RecepRecaud;8;0)

  //general options
ALP_SetDefaultAppareance (xALP_RecepRecaud;9;1;6;1;8)
AL_SetColOpts (xALP_RecepRecaud;1;1;1;2;0)
AL_SetRowOpts (xALP_RecepRecaud;0;0;0;0;1;0)
AL_SetCellOpts (xALP_RecepRecaud;0;1;1)
AL_SetMainCalls (xALP_RecepRecaud;"";"")
AL_SetCallbacks (xALP_RecepRecaud;"xALP_CBIN_ACT_RecepRecaud";"xALP_CB_ACT_RecepRecaud")
AL_SetScroll (xALP_RecepRecaud;0;0)
AL_SetEntryOpts (xALP_RecepRecaud;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_RecepRecaud;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_RecepRecaud;1;"";"";"")
AL_SetDrgSrc (xALP_RecepRecaud;2;"";"";"")
AL_SetDrgSrc (xALP_RecepRecaud;3;"";"";"")
AL_SetDrgDst (xALP_RecepRecaud;1;"";"";"")
AL_SetDrgDst (xALP_RecepRecaud;1;"";"";"")
AL_SetDrgDst (xALP_RecepRecaud;1;"";"";"")

