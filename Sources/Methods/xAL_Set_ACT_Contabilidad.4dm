//%attributes = {}
  //xAL_Set_ACT_Contabilidad

ACTcfg_OpcionesContabilidad ("DeclaraArreglosCuentasContables")
ACTcfg_OpcionesContabilidad ("DeclaraArreglosCentrosCosto")
ACTcfg_OpcionesContabilidad ("DeclaraArreglosCuentasEspeciales")

$error:=AL_SetArraysNam (xALP_Cuentas;1;1;"<>asACT_GlosaCta")
$error:=AL_SetArraysNam (xALP_Cuentas;2;1;"<>asACT_CuentaCta")
$error:=AL_SetArraysNam (xALP_Cuentas;3;1;"<>asACT_CodAuxCta")
$error:=AL_SetArraysNam (xALP_Cuentas;4;1;"<>alACT_idCta")

  //column 1 settings
AL_SetHeaders (xALP_Cuentas;1;1;__ ("Glosa"))
AL_SetFormat (xALP_Cuentas;1;"";0;0;0;0)
AL_SetWidths (xALP_Cuentas;1;1;250)
AL_SetHdrStyle (xALP_Cuentas;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Cuentas;1;"Tahoma";9;0)
AL_SetStyle (xALP_Cuentas;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Cuentas;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Cuentas;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Cuentas;1;1)
AL_SetEntryCtls (xALP_Cuentas;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Cuentas;2;1;__ ("Código"))
AL_SetFormat (xALP_Cuentas;2;"";0;0;0;0)
AL_SetWidths (xALP_Cuentas;2;1;153)
AL_SetHdrStyle (xALP_Cuentas;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Cuentas;2;"Tahoma";9;0)
AL_SetStyle (xALP_Cuentas;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Cuentas;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Cuentas;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Cuentas;2;1)
AL_SetEntryCtls (xALP_Cuentas;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Cuentas;3;1;__ ("Código Aux."))
AL_SetFormat (xALP_Cuentas;3;"";0;0;0;0)
AL_SetWidths (xALP_Cuentas;3;1;153)
AL_SetHdrStyle (xALP_Cuentas;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Cuentas;3;"Tahoma";9;0)
AL_SetStyle (xALP_Cuentas;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Cuentas;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Cuentas;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Cuentas;3;1)
AL_SetEntryCtls (xALP_Cuentas;3;0)

  //general options
ALP_SetDefaultAppareance (xALP_Cuentas;9;1;6;1;8)
AL_SetColOpts (xALP_Cuentas;1;1;1;1;0)
AL_SetRowOpts (xALP_Cuentas;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Cuentas;0;1;1)
AL_SetMiscOpts (xALP_Cuentas;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Cuentas;"";"")
AL_SetCallbacks (xALP_Cuentas;"";"")
AL_SetScroll (xALP_Cuentas;0;-3)
AL_SetEntryOpts (xALP_Cuentas;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_Cuentas;0;30;0)

$error:=ALP_DefaultColSettings (xALP_Centros;1;"<>atACT_CentroGlosa";__ ("Glosa");116;"";0;0;1)
$error:=AL_SetArraysNam (xALP_Centros;2;1;"<>asACT_Centro")
$error:=AL_SetArraysNam (xALP_Centros;3;1;"<>alACT_idCentro")

  //column 1 settings
AL_SetHeaders (xALP_Centros;2;1;__ ("Código"))
AL_SetFormat (xALP_Centros;2;"";0;0;0;0)
AL_SetWidths (xALP_Centros;2;1;70)
AL_SetHdrStyle (xALP_Centros;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Centros;2;"Tahoma";9;0)
AL_SetStyle (xALP_Centros;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Centros;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Centros;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Centros;2;1)
AL_SetEntryCtls (xALP_Centros;2;0)

  //general options
ALP_SetDefaultAppareance (xALP_Centros;9;1;6;2;8)
AL_SetColOpts (xALP_Centros;1;1;1;1;0)
AL_SetRowOpts (xALP_Centros;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Centros;0;1;1)
AL_SetMiscOpts (xALP_Centros;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Centros;"";"")
AL_SetCallbacks (xALP_Centros;"";"xAL_ACT_CB_CentrosCosto")
AL_SetScroll (xALP_Centros;0;-3)
AL_SetEntryOpts (xALP_Centros;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_Centros;0;30;0)

$error:=AL_SetArraysNam (xALP_CtasEspeciales;1;1;"atACT_CtasEspecialesGlosa")
$error:=AL_SetArraysNam (xALP_CtasEspeciales;2;1;"asACT_CtasEspecialesCta")
$error:=AL_SetArraysNam (xALP_CtasEspeciales;3;1;"asACT_CtasEspecialesCentro")

$error:=ALP_DefaultColSettings (xALP_CtasEspeciales;4;"alACT_idCtaEspecial")
$error:=ALP_DefaultColSettings (xALP_CtasEspeciales;5;"alACT_idCtasEspeciales")
$error:=ALP_DefaultColSettings (xALP_CtasEspeciales;6;"alACT_idCentroEspeciales")

  //column 1 settings
AL_SetHeaders (xALP_CtasEspeciales;1;1;__ ("Glosa"))
AL_SetFormat (xALP_CtasEspeciales;1;"";0;0;0;0)
AL_SetWidths (xALP_CtasEspeciales;1;1;116)
AL_SetHdrStyle (xALP_CtasEspeciales;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_CtasEspeciales;1;"Tahoma";9;0)
AL_SetStyle (xALP_CtasEspeciales;1;"Tahoma";9;0)
AL_SetForeColor (xALP_CtasEspeciales;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CtasEspeciales;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_CtasEspeciales;1;1)
AL_SetEntryCtls (xALP_CtasEspeciales;1;0)

  //column 2 settings
AL_SetHeaders (xALP_CtasEspeciales;2;1;__ ("Código Plan de Cuentas"))
AL_SetFormat (xALP_CtasEspeciales;2;"";0;0;0;0)
AL_SetWidths (xALP_CtasEspeciales;2;1;100)
AL_SetHdrStyle (xALP_CtasEspeciales;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_CtasEspeciales;2;"Tahoma";9;0)
AL_SetStyle (xALP_CtasEspeciales;2;"Tahoma";9;0)
AL_SetForeColor (xALP_CtasEspeciales;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CtasEspeciales;2;"White";0;"White";0;"White";0)
  //20121031 RCH Se colocara un menu
  //AL_SetEnterable (xALP_CtasEspeciales;2;2;<>asACT_CuentaCta)
AL_SetEnterable (xALP_CtasEspeciales;2;0)

AL_SetEntryCtls (xALP_CtasEspeciales;2;0)

  //column 3 settings
AL_SetHeaders (xALP_CtasEspeciales;3;1;__ ("Código Centro de Costos"))
AL_SetFormat (xALP_CtasEspeciales;3;"";0;0;0;0)
AL_SetWidths (xALP_CtasEspeciales;3;1;100)
AL_SetHdrStyle (xALP_CtasEspeciales;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_CtasEspeciales;3;"Tahoma";9;0)
AL_SetStyle (xALP_CtasEspeciales;3;"Tahoma";9;0)
AL_SetForeColor (xALP_CtasEspeciales;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_CtasEspeciales;3;"White";0;"White";0;"White";0)
  //20121031 RCH Se colocara un menu
  //AL_SetEnterable (xALP_CtasEspeciales;3;2;<>asACT_Centro)
AL_SetEnterable (xALP_CtasEspeciales;3;0)
AL_SetEntryCtls (xALP_CtasEspeciales;3;0)

  //general options
ALP_SetDefaultAppareance (xALP_CtasEspeciales;9;1;6;2;8)
AL_SetColOpts (xALP_CtasEspeciales;1;1;1;3;0)
AL_SetRowOpts (xALP_CtasEspeciales;0;0;0;0;1;0)
AL_SetCellOpts (xALP_CtasEspeciales;0;1;1)
AL_SetMiscOpts (xALP_CtasEspeciales;0;0;"\\";0;1)
AL_SetMainCalls (xALP_CtasEspeciales;"";"")
AL_SetCallbacks (xALP_CtasEspeciales;"";"xAL_ACT_CB_CuentasEspeciales")
AL_SetScroll (xALP_CtasEspeciales;0;-3)
  //20121031 RCH Se colocara un menu
  //AL_SetEntryOpts (xALP_CtasEspeciales;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetEntryOpts (xALP_CtasEspeciales;5;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_CtasEspeciales;0;30;0)
