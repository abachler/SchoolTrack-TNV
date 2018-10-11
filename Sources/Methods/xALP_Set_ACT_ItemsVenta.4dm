//%attributes = {}
  //xALP_Set_ACT_ItemsVenta
  //20130626 RCH NF CANTIDAD
ARRAY REAL:C219(arACT_CantidadVVR;0)
ARRAY TEXT:C222(atACT_GlosaVVR;0)
ARRAY REAL:C219(arACT_TotalVVR;0)
ARRAY LONGINT:C221(alACT_IDVVR;0)
ARRAY BOOLEAN:C223(abACT_AfectoIVAVVR;0)
ARRAY REAL:C219(arACT_DescuentoVVR;0)
ARRAY PICTURE:C279(apACT_AfectoIVAVVR;0)
C_LONGINT:C283($Error)

  //specify arrays to display
$Error:=AL_SetArraysNam (ALP_ItemsVentaRapida;1;1;"arACT_CantidadVVR")
$Error:=AL_SetArraysNam (ALP_ItemsVentaRapida;2;1;"atACT_GlosaVVR")
$Error:=AL_SetArraysNam (ALP_ItemsVentaRapida;3;1;"arACT_DescuentoVVR")
$Error:=AL_SetArraysNam (ALP_ItemsVentaRapida;4;1;"arACT_TotalVVR")
$Error:=AL_SetArraysNam (ALP_ItemsVentaRapida;5;1;"apACT_AfectoIVAVVR")
$Error:=AL_SetArraysNam (ALP_ItemsVentaRapida;6;1;"alACT_IDVVR")
$Error:=AL_SetArraysNam (ALP_ItemsVentaRapida;7;1;"abACT_AfectoIVAVVR")

  //column 1 settings
AL_SetHeaders (ALP_ItemsVentaRapida;1;1;__ ("Cantidad"))
AL_SetWidths (ALP_ItemsVentaRapida;1;1;60)
AL_SetFormat (ALP_ItemsVentaRapida;1;"|Real_1DecIfNec";0;0;0;0)
AL_SetHdrStyle (ALP_ItemsVentaRapida;1;"Tahoma";9;1)
AL_SetFtrStyle (ALP_ItemsVentaRapida;1;"Tahoma";9;0)
AL_SetStyle (ALP_ItemsVentaRapida;1;"Tahoma";9;0)
AL_SetForeColor (ALP_ItemsVentaRapida;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_ItemsVentaRapida;1;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_ItemsVentaRapida;1;1)
AL_SetEntryCtls (ALP_ItemsVentaRapida;1;0)

  //column 2 settings
AL_SetHeaders (ALP_ItemsVentaRapida;2;1;__ ("Glosa"))
AL_SetWidths (ALP_ItemsVentaRapida;2;1;449)
AL_SetFormat (ALP_ItemsVentaRapida;2;"";0;0;0;0)
AL_SetHdrStyle (ALP_ItemsVentaRapida;2;"Tahoma";9;1)
AL_SetFtrStyle (ALP_ItemsVentaRapida;2;"Tahoma";9;0)
AL_SetStyle (ALP_ItemsVentaRapida;2;"Tahoma";9;0)
AL_SetForeColor (ALP_ItemsVentaRapida;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_ItemsVentaRapida;2;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_ItemsVentaRapida;2;0)
AL_SetEntryCtls (ALP_ItemsVentaRapida;2;0)

  //column 3 settings
AL_SetHeaders (ALP_ItemsVentaRapida;3;1;__ ("Descuento"))
AL_SetWidths (ALP_ItemsVentaRapida;3;1;67)
AL_SetFormat (ALP_ItemsVentaRapida;3;"|Despliegue_ACT";0;0;0;0)
AL_SetHdrStyle (ALP_ItemsVentaRapida;3;"Tahoma";9;1)
AL_SetFtrStyle (ALP_ItemsVentaRapida;3;"Tahoma";9;0)
AL_SetStyle (ALP_ItemsVentaRapida;3;"Tahoma";9;0)
AL_SetForeColor (ALP_ItemsVentaRapida;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_ItemsVentaRapida;3;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_ItemsVentaRapida;3;1)
AL_SetEntryCtls (ALP_ItemsVentaRapida;3;0)

  //column 4 settings
AL_SetHeaders (ALP_ItemsVentaRapida;4;1;__ ("Total"))
AL_SetWidths (ALP_ItemsVentaRapida;4;1;100)
AL_SetFormat (ALP_ItemsVentaRapida;4;"|Despliegue_ACT";0;0;0;0)
AL_SetHdrStyle (ALP_ItemsVentaRapida;4;"Tahoma";9;1)
AL_SetFtrStyle (ALP_ItemsVentaRapida;4;"Tahoma";9;0)
AL_SetStyle (ALP_ItemsVentaRapida;4;"Tahoma";9;0)
AL_SetForeColor (ALP_ItemsVentaRapida;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_ItemsVentaRapida;4;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_ItemsVentaRapida;4;1)
AL_SetEntryCtls (ALP_ItemsVentaRapida;4;0)

  //column 5 settings
AL_SetHeaders (ALP_ItemsVentaRapida;5;1;__ ("Afecto IVA"))
AL_SetWidths (ALP_ItemsVentaRapida;5;1;69)
AL_SetFormat (ALP_ItemsVentaRapida;5;"1";0;0;0;0)
AL_SetHdrStyle (ALP_ItemsVentaRapida;5;"Tahoma";9;1)
AL_SetFtrStyle (ALP_ItemsVentaRapida;5;"Tahoma";9;0)
AL_SetStyle (ALP_ItemsVentaRapida;5;"Tahoma";9;0)
AL_SetForeColor (ALP_ItemsVentaRapida;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_ItemsVentaRapida;5;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_ItemsVentaRapida;5;0)
AL_SetEntryCtls (ALP_ItemsVentaRapida;5;0)

  //column 6 settings
AL_SetHeaders (ALP_ItemsVentaRapida;6;1;__ ("ID"))
AL_SetFormat (ALP_ItemsVentaRapida;6;"";0;0;0;0)
AL_SetHdrStyle (ALP_ItemsVentaRapida;6;"Tahoma";9;1)
AL_SetFtrStyle (ALP_ItemsVentaRapida;6;"Tahoma";9;0)
AL_SetStyle (ALP_ItemsVentaRapida;6;"Tahoma";9;0)
AL_SetForeColor (ALP_ItemsVentaRapida;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_ItemsVentaRapida;6;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_ItemsVentaRapida;6;1)
AL_SetEntryCtls (ALP_ItemsVentaRapida;6;0)

  //column 7 settings
AL_SetHeaders (ALP_ItemsVentaRapida;7;1;__ ("IVA"))
AL_SetFormat (ALP_ItemsVentaRapida;7;"";0;0;0;0)
AL_SetHdrStyle (ALP_ItemsVentaRapida;7;"Tahoma";9;1)
AL_SetFtrStyle (ALP_ItemsVentaRapida;7;"Tahoma";9;0)
AL_SetStyle (ALP_ItemsVentaRapida;7;"Tahoma";9;0)
AL_SetForeColor (ALP_ItemsVentaRapida;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (ALP_ItemsVentaRapida;7;"White";0;"White";0;"White";0)
AL_SetEnterable (ALP_ItemsVentaRapida;7;1)
AL_SetEntryCtls (ALP_ItemsVentaRapida;7;0)

  //general options
ALP_SetDefaultAppareance (ALP_ItemsVentaRapida;9;1;6;1;8)
AL_SetColOpts (ALP_ItemsVentaRapida;1;1;1;2;0)
AL_SetRowOpts (ALP_ItemsVentaRapida;0;0;0;0;1;0)
AL_SetCellOpts (ALP_ItemsVentaRapida;0;1;1)
AL_SetMiscOpts (ALP_ItemsVentaRapida;0;0;"\\";0;1)
AL_SetMainCalls (ALP_ItemsVentaRapida;"";"")
AL_SetCallbacks (ALP_ItemsVentaRapida;"";"xALP_ACT_CB_ItemsVenta")
AL_SetScroll (ALP_ItemsVentaRapida;0;-3)
AL_SetEntryOpts (ALP_ItemsVentaRapida;3;0;0;0;0;".")
AL_SetDrgOpts (ALP_ItemsVentaRapida;0;30;0)

  //dragging options

AL_SetDrgSrc (ALP_ItemsVentaRapida;1;String:C10(ALP_ItemsVentaRapida))
AL_SetDrgDst (ALP_ItemsVentaRapida;1;String:C10(ALP_ItemsRapidos))


