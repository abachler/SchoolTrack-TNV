//%attributes = {}
  //xALP_Set_ADT_AreasPago

C_LONGINT:C283($error)

$error:=AL_SetArraysNam (xALP_ItemsADT;1;1;"atADT_Glosa")
$error:=AL_SetArraysNam (xALP_ItemsADT;2;1;"atADT_Moneda")
$error:=AL_SetArraysNam (xALP_ItemsADT;3;1;"arADT_Monto")
$error:=AL_SetArraysNam (xALP_ItemsADT;4;1;"apADT_IVA")
$error:=AL_SetArraysNam (xALP_ItemsADT;5;1;"abADT_IVA")
$error:=AL_SetArraysNam (xALP_ItemsADT;6;1;"alADT_ID")
$error:=AL_SetArraysNam (xALP_ItemsADT;7;1;"asADT_CtaCta")
$error:=AL_SetArraysNam (xALP_ItemsADT;8;1;"asADT_CodAuxCta")
$error:=AL_SetArraysNam (xALP_ItemsADT;9;1;"asADT_CentroCta")
$error:=AL_SetArraysNam (xALP_ItemsADT;10;1;"asADT_CtaCCta")
$error:=AL_SetArraysNam (xALP_ItemsADT;11;1;"asADT_CodAuxCCta")
$error:=AL_SetArraysNam (xALP_ItemsADT;12;1;"asADT_CentroCCta")

  //column 1 settings
AL_SetHeaders (xALP_ItemsADT;1;1;__ ("Glosa"))
AL_SetWidths (xALP_ItemsADT;1;1;139)
AL_SetFormat (xALP_ItemsADT;1;"";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsADT;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsADT;1;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsADT;1;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsADT;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsADT;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsADT;1;0)
AL_SetEntryCtls (xALP_ItemsADT;1;0)

  //column 2 settings
AL_SetHeaders (xALP_ItemsADT;2;1;__ ("Moneda"))
AL_SetWidths (xALP_ItemsADT;2;1;85)
AL_SetFormat (xALP_ItemsADT;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_ItemsADT;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsADT;2;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsADT;2;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsADT;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsADT;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsADT;2;0)
AL_SetEntryCtls (xALP_ItemsADT;2;0)

  //column 3 settings
AL_SetHeaders (xALP_ItemsADT;3;1;__ ("Monto"))
AL_SetWidths (xALP_ItemsADT;3;1;50)
AL_SetFormat (xALP_ItemsADT;3;"|Despliegue_ACT";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsADT;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsADT;3;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsADT;3;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsADT;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsADT;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsADT;3;0)
AL_SetEntryCtls (xALP_ItemsADT;3;0)

  //column 4 settings
AL_SetHeaders (xALP_ItemsADT;4;1;__ ("Afecto a\rIVA"))
AL_SetWidths (xALP_ItemsADT;4;1;54)
AL_SetFormat (xALP_ItemsADT;4;"1";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsADT;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsADT;4;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsADT;4;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsADT;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsADT;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsADT;4;0)
AL_SetEntryCtls (xALP_ItemsADT;4;0)

  //general options
ALP_SetDefaultAppareance (xALP_ItemsADT;9;1;6;2;8)
AL_SetColOpts (xALP_ItemsADT;1;1;1;8;0)
AL_SetRowOpts (xALP_ItemsADT;0;1;0;0;1;0)
AL_SetCellOpts (xALP_ItemsADT;0;1;1)
AL_SetMainCalls (xALP_ItemsADT;"";"")
AL_SetScroll (xALP_ItemsADT;0;-3)
AL_SetEntryOpts (xALP_ItemsADT;1;0;0;1;2;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_ItemsADT;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_ItemsADT;1;String:C10(xALP_ItemsADT))

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_ItemsACT;1;1;"atACT_Glosa")
$error:=AL_SetArraysNam (xALP_ItemsACT;2;1;"atACT_Moneda")
$error:=AL_SetArraysNam (xALP_ItemsACT;3;1;"arACT_Monto")
$error:=AL_SetArraysNam (xALP_ItemsACT;4;1;"apACT_IVA")
$error:=AL_SetArraysNam (xALP_ItemsACT;5;1;"abACT_IVA")
$error:=AL_SetArraysNam (xALP_ItemsACT;6;1;"alACT_ID")
$error:=AL_SetArraysNam (xALP_ItemsACT;7;1;"asACT_CtaCta")
$error:=AL_SetArraysNam (xALP_ItemsACT;8;1;"asACT_CodAuxCta")
$error:=AL_SetArraysNam (xALP_ItemsACT;9;1;"asACT_CentroCta")
$error:=AL_SetArraysNam (xALP_ItemsACT;10;1;"asACT_CtaCCta")
$error:=AL_SetArraysNam (xALP_ItemsACT;11;1;"asACT_CodAuxCCta")
$error:=AL_SetArraysNam (xALP_ItemsACT;12;1;"asACT_CentroCCta")

  //column 1 settings
AL_SetHeaders (xALP_ItemsACT;1;1;__ ("Glosa"))
AL_SetWidths (xALP_ItemsACT;1;1;139)
AL_SetFormat (xALP_ItemsACT;1;"";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsACT;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsACT;1;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsACT;1;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsACT;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsACT;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsACT;1;0)
AL_SetEntryCtls (xALP_ItemsACT;1;0)

  //column 2 settings
AL_SetHeaders (xALP_ItemsACT;2;1;__ ("Moneda"))
AL_SetWidths (xALP_ItemsACT;2;1;85)
AL_SetFormat (xALP_ItemsACT;2;"";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsACT;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsACT;2;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsACT;2;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsACT;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsACT;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsACT;2;0)
AL_SetEntryCtls (xALP_ItemsACT;2;0)

  //column 3 settings
AL_SetHeaders (xALP_ItemsACT;3;1;__ ("Monto"))
AL_SetWidths (xALP_ItemsACT;3;1;50)
AL_SetFormat (xALP_ItemsACT;3;"|Despliegue_ACT";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsACT;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsACT;3;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsACT;3;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsACT;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsACT;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsACT;3;0)
AL_SetEntryCtls (xALP_ItemsACT;3;0)

  //column 4 settings
AL_SetHeaders (xALP_ItemsACT;4;1;__ ("Afecto a\rIVA"))
AL_SetWidths (xALP_ItemsACT;4;1;50)
AL_SetFormat (xALP_ItemsACT;4;"1";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsACT;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsACT;4;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsACT;4;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsACT;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsACT;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsACT;4;0)
AL_SetEntryCtls (xALP_ItemsACT;4;0)

  //general options
ALP_SetDefaultAppareance (xALP_ItemsACT;9;1;6;2;8)
AL_SetColOpts (xALP_ItemsACT;1;1;1;8;0)
AL_SetRowOpts (xALP_ItemsACT;0;0;0;0;1;0)
AL_SetCellOpts (xALP_ItemsACT;0;1;1)
AL_SetMainCalls (xALP_ItemsACT;"";"")
AL_SetScroll (xALP_ItemsACT;0;-3)
AL_SetEntryOpts (xALP_ItemsACT;1;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_ItemsACT;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_ItemsACT;1;String:C10(xALP_ItemsACT))

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_ModelosAvisos;1;1;"apACT_ModeloSel")
$Error:=AL_SetArraysNam (xALP_ModelosAvisos;2;1;"atACT_ModelosAviso")
$Error:=AL_SetArraysNam (xALP_ModelosAvisos;3;1;"abACT_ModeloSel")

  //column 1 settings
AL_SetHeaders (xALP_ModelosAvisos;1;1;"")
AL_SetFormat (xALP_ModelosAvisos;1;"1";0;0;0;0)
AL_SetWidths (xALP_ModelosAvisos;1;1;15)
AL_SetHdrStyle (xALP_ModelosAvisos;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ModelosAvisos;1;"Tahoma";9;0)
AL_SetStyle (xALP_ModelosAvisos;1;"Tahoma";9;0)
AL_SetForeColor (xALP_ModelosAvisos;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ModelosAvisos;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ModelosAvisos;1;0)
AL_SetEntryCtls (xALP_ModelosAvisos;1;0)

  //column 2 settings
AL_SetHeaders (xALP_ModelosAvisos;2;1;__ ("Modelo"))
AL_SetFormat (xALP_ModelosAvisos;2;"";0;0;0;0)
AL_SetWidths (xALP_ModelosAvisos;2;1;309)
AL_SetHdrStyle (xALP_ModelosAvisos;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ModelosAvisos;2;"Tahoma";9;0)
AL_SetStyle (xALP_ModelosAvisos;2;"Tahoma";9;0)
AL_SetForeColor (xALP_ModelosAvisos;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ModelosAvisos;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ModelosAvisos;2;0)
AL_SetEntryCtls (xALP_ModelosAvisos;2;0)

  //column 3 settings
AL_SetHeaders (xALP_ModelosAvisos;3;1;"")
AL_SetFormat (xALP_ModelosAvisos;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_ModelosAvisos;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ModelosAvisos;3;"Tahoma";9;0)
AL_SetStyle (xALP_ModelosAvisos;3;"Tahoma";9;0)
AL_SetForeColor (xALP_ModelosAvisos;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ModelosAvisos;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ModelosAvisos;3;0)
AL_SetEntryCtls (xALP_ModelosAvisos;3;0)

  //general options
ALP_SetDefaultAppareance (xALP_ModelosAvisos;9;1;6;2;8)
AL_SetColOpts (xALP_ModelosAvisos;0;1;1;1;0)
AL_SetRowOpts (xALP_ModelosAvisos;0;0;0;0;1;1)
AL_SetCellOpts (xALP_ModelosAvisos;0;1;1)
AL_SetMiscOpts (xALP_ModelosAvisos;0;0;"\\";0;1)
AL_SetMainCalls (xALP_ModelosAvisos;"";"")
AL_SetScroll (xALP_ModelosAvisos;0;-3)
AL_SetEntryOpts (xALP_ModelosAvisos;0;0;0;0;0;".")
AL_SetDrgOpts (xALP_ModelosAvisos;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_ModelosAvisos;1;"";"";"")
AL_SetDrgSrc (xALP_ModelosAvisos;2;"";"";"")
AL_SetDrgSrc (xALP_ModelosAvisos;3;"";"";"")
AL_SetDrgDst (xALP_ModelosAvisos;1;"";"";"")
AL_SetDrgDst (xALP_ModelosAvisos;1;"";"";"")
AL_SetDrgDst (xALP_ModelosAvisos;1;"";"";"")


$error:=AL_SetArraysNam (xALP_ItemsCandidato;1;1;"atADT_GlosaCandidato")
$error:=AL_SetArraysNam (xALP_ItemsCandidato;2;1;"atADT_MonedaCandidato")
$error:=AL_SetArraysNam (xALP_ItemsCandidato;3;1;"arADT_MontoCandidato")
$error:=AL_SetArraysNam (xALP_ItemsCandidato;4;1;"apADT_IVACandidato")
$error:=AL_SetArraysNam (xALP_ItemsCandidato;5;1;"abADT_IVACandidato")
$error:=AL_SetArraysNam (xALP_ItemsCandidato;6;1;"alADT_IDCandidato")
$error:=AL_SetArraysNam (xALP_ItemsCandidato;7;1;"asADT_CtaCtaCandidato")
$error:=AL_SetArraysNam (xALP_ItemsCandidato;8;1;"asADT_CodAuxCtaCandidato")
$error:=AL_SetArraysNam (xALP_ItemsCandidato;9;1;"asADT_CentroCtaCandidato")
$error:=AL_SetArraysNam (xALP_ItemsCandidato;10;1;"asADT_CtaCCtaCandidato")
$error:=AL_SetArraysNam (xALP_ItemsCandidato;11;1;"asADT_CodAuxCCtaCandidato")
$error:=AL_SetArraysNam (xALP_ItemsCandidato;12;1;"asADT_CentroCCtaCandidato")

  //column 1 settings
AL_SetHeaders (xALP_ItemsCandidato;1;1;__ ("Glosa"))
AL_SetWidths (xALP_ItemsCandidato;1;1;139)
AL_SetFormat (xALP_ItemsCandidato;1;"";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsCandidato;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsCandidato;1;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsCandidato;1;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsCandidato;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsCandidato;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsCandidato;1;0)
AL_SetEntryCtls (xALP_ItemsCandidato;1;0)

  //column 2 settings
AL_SetHeaders (xALP_ItemsCandidato;2;1;__ ("Moneda"))
AL_SetWidths (xALP_ItemsCandidato;2;1;85)
AL_SetFormat (xALP_ItemsCandidato;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_ItemsCandidato;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsCandidato;2;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsCandidato;2;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsCandidato;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsCandidato;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsCandidato;2;2;atACT_NombreMoneda)
AL_SetEntryCtls (xALP_ItemsCandidato;2;0)

  //column 3 settings
AL_SetHeaders (xALP_ItemsCandidato;3;1;__ ("Monto"))
AL_SetWidths (xALP_ItemsCandidato;3;1;50)
AL_SetFormat (xALP_ItemsCandidato;3;"|Despliegue_ACT";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsCandidato;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsCandidato;3;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsCandidato;3;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsCandidato;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsCandidato;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsCandidato;3;1)
AL_SetEntryCtls (xALP_ItemsCandidato;3;0)

  //column 4 settings
AL_SetHeaders (xALP_ItemsCandidato;4;1;__ ("Afecto a\rIVA"))
AL_SetWidths (xALP_ItemsCandidato;4;1;50)
AL_SetFormat (xALP_ItemsCandidato;4;"1";0;2;0;0)
AL_SetHdrStyle (xALP_ItemsCandidato;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ItemsCandidato;4;"Tahoma";9;0)
AL_SetStyle (xALP_ItemsCandidato;4;"Tahoma";9;0)
AL_SetForeColor (xALP_ItemsCandidato;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ItemsCandidato;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_ItemsCandidato;4;1)
AL_SetEntryCtls (xALP_ItemsCandidato;4;0)

  //general options
ALP_SetDefaultAppareance (xALP_ItemsCandidato;9;1;6;2;8)
AL_SetColOpts (xALP_ItemsCandidato;1;1;1;8;0)
AL_SetRowOpts (xALP_ItemsCandidato;0;1;0;0;1;0)
AL_SetCellOpts (xALP_ItemsCandidato;0;1;1)
AL_SetMainCalls (xALP_ItemsCandidato;"";"")
AL_SetScroll (xALP_ItemsCandidato;0;-3)
AL_SetEntryOpts (xALP_ItemsCandidato;3;0;0;1;2;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_ItemsCandidato;0;30;0)

  //dragging options

AL_SetDrgDst (xALP_ItemsCandidato;1;String:C10(xALP_ItemsADT);String:C10(xALP_ItemsACT))
