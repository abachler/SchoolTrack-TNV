//%attributes = {}
  //xALSet_ACT_ConfigItems2

C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Items2;1;1;"alACT_IDItem")
$Error:=AL_SetArraysNam (xALP_Items2;2;1;"atACT_GlosaItem")
$Error:=AL_SetArraysNam (xALP_Items2;3;1;"apACT_AfectoIVA")
$Error:=AL_SetArraysNam (xALP_Items2;4;1;"arACT_AmountItem")
$Error:=AL_SetArraysNam (xALP_Items2;5;1;"atACT_MonedaItemDef")
$Error:=AL_SetArraysNam (xALP_Items2;6;1;"abACT_IsDiscountItem")
$Error:=AL_SetArraysNam (xALP_Items2;7;1;"abACT_IsPercentItem")
$Error:=AL_SetArraysNam (xALP_Items2;8;1;"abACT_AfectoIVA")

  //column 1 settings
AL_SetHeaders (xALP_Items2;1;1;__ ("ID"))
AL_SetWidths (xALP_Items2;1;1;30)
AL_SetFormat (xALP_Items2;1;"#####0";0;2;0;0)
AL_SetHdrStyle (xALP_Items2;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Items2;1;"Tahoma";9;0)
AL_SetStyle (xALP_Items2;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Items2;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Items2;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Items2;1;1)
AL_SetEntryCtls (xALP_Items2;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Items2;2;1;__ ("Glosa"))
AL_SetWidths (xALP_Items2;2;1;180)
AL_SetFormat (xALP_Items2;2;"";0;2;0;0)
AL_SetHdrStyle (xALP_Items2;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Items2;2;"Tahoma";9;0)
AL_SetStyle (xALP_Items2;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Items2;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Items2;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Items2;2;1)
AL_SetEntryCtls (xALP_Items2;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Items2;3;1;__ ("Afecto a IVA"))
AL_SetWidths (xALP_Items2;3;1;75)
AL_SetFormat (xALP_Items2;3;"1";0;2;0;0)
AL_SetHdrStyle (xALP_Items2;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Items2;3;"Tahoma";9;0)
AL_SetStyle (xALP_Items2;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Items2;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Items2;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Items2;3;1)
AL_SetEntryCtls (xALP_Items2;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Items2;4;1;__ ("Monto o %"))
AL_SetWidths (xALP_Items2;4;1;70)
AL_SetFormat (xALP_Items2;4;"|Despliegue_ACT";0;2;0;0)
AL_SetHdrStyle (xALP_Items2;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Items2;4;"Tahoma";9;0)
AL_SetStyle (xALP_Items2;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Items2;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Items2;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Items2;4;1)
AL_SetEntryCtls (xALP_Items2;4;0)

  //column 5 settings
AL_SetHeaders (xALP_Items2;5;1;__ ("Moneda"))
AL_SetWidths (xALP_Items2;5;1;80)
AL_SetFormat (xALP_Items2;5;"";0;2;0;0)
AL_SetHdrStyle (xALP_Items2;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Items2;5;"Tahoma";9;0)
AL_SetStyle (xALP_Items2;5;"Tahoma";9;0)
AL_SetForeColor (xALP_Items2;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Items2;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Items2;5;1)
AL_SetEntryCtls (xALP_Items2;5;0)

  //column 6 settings
AL_SetHeaders (xALP_Items2;6;1;"Es descuento (hidden)")
AL_SetFormat (xALP_Items2;6;"";0;2;0;0)
AL_SetHdrStyle (xALP_Items2;6;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Items2;6;"Tahoma";9;0)
AL_SetStyle (xALP_Items2;6;"Tahoma";9;0)
AL_SetForeColor (xALP_Items2;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Items2;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Items2;6;1)
AL_SetEntryCtls (xALP_Items2;6;0)

  //column 7 settings
AL_SetHeaders (xALP_Items2;7;1;"Is Percent (hidden)")
AL_SetWidths (xALP_Items2;7;1;30)
AL_SetFormat (xALP_Items2;7;"";0;2;0;0)
AL_SetHdrStyle (xALP_Items2;7;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Items2;7;"Tahoma";9;0)
AL_SetStyle (xALP_Items2;7;"Tahoma";9;0)
AL_SetForeColor (xALP_Items2;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Items2;7;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Items2;7;1)
AL_SetEntryCtls (xALP_Items2;7;0)

  //column 8 settings
AL_SetHeaders (xALP_Items2;8;1;"Afecta")
AL_SetWidths (xALP_Items2;8;1;30)
AL_SetFormat (xALP_Items2;8;"";0;2;0;0)
AL_SetHdrStyle (xALP_Items2;8;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Items2;8;"Tahoma";9;0)
AL_SetStyle (xALP_Items2;8;"Tahoma";9;0)
AL_SetForeColor (xALP_Items2;8;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Items2;8;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Items2;8;1)
AL_SetEntryCtls (xALP_Items2;8;0)

  //general options
ALP_SetDefaultAppareance (xALP_Items2;9;1;6;1;8)
AL_SetColOpts (xALP_Items2;1;1;1;3;0)
AL_SetRowOpts (xALP_Items2;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Items2;0;1;1)
AL_SetMainCalls (xALP_Items2;"";"")
AL_SetScroll (xALP_Items2;0;-3)
AL_SetEntryOpts (xALP_Items2;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Items2;0;30;0)

  //dragging options
AL_SetDrgSrc (xALP_Items2;1;String:C10(xALP_Items2))
AL_SetDrgDst (xALP_Items2;1;String:C10(xALP_ItemsMatriz))