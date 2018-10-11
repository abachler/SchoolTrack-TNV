//%attributes = {}
  //xALSet_CC_ACT_AreaTransacciones

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Transacciones;1;1;"aACT_TipoTransaccion")
$Error:=AL_SetArraysNam (xALP_Transacciones;2;1;"aACT_CtasTFecha")
$Error:=AL_SetArraysNam (xALP_Transacciones;3;1;"aACT_CtasTPeriodo")
$Error:=AL_SetArraysNam (xALP_Transacciones;4;1;"aACT_CtasTGlosa")
$Error:=AL_SetArraysNam (xALP_Transacciones;5;1;"aACT_CtasTDebito")
$Error:=AL_SetArraysNam (xALP_Transacciones;6;1;"aACT_CtasTCredito")
$Error:=AL_SetArraysNam (xALP_Transacciones;7;1;"aACT_CtasTMoneda")
$Error:=AL_SetArraysNam (xALP_Transacciones;8;1;"apACT_CtasTAfecta")
$Error:=AL_SetArraysNam (xALP_Transacciones;9;1;"aACT_CtasTBoleta")
$Error:=AL_SetArraysNam (xALP_Transacciones;10;1;"aACT_CtasTRefItem")
$Error:=AL_SetArraysNam (xALP_Transacciones;11;1;"aACT_ItemIDs")

  //column 1 settings
AL_SetHeaders (xALP_Transacciones;1;1;__ ("Tipo"))
AL_SetWidths (xALP_Transacciones;1;1;40)
AL_SetFormat (xALP_Transacciones;1;"";0;2;0;0)
AL_SetHdrStyle (xALP_Transacciones;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Transacciones;1;"Tahoma";9;0)
AL_SetStyle (xALP_Transacciones;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Transacciones;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Transacciones;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Transacciones;1;1)
AL_SetEntryCtls (xALP_Transacciones;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Transacciones;2;1;__ ("Fecha"))
AL_SetWidths (xALP_Transacciones;2;1;60)
AL_SetFormat (xALP_Transacciones;2;"";0;2;0;0)
AL_SetHdrStyle (xALP_Transacciones;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Transacciones;2;"Tahoma";9;0)
AL_SetStyle (xALP_Transacciones;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Transacciones;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Transacciones;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Transacciones;2;1)
AL_SetEntryCtls (xALP_Transacciones;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Transacciones;3;1;__ ("Período"))
AL_SetWidths (xALP_Transacciones;3;1;60)
AL_SetFormat (xALP_Transacciones;3;"";0;2;0;0)
AL_SetHdrStyle (xALP_Transacciones;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Transacciones;3;"Tahoma";9;0)
AL_SetStyle (xALP_Transacciones;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Transacciones;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Transacciones;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Transacciones;3;1)
AL_SetEntryCtls (xALP_Transacciones;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Transacciones;4;1;__ ("Glosa"))
AL_SetWidths (xALP_Transacciones;4;1;260)
AL_SetFormat (xALP_Transacciones;4;"";0;2;0;0)
AL_SetHdrStyle (xALP_Transacciones;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Transacciones;4;"Tahoma";9;0)
AL_SetStyle (xALP_Transacciones;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Transacciones;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Transacciones;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Transacciones;4;1)
AL_SetEntryCtls (xALP_Transacciones;4;0)

  //column 5 settings
AL_SetHeaders (xALP_Transacciones;5;1;__ ("Débito"))
AL_SetWidths (xALP_Transacciones;5;1;72)
AL_SetFormat (xALP_Transacciones;5;"|Despliegue_ACT";0;2;0;0)
AL_SetHdrStyle (xALP_Transacciones;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Transacciones;5;"Tahoma";9;0)
AL_SetStyle (xALP_Transacciones;5;"Tahoma";9;0)
AL_SetForeColor (xALP_Transacciones;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Transacciones;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Transacciones;5;1)
AL_SetEntryCtls (xALP_Transacciones;5;0)

  //column 6 settings
AL_SetHeaders (xALP_Transacciones;6;1;__ ("Crédito"))
AL_SetWidths (xALP_Transacciones;6;1;72)
AL_SetFormat (xALP_Transacciones;6;"|Despliegue_ACT";0;2;0;0)
AL_SetHdrStyle (xALP_Transacciones;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Transacciones;6;"Tahoma";9;0)
AL_SetStyle (xALP_Transacciones;6;"Tahoma";9;0)
AL_SetForeColor (xALP_Transacciones;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Transacciones;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Transacciones;6;1)
AL_SetEntryCtls (xALP_Transacciones;6;0)

  //column 7 settings
AL_SetHeaders (xALP_Transacciones;7;1;__ ("Moneda"))
AL_SetWidths (xALP_Transacciones;7;1;70)
AL_SetFormat (xALP_Transacciones;7;"1";0;2;0;0)
AL_SetHdrStyle (xALP_Transacciones;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Transacciones;7;"Tahoma";9;0)
AL_SetStyle (xALP_Transacciones;7;"Tahoma";9;0)
AL_SetForeColor (xALP_Transacciones;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Transacciones;7;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Transacciones;7;1)
AL_SetEntryCtls (xALP_Transacciones;7;0)

  //column 8 settings
AL_SetHeaders (xALP_Transacciones;8;1;__ ("Afecta IVA"))
AL_SetWidths (xALP_Transacciones;8;1;70)
AL_SetFormat (xALP_Transacciones;8;"1";0;2;0;0)
AL_SetHdrStyle (xALP_Transacciones;8;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Transacciones;8;"Tahoma";9;0)
AL_SetStyle (xALP_Transacciones;8;"Tahoma";9;0)
AL_SetForeColor (xALP_Transacciones;8;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Transacciones;8;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Transacciones;8;1)
AL_SetEntryCtls (xALP_Transacciones;8;0)

  //column 9 settings
AL_SetHeaders (xALP_Transacciones;9;1;__ ("Doc. Trib."))
AL_SetWidths (xALP_Transacciones;9;1;115)
AL_SetFormat (xALP_Transacciones;9;"|Long";0;2;0;0)
AL_SetHdrStyle (xALP_Transacciones;9;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Transacciones;9;"Tahoma";9;0)
AL_SetStyle (xALP_Transacciones;9;"Tahoma";9;0)
AL_SetForeColor (xALP_Transacciones;9;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Transacciones;9;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Transacciones;9;1)
AL_SetEntryCtls (xALP_Transacciones;9;0)

  //column 10 settings
AL_SetHeaders (xALP_Transacciones;10;1;"Ref")
AL_SetFormat (xALP_Transacciones;10;"#####";0;2;0;0)
AL_SetHdrStyle (xALP_Transacciones;10;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Transacciones;10;"Tahoma";9;0)
AL_SetStyle (xALP_Transacciones;10;"Tahoma";9;0)
AL_SetForeColor (xALP_Transacciones;10;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Transacciones;10;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Transacciones;10;1)
AL_SetEntryCtls (xALP_Transacciones;10;0)

  //column 11 settings
AL_SetHeaders (xALP_Transacciones;11;1;"ID Item")
AL_SetFormat (xALP_Transacciones;11;"#####";0;2;0;0)
AL_SetHdrStyle (xALP_Transacciones;11;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Transacciones;11;"Tahoma";9;0)
AL_SetStyle (xALP_Transacciones;11;"Tahoma";9;0)
AL_SetForeColor (xALP_Transacciones;11;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Transacciones;11;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Transacciones;11;1)
AL_SetEntryCtls (xALP_Transacciones;11;0)

  //general options
ALP_SetDefaultAppareance (xALP_Transacciones;9;1;6;1;8)
AL_SetColOpts (xALP_Transacciones;1;1;1;2;0)
AL_SetRowOpts (xALP_Transacciones;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Transacciones;0;1;1)
AL_SetMiscOpts (xALP_Transacciones;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Transacciones;"";"")
AL_SetEntryOpts (xALP_Transacciones;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Transacciones;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_Transacciones;1;"";"";"")
AL_SetDrgSrc (xALP_Transacciones;2;"";"";"")
AL_SetDrgSrc (xALP_Transacciones;3;"";"";"")
AL_SetDrgDst (xALP_Transacciones;1;"";"";"")
AL_SetDrgDst (xALP_Transacciones;1;"";"";"")
AL_SetDrgDst (xALP_Transacciones;1;"";"";"")

